import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../inapp/in_app.dart';
import '../inapp/inapp_constants.dart';

class UpgradePage extends StatefulWidget {
  UpgradePage({Key? key}) : super(key: key);

  final inApp = Get.put(InApp());

  @override
  State<UpgradePage> createState() => _UpgradePageState();
}

class _UpgradePageState extends State<UpgradePage> {
  @override
  void initState() {
    super.initState();
    widget.inApp.init();
  }

  @override
  void dispose() {
    widget.inApp.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int index = 1;

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          "Upgrade",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: GridView(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 2 / 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          children: kConsumables.map((productId) {
            return PurchaseItem(
              name: "Item ${index++}",
              productId: productId,
            );
          }).toList(),
        ),
      ),
    );
  }
}

class PurchaseItem extends StatelessWidget {
  const PurchaseItem({
    Key? key,
    required this.name,
    required this.productId,
  }) : super(key: key);

  final String name;
  final String productId;

  @override
  Widget build(BuildContext context) {
    final InApp inApp = Get.find();

    return Obx(
      () => InkWell(
        onTap: () {
          inApp.buyConsumable(productId);
        },
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black38,
                  blurRadius: 2.0,
                  spreadRadius: 1.0,
                ),
              ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                "assets/images/icon.png",
                width: 100,
              ),
              Text(
                name,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 26,
                ),
              ),
              Text(
                inApp.getPrice(productId),
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 24,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
