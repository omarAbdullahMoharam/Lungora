import 'package:lungora/core/utils/api_services.dart';
import 'package:lungora/features/Auth/data/models/auth_response_model.dart';

class AuthRepo {
  ApiServices apiServices;
  AuthRepo(this.apiServices);
  Future<AuthResponse> login(String email, String password) async {
    // trigger login
    return apiServices.loginUser({
      'email': email,
      'password': password,
    });
  }

  Future<AuthResponse> register(String name, String email, String password,
      String confirmPassword) async {
    // trigger Register
    return apiServices.registerUser({
      'name': name,
      'email': email,
      'password': password,
      'confirmPassword': confirmPassword,
    });
  }

  // Future<void> logout() async {
  //   // Logout logic
  // }
}
