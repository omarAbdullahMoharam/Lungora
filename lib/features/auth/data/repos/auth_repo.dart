import 'package:lungora/core/utils/api_services.dart';

class AuthRepo {
  ApiServices apiServices;
  AuthRepo(this.apiServices);
  Future<void> login(String email, String password) async {
    // trigger login
    apiServices.loginUser({
      'email': email,
      'password': password,
    });
  }

  Future<void> register(String email, String password, String name) async {
    // trigger Register
    apiServices.registerUser({
      'email': email,
      'password': password,
      'name': name,
    });
  }

  Future<void> logout() async {
    // Logout logic
  }
}
