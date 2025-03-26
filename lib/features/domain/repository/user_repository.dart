import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/core/error/failures.dart';

import '../../data/model/list_of_users.dart';
import '../../data/model/user_info.dart';
import '../../data/model/user_model.dart';

abstract class UserRepository {
  Future<UserModel> getCurrentUser();
  Future<List<ListOfUsers>> getUserComments();
  Future<Either<Failure ,UserInfo>> postUserDetails(UserInfo userinfo);
}
