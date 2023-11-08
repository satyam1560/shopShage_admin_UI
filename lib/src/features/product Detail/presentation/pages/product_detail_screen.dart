import 'package:flutter/material.dart';

import '../../../display product/data/models/product_model.dart';
import '../../../display product/presentation/widgets/custom_button.dart';

class ProductDetailScreen extends StatelessWidget {
  final ProductObject product;
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
                        product.productImgUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(product.title,
                        style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 10),
                    Text(product.description,
                        style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        // Displays the product price.
                        Text('₹ ${(product.productPrice) as double}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.deepPurple)),
                        const Spacer(),
                        // Add to Cart button.
                        CustomButton(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 5),
                          border: Border.all(
                              color: const Color.fromARGB(172, 202, 198, 198)),
                          onTap: () {
                            // Placeholder for add to cart functionality.
                          },
                          text: 'Add to Cart',
                          textColor: Colors.deepPurple,
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
