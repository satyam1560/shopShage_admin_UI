import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/product_model.dart';

class DisplayProductRepository {
  Future<List<ProductObject>> getProducts() async {
    CollectionReference products =
        FirebaseFirestore.instance.collection('products');
    QuerySnapshot data = await products.get();
    print('querysnapshot-----${data.docs}');

    List<ProductObject> productList = [];

    for (var doc in data.docs) {
      Map<String, dynamic> productData = doc.data() as Map<String, dynamic>;
      print('product data------$productData');

      String productId = doc.id;

      print('productId------- $productId');
      ProductObject product = ProductObject.fromMap(productData);
      print('product-----$product');

      product.id = productId;
      productList.add(product);
    }
    print('productList-----$productList');

    return productList;
  }
}
