import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/datasources/add_product_datasource.dart';
import '../bloc/add_product_bloc.dart';
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
  final TextEditingController quantityController = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();
  XFile? imageXFile;

  Future<void> _addProductToFirebase(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      if (imageXFile != null) {
        String downloadUrlImage =
            await ProductRepository().addProductImage(File(imageXFile!.path));

        if (downloadUrlImage != null) {
          context.read<AddProductBloc>().add(AddProduct(
                title: titleController.text,
                description: descriptionController.text,
                productPrice: double.parse(priceController.text),
                productImgUrl: downloadUrlImage,
                productQuantity: int.parse(quantityController.text),
              ));
          Fluttertoast.showToast(msg: 'Product Added Sucessfully');
        } else {
          Fluttertoast.showToast(msg: 'Image upload failed');
        }
      } else {
        Fluttertoast.showToast(msg: 'No image is selected');
      }
    }
  }

  getImageFromGallery() async {
    imageXFile = await _imagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 70);
    print('imgxfile------$imageXFile');

    setState(() {
      imageXFile;
    });
    _addProductToFirebase;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Products'),
      ),
      body: BlocConsumer<AddProductBloc, AddProductState>(
        listener: (context, state) {
          if (state is AddProductLoadedState) {
            titleController.clear();
            descriptionController.clear();
            priceController.clear();
            quantityController.clear();

            setState(() {
              imageXFile = null;
            });
          } else if (state is AddProductErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
              ),
            );
          }
        },
        builder: (context, state) {
          bool isSubmitting = state is AddProductLoadingState;
          return Padding(
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
                          width: MediaQuery.of(context).size.width * 0.40,
                          height: MediaQuery.of(context).size.width * 0.40,
                          color: Colors.white,
                          child: imageXFile == null
                              ? Icon(
                                  Icons.add_photo_alternate,
                                  color: Colors.grey,
                                  size:
                                      MediaQuery.of(context).size.width * 0.20,
                                )
                              : Image(
                                  image: FileImage(File(imageXFile!.path)),
                                  fit: BoxFit.cover),
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
                      onPressed: isSubmitting
                          ? null
                          : () => _addProductToFirebase(context),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: isSubmitting
                          ? const CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            )
                          : const Text('Add Product'),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
