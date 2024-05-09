import 'dart:async';

import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:flutter/foundation.dart';

class PurchaseHelper {
  late InAppPurchase _connection;

  late StreamSubscription<List<PurchaseDetails>> _subscription;

  List<ProductDetails> products = [];
  List<String> purchasedProducts = [];

  var _productIds = {'buy_dev_coffee'};

  Future init() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      InAppPurchaseAndroidPlatformAddition.enablePendingPurchases();
    }

    _connection = InAppPurchase.instance;
    listen();

    await initStoreInfo();
  }

  void listen() {
    final Stream<List<PurchaseDetails>> purchaseUpdated =
        InAppPurchase.instance.purchaseStream;

    _subscription =
        purchaseUpdated.listen((List<PurchaseDetails> purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      _subscription.cancel();
    }, onError: (error) {
      print("error");
    });
  }

  initStoreInfo() async {
    ProductDetailsResponse productDetailResponse =
        await _connection.queryProductDetails(_productIds);

    if (productDetailResponse.error == null)
      products = productDetailResponse.productDetails;
  }

  _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
      switch (purchaseDetails.status) {
        case PurchaseStatus.pending:
          print("pending");
          break;

        case PurchaseStatus.error:
          print("error");
          break;

        case PurchaseStatus.purchased:
          purchasedProducts.add(purchaseDetails.productID);
          break;

        case PurchaseStatus.restored:
          purchasedProducts.add(purchaseDetails.productID);
          break;
        case PurchaseStatus.canceled:
          print("error");
          break;
      }
    });
  }

  void makePurchase(ProductDetails details) {
    final PurchaseParam purchaseParam = PurchaseParam(productDetails: details);
    _connection.buyConsumable(purchaseParam: purchaseParam);
  }
}