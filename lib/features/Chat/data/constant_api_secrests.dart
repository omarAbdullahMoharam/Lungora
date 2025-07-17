import 'package:flutter_dotenv/flutter_dotenv.dart';

class ConstantApiSecrets {
  static String get kModelVersion => dotenv.env['MODEL_VERSION'] ?? "";
  static String get kApiEndpoint => dotenv.env['API_ENDPOINT'] ?? "";
  static String get kBaseUrl => dotenv.env['BASE_URL'] ?? "";
  static String get kApiKey => dotenv.env['OPENROUTER_API_KEY'] ?? "";
}
