import '../../data/model/list_of_users.dart';
import '../repository/user_repository.dart';

class GetUserCommentsCase {

  final UserRepository repository;
  GetUserCommentsCase(this.repository);

  Future<List<ListOfUsers>> call() async => await repository.getUserComments();
}