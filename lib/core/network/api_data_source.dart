import 'package:dio/dio.dart';
import '../../features/data/model/user_info.dart';

abstract class ApiDataSource {

  Future<Response> getUser();
  Future<Response> getUserComments();
  Future<Response> postUserDetails(UserInfo userModel);

}
