part of 'user_data_bloc.dart';

abstract class UserDataState extends Equatable {
  final UserModel? user;
  final List<ListOfUsers>? users;
  final UserInfo? userInfo;
  final bool isLoading;
  final String? errorMessage;

  const UserDataState({this.user, this.users, this.userInfo, this.isLoading = false ,this.errorMessage});


  @override
  List<Object?> get props => [user, users, userInfo, isLoading, errorMessage];
}

// Initial State
class UserInitial extends UserDataState {}

// Loading State
class Loading extends UserDataState {
  const Loading({UserModel? user, List<ListOfUsers>? users, UserInfo? userInfo})
      : super(user: user, users: users, userInfo: userInfo, isLoading: true);
}

// Error State
class Error extends UserDataState {
  const Error(String message, {UserModel? user, List<ListOfUsers>? users, UserInfo? userInfo})
      : super(user: user, users: users, userInfo: userInfo, errorMessage: message);
}

// Success State (Keeps previous data intact)
class UserDataUpdated extends UserDataState {
  const UserDataUpdated({UserModel? user, List<ListOfUsers>? users, UserInfo? userInfo})
      : super(user: user, users: users, userInfo: userInfo);
}

