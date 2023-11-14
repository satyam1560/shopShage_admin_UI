import 'package:ecommerce/src/features/display%20product/presentation/pages/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/product_model.dart';
import '../bloc/display_product_bloc.dart';
import '../widgets/custom_button.dart';
import 'add_products.dart';

// This StatefulWidget is responsible for displaying products in a grid view.
class DisplayProduct extends StatefulWidget {
  const DisplayProduct({super.key});

  @override
  State<DisplayProduct> createState() => _ProductState();
}

class _ProductState extends State<DisplayProduct> {
  @override
  void initState() {
    context.read<ProductBloc>().add(DisplayProductItems());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(236, 255, 255, 255),
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          CustomButton(
            backgroundColor: Colors.deepPurple,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
            text: 'Add Item',
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return BlocProvider(
                    create: (context) => ProductBloc(),
                    child: const ProductCreateScreen(),
                  );
                },
              ));
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<ProductBloc>().add(DisplayProductItems());
        },
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state.productStatus == ProductStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.productStatus == ProductStatus.success) {
              return buildProductGrid(state.products!);
            } else if (state.productStatus == ProductStatus.failure) {
              return Center(child: Text('Error: ${state.failure}'));
            } else {
              return const Text('Something Went Wrong !');
            }
          },
        ),
      ),
    );
  }

  Widget buildProductGrid(List<Product> products) {
    const double itemWidth = 180;
    final double screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = (screenWidth / itemWidth).floor();

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: 0.7,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return buildProductCard(product);
      },
    );
  }

  Widget buildProductCard(Product product) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ProductDetailScreen(product: product)));
      },
      child: Card(
        margin: const EdgeInsets.all(5.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              buildProductCardContent(product),
              Positioned(
                right: 0,
                child: buildDiscountTag(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildProductCardContent(Product product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.network(
          product.productImgUrl!,
          fit: BoxFit.cover,
        ),
        const Spacer(),
        Text(product.title!, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 10),
        Row(
          children: [
            Text(
              '₹ ${(product.productPrice) as double}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const Spacer(),
          ],
        ),
      ],
    );
  }

  Widget buildDiscountTag() {
    return CustomButton(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      text: '10.45%',
      backgroundColor: const Color.fromARGB(238, 243, 176, 43),
      textColor: Colors.white,
    );
  }
}
