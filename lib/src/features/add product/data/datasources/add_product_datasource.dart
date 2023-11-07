import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as fStorage;
import 'package:flutter/foundation.dart';

import '../models/product_model.dart';

class ProductRepository {
  final _fireCloud = FirebaseFirestore.instance.collection('products');

  Future<void> addProduct(ProductModel product) async {
    try {
      await _fireCloud.add(product.toMap());
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print("Failed with error '${e.code}': ${e.message}");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<String> addProductImage(File imageFile) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();

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
