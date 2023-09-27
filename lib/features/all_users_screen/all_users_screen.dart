
import 'package:flutter/material.dart';
import 'package:flutter_auth/data/auth_repository/auth_repository.dart';
import 'package:flutter_auth/features/all_users_screen/all_users_bloc/all_users_bloc.dart';
import 'package:flutter_auth/features/all_users_screen/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class AllUsersScreen extends StatefulWidget {
  const AllUsersScreen({super.key});

  @override
  State<AllUsersScreen> createState() => _AllUsersScreenState();
}

class _AllUsersScreenState extends State<AllUsersScreen> {
  final allUsersBloc = AllUsersBloc(GetIt.I<AuthRepositoryAbstract>());

  @override
  void initState() {
    super.initState();
    allUsersBloc.add(AllUsersEventLoadUsers());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All users"),
      ),
      body: BlocBuilder<AllUsersBloc, AllUsersState>(
        bloc: allUsersBloc,
        builder: (context, state) {
          if( state is AllUsersStateError) {
            return Text(state.e.toString());
          }
          if (state is AllUsersStateLoading) {
            return const Center(child: CircularProgressIndicator(),);
          }
          else if(state is AllUsersStateLoaded) {
            return ListView.separated(
              itemCount: state.users.length,
              separatorBuilder: (context, it) => const Divider(),
              itemBuilder: (context, it) {
                return UserTile(userInfo: state.users[it]);
              },
            );
          }
          else {
            return const Text("");
          }
        },
      ),
    );
  }
}
