import 'spref.dart';

class Store {
  Store._internal();
  static final Store instance = Store._internal();

  Future<Map<String, List<String>>> getConsumables(
      List<String> consumableList) async {
    Map<String, List<String>> result = {};
    for (var consumable in consumableList) {
      result[consumable] = await SPref.instance.getStringList(consumable);
    }

    return result;
  }

  Future<void> doSave(String productId, String purchaseId) async {
    List<String> listPurchases = await SPref.instance.getStringList(productId);
    listPurchases.add(purchaseId);
    await SPref.instance.setStringList(productId, listPurchases);
  }

  Future<void> doConsumeWithPurchaseId(
      String productId, String purchaseId) async {
    List<String> listPurchases = await SPref.instance.getStringList(productId);
    listPurchases.remove(productId);

    await SPref.instance.setStringList(productId, listPurchases);
  }

  Future<void> doConsumeLast(String productId) async {
    List<String> listPurchases = await SPref.instance.getStringList(productId);

    if (listPurchases.isNotEmpty) {
      listPurchases.removeLast();

      await SPref.instance.setStringList(productId, listPurchases);
    }
  }
}
