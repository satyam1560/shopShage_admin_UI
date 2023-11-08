import 'package:ecommerce/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/features/display product/data/datasources/display_product_datasource.dart';
import 'src/features/display product/presentation/bloc/display_product_bloc.dart';
import 'src/features/display product/presentation/pages/display_product.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'xyz',
      home: BlocProvider(
        create: (context) => DisplayProductBloc(DisplayProductRepository()),
        child: const DisplayProduct(),
      ),
    );
  }
}
