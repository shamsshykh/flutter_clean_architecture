import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/model/list_of_users.dart';
import '../../../data/model/user_info.dart';
import '../../../data/model/user_model.dart';
import '../../../domain/usecases/get_current_user.dart';
import '../../../domain/usecases/get_user_comments.dart';
import '../../../domain/usecases/post_user_detail.dart';

part 'user_data_event.dart';
part 'user_data_state.dart';

class UserDataBloc extends Bloc<UserDataEvent, UserDataState> {

  final GetCurrentUserUseCase _currentUserUseCase;
  final GetUserCommentsCase _getUserCommentsCase;
  final PostUserDetail _postUserDetail;

  UserDataBloc(this._currentUserUseCase, this._getUserCommentsCase, this._postUserDetail) : super(UserInitial()) {

    // Fetch Current User
    on<FetchUser>((event, emit) async {
      emit(Loading(user: state.user, users: state.users, userInfo: state.userInfo)); // Keep previous data
      try {
        final users = await _currentUserUseCase.call();
        emit(UserDataUpdated(user: users, users: state.users, userInfo: state.userInfo)); // Only update user
      } catch (e) {
        emit(Error(e.toString(), user: state.user, users: state.users, userInfo: state.userInfo));
      }
    });

    on<FetchComments>((event, emit) async {
      emit(Loading(user: state.user, users: state.users, userInfo: state.userInfo));
      try {
        final comments = await _getUserCommentsCase.call();
        emit(UserDataUpdated(user: state.user, users: comments, userInfo: state.userInfo));
      } catch (e) {
        emit(Error(e.toString(), user: state.user, users: state.users, userInfo: state.userInfo));
      }
    });

    on<PostInfo>((event, emit) async {
      emit(Loading(user: state.user, users: state.users, userInfo: state.userInfo));
      try {
        final result = await _postUserDetail.call(event.userInfo);
        result.fold(
           (failure) => emit(Error(failure.message, user: state.user, users: state.users, userInfo: state.userInfo)),
           (userInfo) => emit(UserDataUpdated(user: state.user, users: state.users, userInfo: userInfo)),
        );
      } catch (e) {
        emit(Error(e.toString(), user: state.user, users: state.users, userInfo: state.userInfo));
      }
    });


  }
}
