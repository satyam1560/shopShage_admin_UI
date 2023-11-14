import 'package:ecommerce/src/features/display%20product/presentation/bloc/display_product_bloc.dart';
import 'package:ecommerce/src/features/display%20product/presentation/pages/product_edit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/product_model.dart';
import '../widgets/custom_button.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Stack(
              children: [
                // Main content of the card: product image, title, description, and actions.
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.network(
                        product.productImgUrl!,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(product.title!,
                        style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 10),
                    Text(product.description!,
                        style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 20),
                    Text('Qty. left - ${(product.productQuantity)}'),
                    const SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Displays the product price.
                        Text(
                          '₹ ${(product.productPrice) as double}',
                          style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple),
                        ),
                        const Spacer(),
                        // Add to Cart button.
                        Column(
                          children: [
                            CustomButton(
                              backgroundColor:
                                  const Color.fromARGB(255, 214, 2, 2),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 10),
                              text: 'Delete',
                              onTap: () {
                                context
                                    .read<ProductBloc>()
                                    .add(DeleteProduct(id: product));
                                print('****${product.id}');
                                Navigator.pop(context);
                              },
                              textColor:
                                  const Color.fromARGB(255, 255, 255, 255),
                            ),
                            CustomButton(
                              backgroundColor:
                                  const Color.fromARGB(255, 140, 140, 140),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 10),
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 10),
                              text: 'Edit',
                              onTap: () {
                                // Placeholder for add to cart functionality.
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        EditProductScreen(product: product)));
                              },
                              textColor:
                                  const Color.fromARGB(255, 255, 255, 255),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                // Positioned widget is used to place the discount tag on top right of the card.
                Positioned(
                  // Aligns the discount tag to the top right of the product card.
                  right: 0,
                  child: CustomButton(
                    // Styling for the discount tag button.
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    // Text to display the discount percentage.
                    text: '10.45%',
                    // Background color for the discount tag.
                    backgroundColor: const Color.fromARGB(238, 243, 176, 43),
                    // Text color for the discount tag.
                    textColor: Colors.white,
                  ),
                ),
// The stack allows overlaying of the discount tag over the product card.
              ],
            ),
          ),
        ),
      ),
    );
  }
}
