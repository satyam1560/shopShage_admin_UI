import 'package:ecommerce/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/features/authentication/presentation/pages/admin_login_screen.dart';
import 'src/features/authentication/presentation/pages/bloc/admin_login_bloc.dart';
import 'src/features/display product/presentation/bloc/display_product_bloc.dart';

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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AdminLoginBloc(),
        ),
        BlocProvider(
          create: (context) => ProductBloc(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'xyz',
        home: AdminLogInScreen(),
      ),
    );
  }
}
