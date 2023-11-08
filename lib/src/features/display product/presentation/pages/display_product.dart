import 'package:ecommerce/src/features/product%20Detail/presentation/pages/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../add product/data/datasources/add_product_datasource.dart';
import '../../../add product/presentation/bloc/add_product_bloc.dart';
import '../../../add product/presentation/pages/add_products.dart';
import '../bloc/display_product_bloc.dart';
import '../widgets/custom_button.dart';

// This StatefulWidget is responsible for displaying products in a grid view.
class DisplayProduct extends StatefulWidget {
  const DisplayProduct({super.key});

  @override
  State<DisplayProduct> createState() => _DisplayProductState();
}

class _DisplayProductState extends State<DisplayProduct> {
  // When the state is initialized, an event is added to the DisplayProductBloc to load products.
  @override
  void initState() {
    super.initState();
    context.read<DisplayProductBloc>().add(DisplayProductItems());
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold provides the structure for the screen including AppBar and Body.
    return Scaffold(
      // Setting a background color for consistency across the app's products screen.
      backgroundColor: const Color.fromARGB(236, 255, 255, 255),
      appBar: AppBar(
        title: const Text('Products'),
        // AppBar actions allow for additional operations like adding a new item.
        actions: [
          CustomButton(
            backgroundColor: Colors.deepPurple,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
            text: 'Add Item',
            onTap: () {
              // Navigates to the ProductCreateScreen when the button is tapped.
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return BlocProvider(
                    // Provides the AddProductBloc to the ProductCreateScreen.
                    create: (context) =>
                        AddProductBloc(productRepository: ProductRepository()),
                    child: const ProductCreateScreen(),
                  );
                },
              ));
            },
          ),
        ],
      ),
      // RefreshIndicator allows users to swipe down to refresh the products list.
      body: RefreshIndicator(
        // onRefresh is called when the user swipes down. It triggers a bloc event to reload products.
        onRefresh: () async {
          context.read<DisplayProductBloc>().add(DisplayProductItems());
        },
        // BlocBuilder is responsible for building the UI based on the current state.
        child: BlocBuilder<DisplayProductBloc, DisplayProductState>(
          builder: (context, state) {
            // Calculates the number of columns for the grid based on screen width.
            const double itemWidth = 180;
            final double screenWidth = MediaQuery.of(context).size.width;
            int crossAxisCount = (screenWidth / itemWidth).floor();

            if (state is DisplayProductDataLoading) {
              // Shows a loading indicator while the products are loading.
              return const Center(child: CircularProgressIndicator());
            } else if (state is DisplayProductDataLoaded) {
              // Builds a GridView when the data is successfully loaded.
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  childAspectRatio: 0.7,
                ),
                itemCount: state.products.length,
                itemBuilder: (context, index) {
                  final product = state.products[index];
                  // Each product is wrapped in a GestureDetector to handle taps.
                  return GestureDetector(
                    onTap: () {
                      // Navigates to ProductDetailScreen on tap.
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              ProductDetailScreen(product: product)));
                    },
                    // Card provides a simple UI container for each product.
                    child: Card(
                      margin: const EdgeInsets.all(5.0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Stack(
                          children: [
                            // Main content of the card: product image, title, description, and actions.
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.network(
                                  product.productImgUrl,
                                  fit: BoxFit.cover,
                                ),
                                const Spacer(),
                                Text(product.title,
                                    style:
                                        Theme.of(context).textTheme.titleLarge),
                                // Text(product.description),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    // Displays the product price.
                                    Text(
                                        '₹ ${(product.productPrice) as double}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.deepPurple)),
                                    const Spacer(),
                                    // Add to Cart button.
                                    CustomButton(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 3),
                                      border: Border.all(
                                          color: const Color.fromARGB(
                                              172, 202, 198, 198)),
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
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 3),
                                // Text to display the discount percentage.
                                text: '10.45%',
                                // Background color for the discount tag.
                                backgroundColor:
                                    const Color.fromARGB(238, 243, 176, 43),
                                // Text color for the discount tag.
                                textColor: Colors.white,
                              ),
                            ),
// The stack allows overlaying of the discount tag over the product card.
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else if (state is DisplayProductDataError) {
              // If there is an error fetching products, display an error message.
              return Center(child: Text('Error: ${state.error}'));
            } else {
              // Before products are loaded, display a message prompting to wait.
              return const Text('Please wait! items are loading...');
            }
          },
        ),
      ),
    );
  }
}
