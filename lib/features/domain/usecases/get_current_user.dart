import '../../data/model/user_model.dart';
import '../repository/user_repository.dart';

class GetCurrentUserUseCase {

  final UserRepository _repository;
  GetCurrentUserUseCase(this._repository);

  Future<UserModel> call() async => await _repository.getCurrentUser();
}