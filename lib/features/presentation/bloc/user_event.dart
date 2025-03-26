part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  @override List<Object?> get props => [];
}


class FetchCurrentUser extends UserEvent {}

class FetchUserComments extends UserEvent {}

class PostUserInfo extends UserEvent {

  final UserInfo userInfo;

  PostUserInfo(this.userInfo);

  @override
  List<Object?> get props => [userInfo];
}



