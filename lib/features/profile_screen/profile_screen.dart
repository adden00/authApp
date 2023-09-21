import 'package:flutter/material.dart';
import 'package:flutter_auth/data/auth_repository/auth_repository.dart';
import 'package:flutter_auth/features/profile_screen/bloc/profile_bloc.dart';
import 'package:flutter_auth/features/profile_screen/bloc/profile_event.dart';
import 'package:flutter_auth/features/profile_screen/bloc/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../data/auth_repository/auth_repository_abstract.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final profileBloc = ProfileBloc(GetIt.I<AuthRepositoryAbstract>());

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
        body: BlocBuilder<ProfileBloc, ProfileState>(
          bloc: profileBloc,
          builder: (context, state) {
            if (state is ProfileStateLoaded) {
              return Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(state.userInfo.profilePhotoUrl),
                  Text(state.userInfo.name),
                  Text(state.userInfo.email),
                  Text(state.userInfo.createdAt),
                  TextButton(
                      onPressed: () {
                        profileBloc.add(LogOutEvent());
                        Navigator.of(context).pushNamedAndRemoveUntil("/", (R)=>false);
                      },
                      child: const Text("exit")),
                  Container(height: 50,),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed("/all_users");
                      },
                  child: const Text("All users"),)
                ],
              ));
            }
            if (state is ProfileStateLoading) {
                return const Center(child: CircularProgressIndicator());
              }
            if (state is ProfileStateError) {
              return Text("load error: ${state.error}");
            }
            else {
              return const Text("");
            }
          },
        ));
  }
}
