import 'package:ecommerce/src/features/display%20product/data/models/product_model.dart';
import 'package:ecommerce/src/features/display%20product/presentation/bloc/display_product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/custom_formfiels.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({super.key, required this.product});
  final Product? product;

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  // final _formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  @override
  void initState() {
    titleController.text = widget.product?.title ?? '';
    descriptionController.text = widget.product?.description ?? '';
    priceController.text = widget.product?.productPrice?.toString() ?? '';

    quantityController.text = widget.product?.productQuantity.toString() ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
      ),
      body: BlocConsumer<ProductBloc, ProductState>(
        listener: (context, state) {
          if (state.productStatus == ProductStatus.success) {
            Navigator.of(context).pop();
          }
        },
        builder: (context, state) {
          if (state.productStatus == ProductStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                // buildImageSection(),
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
                ElevatedButton(
                  onPressed: () {
                    Product product = Product(
                      id: widget.product!.id,
                      productImgUrl: widget.product!.productImgUrl,
                      title: titleController.text,
                      description: descriptionController.text,
                      productPrice: double.tryParse(priceController.text),
                      productQuantity: int.tryParse(quantityController.text),
                    );
                    context
                        .read<ProductBloc>()
                        .add(EditProduct(product: product));
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text('Update'),
                ),
                const SizedBox(height: 30),
              ],
            ),
          );
        },
      ),
    );
  }
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
