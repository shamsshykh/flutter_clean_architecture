import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/core/error/failures.dart';
import 'package:flutter_clean_architecture/core/network/api_data_source.dart';
import 'package:flutter_clean_architecture/core/network/api_data_source_impl.dart';
import 'package:flutter_clean_architecture/core/network/safe_api_call.dart';
import 'package:flutter_clean_architecture/features/data/model/user_info.dart';

import '../../domain/repository/user_repository.dart';
import '../model/list_of_users.dart';
import '../model/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  final ApiDataSource _apiService;
  UserRepositoryImpl(this._apiService);

  @override
  Future<UserModel> getCurrentUser() async  => UserModel.fromJson((await _apiService.getUser()).data);


  @override
  Future<List<ListOfUsers>> getUserComments() async {
    final response = await _apiService.getUserComments();
    return (response.data as List)
        .map((json) => ListOfUsers.fromJson(json))
        .toList();
  }

  @override
  Future<Either<Failure, UserInfo>> postUserDetails(UserInfo userinfo) {

    return SafeApiCall.call(() async {
      final response = await _apiService.postUserDetails(userinfo);
      return UserInfo.fromJson(response.data);
    });
    
  }
  
  
}


