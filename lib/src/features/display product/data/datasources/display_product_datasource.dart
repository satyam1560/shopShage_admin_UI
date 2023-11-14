import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as fStorage;
import 'package:flutter/foundation.dart';

import '../models/product_model.dart';

class ProductRepository {
  CollectionReference products =
      FirebaseFirestore.instance.collection('products');

  Future<List<Product>> getProducts() async {
    List<Product> productList = [];

    QuerySnapshot data = await products.get();
    print('querysnapshot-----${data.docs}');

    for (var doc in data.docs) {
      Product product = Product.fromMap(doc.data() as Map<String, dynamic>);
      // print('product********$product');
      String productId = doc.id;
      product.id = productId;
      productList.add(product);
    }
    print('productList-----$productList');

    return productList;
  }

  Future<Product?> addProduct({required Product product}) async {
    try {
      await products.add(product.toMap());
      return product;
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print("Failed with error '${e.code}': ${e.message}");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
    return null;
  }

  Future<Product?> updateProduct({required Product product}) async {
    try {
      await products.doc(product.id).update(product.toMap());
      return product;
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print("Failed with error '${e.code}': ${e.message}");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
    return null;
  }

  void deleteProduct({required Product productToDelete}) async {
    try {
      await FirebaseFirestore.instance
          .collection('products')
          .doc(productToDelete.id)
          .delete();
      print('Product deleted successfully.');
    } catch (e) {
      print('Error deleting product: $e');
    }
  }

  Future<String> addProductImage(File imageFile) async {
    String fileName = '${DateTime.now().millisecondsSinceEpoch.toString()}.jpg';

    fStorage.Reference storageRef = fStorage.FirebaseStorage.instance
        .ref()
        .child("ProductImages")
        .child(fileName);

    fStorage.UploadTask uploadImageTask = storageRef.putFile(imageFile);

    fStorage.TaskSnapshot taskSnapshot =
        await uploadImageTask.whenComplete(() {});

    String downloadUrlImage = await taskSnapshot.ref.getDownloadURL();

    return downloadUrlImage; // Return the download URL
  }
}
