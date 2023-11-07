import 'package:ecommerce/src/features/authentication/presentation/pages/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../widgets/custom_formfiels.dart';
import 'bloc/admin_login_bloc.dart';

class AdminLogInScreen extends StatefulWidget {
  const AdminLogInScreen({super.key});

  @override
  State<AdminLogInScreen> createState() => _AdminLogInScreenState();
}

class _AdminLogInScreenState extends State<AdminLogInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<AdminLoginBloc>(context).add(LoginButton(
        email: userName.text,
        password: password.text,
      ));
    } else {
      Fluttertoast.showToast(msg: 'Please enter correct details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AdminLoginBloc, AdminLoginState>(
      listener: (context, state) {
        if (state is AdminLoginSuccess) {
          // Navigate to the next screen using Navigator
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ));
          print('next screen');
        } else if (state is AdminLoginFailure) {
          Fluttertoast.showToast(msg: state.message);
          print('message printed');
        }
      },
      child: BlocBuilder<AdminLoginBloc, AdminLoginState>(
        builder: (context, state) {
          if (state is AdminLoginLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 136, 178, 209),
                  Color.fromARGB(255, 177, 212, 237)
                ],
              ),
            ),
            child: Scaffold(
              appBar: AppBar(
                title: const Text('Admin Login'),
                backgroundColor: Colors.blueGrey,
                centerTitle: true,
              ),
              backgroundColor: const Color.fromARGB(17, 0, 0, 0),
              body: Center(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomFormField(
                        textEditingController: userName,
                        autofocus: true,
                        obsecureText: false,
                        hintText: 'Email ID',
                        icondata: const Icon(Icons.person),
                        validator: (value) {
                          final emailRegExp = RegExp(
                            r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$',
                          );
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          } else if (!value.contains('@')) {
                            return 'Please enter a valid email address';
                          } else if (!emailRegExp.hasMatch(value)) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                      ),
                      CustomFormField(
                        textEditingController: password,
                        autofocus: true,
                        obsecureText: true,
                        hintText: 'Password',
                        icondata: const Icon(Icons.lock),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the Password';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 40),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          backgroundColor: Colors.blueGrey,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 12),
                        ),
                        onPressed: _submitForm,
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
