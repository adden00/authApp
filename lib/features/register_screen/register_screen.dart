import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_auth/common/Constants.dart';
import 'package:flutter_auth/data/auth_repository/auth_repository.dart';
import 'package:flutter_auth/features/register_screen/register_bloc/register_bloc.dart';
import 'package:flutter_auth/features/register_screen/register_bloc/register_event.dart';
import 'package:flutter_auth/features/register_screen/register_bloc/register_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _State();
}

class _State extends State<RegisterScreen> {
  final repository = GetIt.I<AuthRepositoryAbstract>();
  final registerBloc = RegisterBloc(GetIt.I<AuthRepositoryAbstract>());

  @override
  Widget build(BuildContext context) {
    // final storage = GetIt.I<FlutterSecureStorage>();
    var nameText = TextEditingController();
    var emailText = TextEditingController();
    var passwordText = TextEditingController();
    var confirmPasswordText = TextEditingController();
    String errorPasswordText = "";
    String errorEmailText = "";
    String errorConfirmPasswordText = "";
    return Scaffold(
        appBar: AppBar(
          title: const Text("Registration"),
        ),
        body: BlocBuilder<RegisterBloc, RegisterState>(
          bloc: registerBloc,
          builder: (context, state) {
            if (state is RegisterStateLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is RegisterStateRegistered) {
              Navigator.of(context).pushNamedAndRemoveUntil("/profile", (r)=>false);
            }
            if (state is RegisterStateUserNotFound) {
              showSnackBar("user not found (wrong email or password)", context);
            }
            if (state is RegisterStateNetworkError) {
              showSnackBar("Network error, please try again!", context);
            }
            return Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: nameText,
                    decoration: InputDecoration(
                        hintText: "name:",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.black))),
                  ),
                  Container(height: 10),
                  TextField(
                    controller: emailText,
                    onChanged: (text) {
                      errorEmailText = "";
                    },
                    decoration: InputDecoration(
                        hintText: "email:",
                        errorText: errorEmailText == "" ? null : errorEmailText,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.black))),
                  ),
                  Container(height: 10),
                  TextField(
                    controller: passwordText,
                    onChanged: (text) {
                      errorPasswordText = "";
                    },
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: InputDecoration(
                        hintText: "password:",

                        errorText: errorPasswordText.isEmpty
                            ? null
                            : errorPasswordText,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.black))),
                  ),
                  Container(height: 10),
                  TextField(
                    controller: confirmPasswordText,
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: InputDecoration(
                        hintText: "confirm password:",
                        errorText: errorConfirmPasswordText == ""
                            ? null
                            : errorConfirmPasswordText,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.black))),
                  ),
                  TextButton(
                    style: ButtonStyle(
                        textStyle: MaterialStateProperty.all(
                            const TextStyle(color: Colors.black))),
                    onPressed: () {
                      bool flag = true;
                      if (passwordText.text.length < 8) {
                        errorPasswordText =
                            "password must be at least 8 characters!";
                        flag = false;
                      }
                      if (!(RegExp(
                              "^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\\.[a-zA-Z0-9-.]+\$")
                          .hasMatch(emailText.text))) {
                        errorEmailText = "incorrect email!";
                        flag = false;
                      }
                      if (passwordText.text != confirmPasswordText.text) {
                        errorConfirmPasswordText = "passwords are different!";
                        flag = false;
                      }
                      if (flag) {
                        registerBloc.add(RegisterEventRegister(RegisterData(
                            nameText.text,
                            emailText.text,
                            passwordText.text,
                            confirmPasswordText.text)));
                      }
                      else {
                        registerBloc.add(RegisterEventIncorrectData());
                      }
                    },
                    child: const Text("Register"),
                  )
                ],
              ),
            );
          },
        ));
  }
  Future<void> showSnackBar(String message, BuildContext context) async {
    ScaffoldMessenger.of(context).showSnackBar( SnackBar(
        content: Text(message)));
  }
}
