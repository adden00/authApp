import 'package:flutter/material.dart';
import 'package:flutter_auth/data/auth_repository/auth_repository.dart';
import 'package:flutter_auth/features/profile_screen/bloc/profile_bloc.dart';
import 'package:flutter_auth/navigation/navigation_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final profileBloc = ProfileBloc(GetIt.I<AuthRepositoryAbstract>());
  final navManager = GetIt.I<NavigationManager>();

  @override
  void initState() {
    super.initState();
    profileBloc.add(LoadUserDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("you are sign in"),
        ),
        body: RefreshIndicator(
            onRefresh: () async {
              profileBloc.add(LoadUserDataEvent());
            },
            child: Stack(
              children: <Widget>[
                ListView(),
                BlocBuilder<ProfileBloc, ProfileState>(
                  bloc: profileBloc,
                  builder: (context, state) {
                    if (state is ProfileStateLoaded) {
                      final createDate =
                          DateTime.parse(state.userInfo.createdAt);
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.person),
                            Text(state.userInfo.name),
                            Text(state.userInfo.email),
                            Text(
                                "created: ${createDate.day < 10 ? "0${createDate.day}" : createDate.day}.${createDate.month < 10 ? "0${createDate.month}" : createDate.month}.${createDate.year}"),
                            TextButton(
                                onPressed: () {
                                  profileBloc.add(LogOutEvent());
                                  navManager.returnToHome();
                                },
                                child: const Text("exit")),
                            Container(
                              height: 50,
                            ),
                            TextButton(
                              onPressed: () {
                                navManager.navToAllUsers();
                              },
                              child: const Text("All users"),
                            )
                          ],
                        ),
                      );
                    }
                    if (state is ProfileStateLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state is ProfileStateError) {
                      return Text("load error: ${state.error}");
                    } else {
                      return Text(state.toString());
                    }
                  },
                )
              ],
            )));
  }
}
