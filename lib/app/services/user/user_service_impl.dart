import 'package:firebase_auth/firebase_auth.dart';

import './user_service.dart';
import '../../repositories/user/user_repository.dart';

class UserServiceImpl implements UserService {
  final UserRepository _userRepository;

  UserServiceImpl({required UserRepository userRepository})
      : _userRepository = userRepository;

  @override
  Future<User?> register(String email, String password) {
    return _userRepository.register(email, password);
  }

  @override
  Future<User?> login(String email, String password) {
    return _userRepository.login(email, password);
  }
}
