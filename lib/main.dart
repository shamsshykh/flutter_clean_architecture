import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/features/data/model/user_info.dart';
import 'core/di/injection_container.dart';
import 'features/presentation/bloc/user_bloc.dart';

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
        BlocProvider(create: (_) => sl<UserBloc>()..add(FetchCurrentUser()))

      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final dynamic title;

  const MyHomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserBloc, UserState>(
      listener: (context, state) {},
      builder: (context, state) {
        switch (state) {
          case UserInitial():
            return Center(child: CircularProgressIndicator());
          case UserLoading():
            return Center(child: CircularProgressIndicator());
          case UserLoaded():
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                title: Text(title),
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("User Name ${state.user.name}"),
                    ElevatedButton(
                      onPressed: () {
                        context.read<UserBloc>().add(FetchCurrentUser());
                      },
                      child: Text("Current User"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        context.read<UserBloc>().add(FetchUserComments());
                      },
                      child: Text("User Comment Count"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        var userInfo = UserInfo(id: 12, title: "Hellow", body: "this is body", userId: 1211);
                        context.read<UserBloc>().add(PostUserInfo(userInfo));
                      },
                      child: Text("Post User Comment"),
                    ),
                  ],
                ),
              ),
            );
          case UserCommentsLoaded():
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                title: Text(title),
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Comment Count ${state.users.length}"),
                    ElevatedButton(
                      onPressed: () {
                        context.read<UserBloc>().add(FetchCurrentUser());
                      },
                      child: Text("Current User"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        context.read<UserBloc>().add(FetchUserComments());
                      },
                      child: Text("User Comment Count"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        var userInfo = UserInfo(id: 12, title: "Hellow", body: "this is body", userId: 1211);
                        context.read<UserBloc>().add(PostUserInfo(userInfo));
                      },
                      child: Text("Post User Comment"),
                    ),
                  ],
                ),
              ),
            );
          case PostUserInfoSuccess():
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                title: Text(title),
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Comment id ${state.userInfo.userId}"),
                    ElevatedButton(
                      onPressed: () {
                        context.read<UserBloc>().add(FetchCurrentUser());
                      },
                      child: Text("Current User"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        context.read<UserBloc>().add(FetchUserComments());
                      },
                      child: Text("User Comment Count"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        var userInfo = UserInfo(id: 122, title: "Hellow", body: "this is body", userId: 1211);
                        context.read<UserBloc>().add(PostUserInfo(userInfo));
                      },
                      child: Text("Post User Comment"),
                    ),
                  ],
                ),
              ),
            );
          case UserError():
            return Center(child: Text(state.message));
        }

        return Container();
      },
    );
  }
}
