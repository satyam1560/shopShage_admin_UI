import 'package:ecommerce/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'src/features/add product/presentation/pages/add_products.dart';

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
    // Create an instance of GetAdminAuth
    // final getAdminAuth = GetAdminAuth();

    // Call the getAdminAuth method
    // getAdminAuth.getAdminAuth();
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'xyz',
      // home: RepositoryProvider(
      //   create: (context) => GetAdminAuth(),
      //   child: BlocProvider(
      //     create: (context) => AdminLoginBloc(),
      //     child: const AdminLogInScreen(),
      //   ),
      // ),
      home: ProductCreateScreen(),
    );
  }
}
