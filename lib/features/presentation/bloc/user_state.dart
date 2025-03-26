part of 'user_bloc.dart';

abstract class UserState extends Equatable { @override List<Object?> get props => []; }


class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserError extends UserState {
  final String message;

  UserError(this.message);

  @override
  List<Object?> get props => [message];
}

class UserLoaded extends UserState {
  final UserModel user;

  UserLoaded(this.user);

  @override
  List<Object?> get props => [user];
}

class UserCommentsLoaded extends UserState {
  final List<ListOfUsers> users;

  UserCommentsLoaded(this.users);

  @override
  List<Object?> get props => [users];
}

class PostUserInfoSuccess extends UserState {
  final UserInfo userInfo;

  PostUserInfoSuccess(this.userInfo);

  @override
  List<Object?> get props => [userInfo];
}


