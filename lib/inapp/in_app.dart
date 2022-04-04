import 'dart:async';
import 'dart:io';

import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

import 'inapp_constants.dart';
import 'store.dart';

class InApp extends GetxController {
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  final RxList<String> _notFoundIds = <String>[].obs;
  final RxList<ProductDetails> _products = <ProductDetails>[].obs;
  final RxList<PurchaseDetails> _purchases = <PurchaseDetails>[].obs;

  final RxMap<String, List<String>> _consumables = <String, List<String>>{}.obs;
  final RxMap<String, bool> _nonConsumables = <String, bool>{}.obs;

  final RxBool _isAvailable = false.obs;

  final RxMap<String, ProductDetails> _mapProducts =
      <String, ProductDetails>{}.obs;

  // Test count----------
  final RxInt _count = 0.obs;
  int get count => _count.value;

  set count(int value) => _count.value = value;
  void add() {
    count += 1;
  }
  //----------------------

  List<String> get notFoundIds => _notFoundIds;
  List<ProductDetails> get products => _products;
  List<PurchaseDetails> get purchases => _purchases;
  Map<String, List<String>> get consumables => _consumables;
  bool get isAvailable => _isAvailable.value;
  Map<String, ProductDetails> get mapProducts => _mapProducts;
  Map<String, bool> get nonConsumables => _nonConsumables;

  set notFoundIds(List<String> value) => _notFoundIds.value = value;
  set products(List<ProductDetails> value) => _products.value = value;
  set purchases(List<PurchaseDetails> value) => _purchases.value = value;
  set consumables(Map<String, List<String>> value) =>
      _consumables.value = value;
  set isAvailable(bool value) => _isAvailable.value = value;

  Map<String, ProductDetails> _convertListProductsToMap() {
    Map<String, ProductDetails> result = {};
    for (ProductDetails productDetail in _products) {
      result[productDetail.id] = productDetail;
    }

    return result;
  }

  void init() async {
    final Stream<List<PurchaseDetails>> purchaseUpdated =
        _inAppPurchase.purchaseStream;

    _subscription = purchaseUpdated.listen((purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      _subscription.cancel();
    }, onError: (error) {
      // handle error here.
    });

    // Phải chờ (await) initStoreInfo xong thì mới gọi restorePreviousPurchases
    // để tránh trường hợp restorePreviousPurchases xong trước => map _nonConsumables
    // có dữ liệu nhưng sau đó initStoreInfo lại gán map _nonConsumables = {} rỗng
    await initStoreInfo();
    restorePreviousPurchases();
  }

  void cancel() {
    _subscription.cancel();
  }

  void deliverProduct(PurchaseDetails purchaseDetails) async {
    if (kConsumables.contains(purchaseDetails.productID)) {
      await Store.instance
          .doSave(purchaseDetails.productID, purchaseDetails.purchaseID!);

      _consumables.value = await Store.instance.getConsumables(kConsumables);
    } else {
      _purchases.add(purchaseDetails);
      _nonConsumables[purchaseDetails.productID] = true;
    }
  }

  void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    // ignore: avoid_function_literals_in_foreach_calls
    purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
      if (purchaseDetails.status != PurchaseStatus.pending) {
        if (purchaseDetails.status == PurchaseStatus.purchased ||
            purchaseDetails.status == PurchaseStatus.restored) {
          if (purchaseDetails.status == PurchaseStatus.restored) {}
          deliverProduct(purchaseDetails);
        }

        if (Platform.isAndroid) {
          if (purchaseDetails.pendingCompletePurchase) {
            await _inAppPurchase.completePurchase(purchaseDetails);

            // verifyPreviousPurchases();
          }
        }
      }
    });
  }

  Future<void> initStoreInfo() async {
    final bool isAvailable = await _inAppPurchase.isAvailable();

    if (!isAvailable) {
      _isAvailable.value = isAvailable;
      _products.value = [];
      _purchases.value = [];
      _notFoundIds.value = [];
      _consumables.value = {};
      _nonConsumables.value = {};

      return;
    }

    final ProductDetailsResponse productDetailResponse =
        await _inAppPurchase.queryProductDetails(kProductIds.toSet());

    if (productDetailResponse.error != null) {
      _isAvailable.value = isAvailable;
      _products.value = productDetailResponse.productDetails;
      _purchases.value = [];
      _notFoundIds.value = productDetailResponse.notFoundIDs;
      _consumables.value = {};
      _nonConsumables.value = {};

      return;
    }

    final consumables = await Store.instance.getConsumables(kConsumables);

    _isAvailable.value = isAvailable;
    _products.value = productDetailResponse.productDetails;
    _notFoundIds.value = productDetailResponse.notFoundIDs;
    _consumables.value = consumables;
    _mapProducts.value = _convertListProductsToMap();
  }

  void buyConsumable(String productId) {
    ProductDetails? productDetails = _mapProducts[productId];

    if (productDetails != null) {
      PurchaseParam purchaseParam = PurchaseParam(
        productDetails: productDetails,
        applicationUserName: null,
      );

      _inAppPurchase.buyConsumable(
        purchaseParam: purchaseParam,
        autoConsume: kAutoConsume,
      );
    }
  }

  void buyNonConsumable(String productId) {
    ProductDetails? productDetails = _mapProducts[productId];

    if (productDetails != null) {
      PurchaseParam purchaseParam = PurchaseParam(
        productDetails: productDetails,
        applicationUserName: null,
      );

      _inAppPurchase.buyNonConsumable(
        purchaseParam: purchaseParam,
      );
    }
  }

  String getPrice(String productId, {String notFoundPrice = "..."}) {
    return _mapProducts[productId]?.price ?? notFoundPrice;
  }

  int getConsumableCount(String productId, {int notFoundCount = 0}) {
    return _consumables[productId]?.length ?? notFoundCount;
  }

  void consumeLast(String productId) async {
    Store.instance.doConsumeLast(productId);

    _consumables.value = await Store.instance.getConsumables(kConsumables);
  }

  bool isProductAvailable(String productId) {
    return isAvailable && mapProducts[productId] != null;
  }

  void restorePreviousPurchases() async {
    try {
      await _inAppPurchase.restorePurchases();

      for (var purchase in _purchases) {
        _nonConsumables[purchase.productID] = true;
      }
    } on InAppPurchaseException {
      // print("Error when restore purchase");
    }
  }

  bool isNonConsumablePurchased(String productId) {
    return _nonConsumables[productId] ?? false;
  }
}
