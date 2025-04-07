import 'package:dio/dio.dart';
import '../../features/data/model/user_info.dart';

class ApiService {
  final Dio _dio;

  ApiService(this._dio);

  Future<Response> getUser() async => await _dio.get('users/1');

  Future<Response> getUserComments() async => await _dio.get('comments?postId=1');

  Future<Response> postUserDetails(UserInfo userModel) async => await _dio.post('posts', data: userModel.toJson());
}
