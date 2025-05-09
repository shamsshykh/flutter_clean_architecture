import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/features/data/model/list_of_users.dart';
import 'package:flutter_clean_architecture/features/data/model/user_info.dart';
import 'package:flutter_clean_architecture/features/domain/usecases/get_user_comments.dart';
import 'package:flutter_clean_architecture/features/domain/usecases/post_user_detail.dart';
import '../../../data/model/user_model.dart';
import '../../../domain/usecases/get_current_user.dart';

part 'user_event.dart';
part 'user_state.dart';


class UserBloc extends Bloc<UserEvent, UserState> {

  final GetCurrentUserUseCase _currentUserUseCase;
  final GetUserCommentsCase _getUserCommentsCase;
  final PostUserDetail _postUserDetail;

  UserBloc(
    this._currentUserUseCase,
    this._getUserCommentsCase,
    this._postUserDetail,
  ) : super(UserInitial()) {

    on<FetchCurrentUser>(_fetchCurrentUser);
    on<FetchUserComments>(_fetchUserComments);
    on<PostUserInfo>(_postUserInfo);

  }



  /// Fetch User (Direct Response Without Either)
  Future<void> _fetchCurrentUser(FetchCurrentUser event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      final users = await _currentUserUseCase.call();
      emit(UserLoaded(users));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }


  /// Fetch Comments (Direct Response Without Either)
  Future<void> _fetchUserComments(FetchUserComments event, Emitter<UserState> emit) async {
    emit(CommentsLoading());

    try {
      final users = await _getUserCommentsCase();
      emit(UserCommentsLoaded(users));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  /// Post User Info (Using Either<Failure, T>)
  Future<void> _postUserInfo(PostUserInfo event, Emitter<UserState> emit) async {
    emit(PostUserLoading());

    final result = await _postUserDetail.call(event.userInfo);
    result.fold(
      (failure) => emit(UserError(failure.message)),
      (user) => emit(PostUserInfoSuccess(user)),
    );
  }

}
