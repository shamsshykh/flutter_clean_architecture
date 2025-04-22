import 'package:dio/dio.dart';
import 'package:flutter_clean_architecture/core/network/api_data_source.dart';
import 'package:flutter_clean_architecture/features/data/model/user_info.dart';

class ApiDataSourceImpl implements ApiDataSource{

  final Dio _dio;

  ApiDataSourceImpl(this._dio);

  @override
  Future<Response> getUser() async {
    return await _dio.get('users/1');
  }

  @override
  Future<Response> getUserComments() async {
    return await _dio.get('comments?postId=1');
  }

  @override
  Future<Response> postUserDetails(UserInfo userModel) async {
    return await _dio.post('posts', data: userModel.toJson());
  }

}