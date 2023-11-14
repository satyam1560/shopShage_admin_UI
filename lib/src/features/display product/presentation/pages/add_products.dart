import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/datasources/display_product_datasource.dart';
import '../../data/models/product_model.dart';
import '../bloc/display_product_bloc.dart';
import '../widgets/custom_formfiels.dart';

class ProductCreateScreen extends StatefulWidget {
  const ProductCreateScreen({Key? key}) : super(key: key);

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

        if (downloadUrlImage.isNotEmpty) {
          context.read<ProductBloc>().add(AddProduct(
                product: Product(
                  title: titleController.text,
                  description: descriptionController.text,
                  productPrice: double.parse(priceController.text),
                  productImgUrl: downloadUrlImage,
                  productQuantity: int.parse(quantityController.text),
                ),
              ));

          Fluttertoast.showToast(msg: 'Product Added Successfully');
        } else {
          Fluttertoast.showToast(msg: 'Image upload failed');
        }
      } else {
        Fluttertoast.showToast(msg: 'No image is selected');
      }
    }
  }

  Future<void> getImageFromGallery() async {
    imageXFile = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
    );
    print('imgxfile------$imageXFile');
    setState(() {
      imageXFile;
    });
    // _addProductToFirebase(context);
  }

  Widget buildImageSection() {
    return GestureDetector(
      onTap: getImageFromGallery,
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
                  size: MediaQuery.of(context).size.width * 0.20,
                )
              : Image(
                  image: FileImage(File(imageXFile!.path)),
                  fit: BoxFit.cover,
                ),
        ),
      ),
    );
  }

  Widget buildFormField({
    int? maxLines,
    required bool autofocus,
    required TextEditingController controller,
    required String labelText,
    TextInputType? keyboardType,
    FormFieldValidator<String>? validator,
  }) {
    return CustomFormField(
      autofocus: autofocus,
      textEditingController: controller,
      labelText: labelText,
      keyboardType: keyboardType,
      validator: validator,
      maxLines: maxLines,
    );
  }

  Widget buildSubmitButton(bool isSubmitting) {
    return ElevatedButton(
      onPressed: isSubmitting ? null : () => _addProductToFirebase(context),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: isSubmitting
          ? const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            )
          : const Text('Add Product'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Products'),
      ),
      body: BlocConsumer<ProductBloc, ProductState>(
        listener: (context, state) {
          print('status********${state.productStatus}');
          if (state.productStatus == ProductStatus.success) {
            titleController.clear();
            descriptionController.clear();
            priceController.clear();
            quantityController.clear();
            setState(() {
              imageXFile = null;
            });
          } else if (state.productStatus == ProductStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.failure),
              ),
            );
          }
        },
        builder: (context, state) {
          bool isSubmitting = state.productStatus == ProductStatus.loading;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    buildImageSection(),
                    buildFormField(
                      autofocus: true,
                      controller: titleController,
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
                    buildFormField(
                      autofocus: true,
                      controller: descriptionController,
                      labelText: 'Description',
                      maxLines: 10,
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
                    buildFormField(
                      autofocus: true,
                      controller: priceController,
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
                    buildFormField(
                      autofocus: true,
                      controller: quantityController,
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
                    buildSubmitButton(isSubmitting),
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
