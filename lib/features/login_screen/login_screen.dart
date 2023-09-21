import 'package:flutter/material.dart';
import 'package:flutter_auth/features/login_screen/loginBloc/loginBloc.dart';
import 'package:flutter_auth/features/login_screen/loginBloc/loginEvent.dart';
import 'package:flutter_auth/features/login_screen/loginBloc/loginState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../data/auth_repository/auth_repository.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final loginBloc = LoginBloc(GetIt.I<AuthRepositoryAbstract>());

  var emailText = TextEditingController();
  var passwordText = TextEditingController();

  String errorPasswordText = "";
  String errorEmailText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Log in"),
        ),
        body: BlocBuilder<LoginBloc, LoginState>(
            bloc: loginBloc,
            builder: (context, state) {
              if (state is LoginStateLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is LoginStateLoginSuccess) {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil("/profile", (r) => false);
              }
              if (state is LoginStateUserNotFound) {
                showSnackBar("user not found (wrong email or password)", context);

              }
              if (state is LoginStateNetworkError) {
                showSnackBar("Network error, please try again!", context);
              }
              return Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      onChanged: (value) {
                        setState(() {
                          errorEmailText = "";
                        });
                      },
                      controller: emailText,
                      decoration: InputDecoration(
                          hintText: "email:",
                          errorText:
                              errorEmailText.isEmpty ? null : errorEmailText,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: Colors.black))),
                    ),
                    Container(height: 10),
                    TextField(
                      onChanged: (value) {
                        setState(() {
                          errorPasswordText = "";
                        });
                      },
                      controller: passwordText,
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
                              borderSide:
                                  const BorderSide(color: Colors.black))),
                    ),
                    Container(height: 10),
                    TextButton(
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

                        if (flag) {
                          loginBloc.add(LoginEventLogIn(LogInData(
                              emailText.text,
                              passwordText.text,
                              )));
                        }
                        else {
                          loginBloc.add(LoginEventIncorrectData());
                        }
                      },
                      child: const Text("Log in"),
                    )
                  ],
                ),
              );
            }));
  }
  Future<void> showSnackBar(String message, BuildContext context) async {
    ScaffoldMessenger.of(context).showSnackBar( SnackBar(
        content: Text(message)));
  }
}
