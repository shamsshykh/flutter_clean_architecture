import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/core/error/failures.dart';
import 'package:flutter_clean_architecture/features/data/model/user_info.dart';

import '../repository/user_repository.dart';

class PostUserDetail {
  final UserRepository repository;

  PostUserDetail(this.repository);

  Future<Either<Failure, UserInfo>> call(UserInfo data) async => await repository.postUserDetails(data);
}
