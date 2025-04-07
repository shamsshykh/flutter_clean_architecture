import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/core/utils/extension.dart';
import 'package:flutter_clean_architecture/features/data/model/user_info.dart';
import 'package:flutter_clean_architecture/features/presentation/bloc/user_state_hold/user_data_bloc.dart';
import 'core/di/injection_container.dart';
import 'features/data/model/list_of_users.dart';
import 'features/data/model/user_model.dart';
import 'features/presentation/bloc/user/user_bloc.dart';

void main() {
  setupDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocProvider(create: (_) => sl<UserBloc>()..add(FetchCurrentUser())),
        BlocProvider(create: (_) => sl<UserDataBloc>())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        // home: MyHomePage(title: 'Flutter Demo Home Page'),
        home: ComplexUserScreen(),
      ),
    );
  }
}

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Screen', textAlign: TextAlign.center)),
      body: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          // global error handle
          if (state is UserError) {
            context.showErrorSnackBar(state.message);
          }
        },
        child: Column(
          children: [
            // Section 1: Fetch User
            BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                if (state is UserLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is UserLoaded) {
                  return ListTile(
                    title: Text(state.user.name),
                    subtitle: Text(state.user.email!),
                  );
                }
                return ElevatedButton(
                  onPressed: () {
                    context.read<UserBloc>().add(FetchCurrentUser());
                  },
                  child: Text('Fetch User'),
                );
              },
            ),

            SizedBox(height: 20),

            // Section 2: Fetch Comments
            BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                if (state is CommentsLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is UserCommentsLoaded) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: state.users.length,
                      itemBuilder: (context, index) {
                        return ListTile(title: Text(state.users[index].name!));
                      },
                      shrinkWrap: true,
                    ),
                  );
                }
                return ElevatedButton(
                  onPressed: () {
                    context.read<UserBloc>().add(FetchUserComments());
                  },
                  child: Text('Fetch Comments'),
                );
              },
            ),

            SizedBox(height: 20),

            // Section 3: Post User Info
            BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                if (state is PostUserLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is PostUserInfoSuccess) {
                  return Text('User Info Posted: ${state.userInfo.userId}');
                }
                return ElevatedButton(
                  onPressed: () {
                    final userInfo = UserInfo(
                      id: 12,
                      title: "title",
                      body: "body",
                      userId: 121,
                    );
                    context.read<UserBloc>().add(PostUserInfo(userInfo));
                  },
                  child: Text('Post User Info'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}


class ComplexUserScreen extends StatelessWidget {
  const ComplexUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Screen')),

      body: BlocListener<UserDataBloc, UserDataState>(
        listener: (context, state) {
          if (state.errorMessage != null) {
            context.showErrorSnackBar(state.errorMessage!);
          }else if (state is UserError) {
            context.showErrorSnackBar(state.errorMessage!);
          }
        },
        child: Column(
          children: [
            // Fetch User Section
            BlocSelector<UserDataBloc, UserDataState, ({UserModel? user, bool isLoading})>(
              selector: (state) => (user : state.user, isLoading: state.isLoading),
              builder: (context, data) {
                if (data.isLoading && data.user == null) {
                  return Center(child: CircularProgressIndicator());
                }
                return data.user != null
                    ? ListTile(title: Text(data.user!.name), subtitle: Text(data.user!.email!))
                    : ElevatedButton(
                  onPressed: () => context.read<UserDataBloc>().add(FetchUser()),
                  child: Text('Fetch User'),
                );
              },
            ),

            SizedBox(height: 20),

            // Fetch Comments Section
            BlocSelector<UserDataBloc, UserDataState, List<ListOfUsers>?>(
              selector: (state) => state.users,
              builder: (context, users) {
                return users != null
                    ? Expanded(
                  child: ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      return ListTile(title: Text(users[index].name!));
                    },
                  ),
                )
                    : ElevatedButton(
                  onPressed: () => context.read<UserDataBloc>().add(FetchComments()),
                  child: Text('Fetch Comments'),
                );
              },
            ),

            SizedBox(height: 20),

            // Post User Info Section
            BlocSelector<UserDataBloc, UserDataState, UserInfo?>(
              selector: (state) => state.userInfo,
              builder: (context, userInfo) {
                return userInfo != null
                    ? Text('User Info Posted: ${userInfo.userId}')
                    : ElevatedButton(
                  onPressed: () {
                    final userInfo = UserInfo(id: 12, title: "title", body: "body", userId: 121);
                    context.read<UserDataBloc>().add(PostInfo(userInfo));
                  },
                  child: Text('Post User Info'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

