import 'package:flutter/material.dart';
import 'package:flutter_auth/common/ui/spacer.dart';
import 'package:flutter_auth/data/auth_repository/auth_repository.dart';
import 'package:flutter_auth/features/login_screen/loginBloc/login_bloc.dart';
import 'package:flutter_auth/navigation/navigation_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:side_effect_bloc/side_effect_bloc.dart';
import 'package:get_it/get_it.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final loginBloc = LoginBloc(GetIt.I<AuthRepositoryAbstract>());
  final navManager = GetIt.I<NavigationManager>();

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
        body: BlocSideEffectListener<LoginBloc, LoginEffect>(
          bloc: loginBloc,
          listener: (context, effect) {
            if (effect is LoginEffectShowSnackbar) {
              showSnackBar(effect.message, context);
            }
            if (effect is LoginEffectSuccess) {
              navManager.navToProfile();
            }
          },
          child: BlocBuilder<LoginBloc, LoginState>(
              bloc: loginBloc,
              builder: (context, state) {
                if (state is LoginStateLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                // if (state is LoginStateLoginSuccess) {
                //
                // }
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
                            labelText: "email:",
                            errorText:
                                errorEmailText.isEmpty ? null : errorEmailText,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.black))),
                      ),
                      const VerticalSpacer(),
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
                            labelText: "password:",
                            errorText: errorPasswordText.isEmpty
                                ? null
                                : errorPasswordText,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.black))),
                      ),
                      const VerticalSpacer(),
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
                          } else {
                            loginBloc.add(LoginEventIncorrectData());
                          }
                        },
                        style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all(Colors.blue)
                        ),
                        child: const Text("Log in"),
                      )
                    ],
                  ),
                );
              }),
        ));
  }

  Future<void> showSnackBar(String message, BuildContext context) async {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
