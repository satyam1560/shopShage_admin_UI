import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/datasources/add_product_datasource.dart';
import '../../data/models/product_model.dart';
import '../widgets/custom_formfiels.dart';

class ProductCreateScreen extends StatefulWidget {
  const ProductCreateScreen({super.key});

  @override
  _ProductCreateScreenState createState() => _ProductCreateScreenState();
}

class _ProductCreateScreenState extends State<ProductCreateScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();
  XFile? imageXFile;

  Future<void> _addProductToFirebase(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      if (imageXFile != null) {
        String downloadUrlImage =
            await ProductRepository().addProductImage(File(imageXFile!.path));

        if (downloadUrlImage != null) {
          final product = ProductModel(
            title: titleController.text,
            description: descriptionController.text,
            productPrice: double.parse(priceController.text),
            productImgUrl: downloadUrlImage,
            productQuantity: int.parse(quantityController.text),
          );

          ProductRepository().addProduct(product);

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Product created successfully'),
            ),
          );
        } else {
          // Handle the case where the image upload failed
        }
      } else {
        // Handle the case where no image is selected
      }
    }
  }

  getImageFromGallery() async {
    imageXFile = await _imagePicker.pickImage(source: ImageSource.gallery);
    print('imgxfile------$imageXFile');

    setState(() {
      imageXFile;
    });
    _addProductToFirebase(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Products'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    getImageFromGallery();
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width *
                          0.40, // Set the width
                      height: MediaQuery.of(context).size.width *
                          0.40, // Set the height
                      color: Colors.white,
                      child: imageXFile == null
                          ? Icon(
                              Icons.add_photo_alternate,
                              color: Colors.grey,
                              size: MediaQuery.of(context).size.width * 0.20,
                            )
                          : Image(
                              image: FileImage(File(imageXFile!.path)),
                              fit: BoxFit
                                  .cover, // Adjust the fit based on your requirements
                            ),
                    ),
                  ),
                ),
                CustomFormField(
                  autofocus: true,
                  textEditingController: titleController,
                  labelText: 'Title',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a title';
                    }
                    if (value.split(' ').length > 25) {
                      return 'Title must be 25 words or less';
                    }
                    return null;
                  },
                ),
                CustomFormField(
                  maxLines: 10,
                  autofocus: true,
                  textEditingController: descriptionController,
                  labelText: 'Description',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a description';
                    }
                    if (value.split(' ').length > 150) {
                      return 'Description must be 100 words or less';
                    }
                    return null;
                  },
                ),
                CustomFormField(
                  autofocus: true,
                  textEditingController: priceController,
                  labelText: 'Price',
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a price';
                    }
                    final double price = double.tryParse(value) ?? -1;
                    if (price <= 0) {
                      return 'Please enter a valid, positive price';
                    }
                    return null;
                  },
                ),
                CustomFormField(
                  autofocus: true,
                  textEditingController: quantityController,
                  labelText: 'Quantity',
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a quantity';
                    }
                    final int quantity = int.tryParse(value) ?? -1;
                    if (quantity <= 0) {
                      return 'Please enter a valid, positive quantity';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 50),
                ElevatedButton(
                  onPressed: () {
                    _addProductToFirebase(context);
                  },
                  child: const Text('Add Product'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
