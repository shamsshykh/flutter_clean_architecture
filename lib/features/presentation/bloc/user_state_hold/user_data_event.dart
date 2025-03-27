part of 'user_data_bloc.dart';



abstract class UserDataEvent extends Equatable {
  @override List<Object?> get props => [];
}


class FetchUser extends UserDataEvent {}

class FetchComments extends UserDataEvent {}

class PostInfo extends UserDataEvent {

  final UserInfo userInfo;

  PostInfo(this.userInfo);

  @override
  List<Object?> get props => [userInfo];
}

