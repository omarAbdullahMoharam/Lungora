// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_services.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers,unused_element,unnecessary_string_interpolations

class _ApiServices implements ApiServices {
  // ignore: unused_element_parameter
  _ApiServices(this._dio, {this.baseUrl, this.errorLogger}) {
    baseUrl ??= 'https://lungora.runasp.net/';
  }

  final Dio _dio;

  String? baseUrl;

  final ParseErrorLogger? errorLogger;

  @override
  Future<LoginResponse> login(Map<String, dynamic> body) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body);
    final _options = _setStreamType<AuthResponse>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            'api/Auth/login',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late LoginResponse _value;
    try {
      _value = LoginResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    log("\n\n ${_value} from api_services\n\n");
    return _value;
  }

  @override
  Future<RegisterResponse> register(Map<String, dynamic> body) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body);
    final _options = _setStreamType<AuthResponse>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            'api/Auth/Register',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late RegisterResponse _value;
    try {
      _value = RegisterResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<AuthResponse> forgotPassword(Map<String, dynamic> body) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body);
    final _options = _setStreamType<AuthResponse>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            'api/Auth/ForgotPassword',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late AuthResponse _value;
    try {
      _value = AuthResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<AuthResponse> verifyOTP(Map<String, dynamic> body) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body);
    final _options = _setStreamType<AuthResponse>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            'api/Auth/VerifyResetCode',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late AuthResponse _value;
    try {
      _value = AuthResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<AuthResponse> resetPassword(Map<String, dynamic> body) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body);
    final _options = _setStreamType<AuthResponse>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            'api/Auth/ResetPassword',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late AuthResponse _value;
    try {
      _value = AuthResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ChangePasswordResponse> changePassword(
      Map<String, dynamic> body, String token) async {
    final queryParameters = <String, dynamic>{};
    final _headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final _data = <String, dynamic>{}..addAll(body);

    final _options = _setStreamType<ChangePasswordResponse>(
      Options(
        method: 'POST',
        headers: _headers,
      )
          .compose(
            _dio.options,
            'api/Auth/ChangePassword',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );

    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ChangePasswordResponse _value;
    try {
      _value = ChangePasswordResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<EditInfoResponse> editInfo(FormData formData, String token) async {
    // Prepare headers with authorization
    final _headers = <String, dynamic>{
      'Authorization': 'Bearer $token',
    };

    try {
      // Perform the network request using Dio directly
      final response = await _dio.post(
        'https://lungora.runasp.net/api/Auth/EditInfo',
        // 'api/Auth/EditInfo',
        data: formData,
        options: Options(headers: _headers),
      );

      log("Edit info response: ${response.data}");

      // Parse the response
      final result = EditInfoResponse.fromJson(response.data);
      log("Edit info result: ${result.result}");

      return result;
    } on DioException catch (e) {
      if (e.response != null) {
        log('Server error: ${e.response?.data}');
        log('Status code: ${e.response?.statusCode}');
        throw 'Server error: ${e.response?.data}';
      } else {
        log('Network error: ${e.message}');
        rethrow;
      }
    } catch (e) {
      log('Unexpected error: $e');
      rethrow;
    }
  }

  @override
Future<UserDataResponseModel> getUserData(String token) async {
  final queryParameters = <String, dynamic>{};
  final _headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  };    
  final _options = _setStreamType<UserDataResponseModel>(
    Options(
      method: 'GET',
      headers: _headers,
    )
        .compose(
          _dio.options,
          'api/Auth/GetDataUser',
          queryParameters: queryParameters,
        )
        .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
  );
  
  final _result = await _dio.fetch<Map<String, dynamic>>(_options);
  late UserDataResponseModel _value;
  
  try {
    log("User data response raw: ${_result.data}");
    
    // Detailed logging to pinpoint the error
    // var statusCode = _result.data!['statusCode'];
    // var isSuccess = _result.data!['isSuccess'];
    // var errors = _result.data!['errors'];
    // var result = _result.data!['result'];
    
    // log("Processing fields - statusCode: $statusCode, isSuccess: $isSuccess, errors: $errors, result: $result");
    
    _value = UserDataResponseModel.fromJson(_result.data!);
    log("Parsing completed successfully");
   
  } catch (e, s) {
    log("Error parsing response: $e");
    // log("Stack trace: $s");
    errorLogger?.logError(e, s, _options);
    rethrow;
  }
  return _value;
}
  @override
  Future<LogoutResponse> logout(String token) async {
    final queryParameters = <String, dynamic>{};
    final _headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    // Add an empty request body
    final _data = {};

    try {
      final _options = _setStreamType<LogoutResponse>(
        Options(
          method: 'POST',
          headers: _headers,
        )
            .compose(
              _dio.options,
              'api/Auth/LogOutSingle',
              queryParameters: queryParameters,
              data: _data, // Adding the empty request body
            )
            .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
      );

      log("Sending logout request with headers: $_headers");
      final _result = await _dio.fetch<Map<String, dynamic>>(_options);

      log("Logout response status: ${_result.statusCode}");
      log("Logout response data: ${_result.data}");

      late LogoutResponse _value;
      try {
        // AuthResponse.fromJson(_result.data!{});
        _value = LogoutResponse.fromJson(_result.data!);
      } catch (e, s) {
        log("Error parsing response: $e");
        errorLogger?.logError(e, s, _options);
        rethrow;
      }

      log("\n\n $_value from api_services\n\n");
      return _value;
    } catch (e) {
      if (e is DioException) {
        log("DioException during logout: ${e.toString()}");
        log("Response status: ${e.response?.statusCode}");
        log("Response data: ${e.response?.data}");
        log("Request path: ${e.requestOptions.path}");
        log("Request headers: ${e.requestOptions.headers}");
      } else {
        log("Unexpected error during logout: $e");
      }
      rethrow;
    }
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(String dioBaseUrl, String? baseUrl) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}
