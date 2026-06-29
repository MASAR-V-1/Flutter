import 'package:dio/dio.dart';

import '../../../core/network/api_endpoints.dart';
import 'models/login_response_model.dart';

class AuthApiService {
  final Dio _dio;

  AuthApiService(this._dio);

  Future<LoginResponseModel> login({
    required String email,
    required String password,
  }) async {
    // Mock mode when API_BASE_URL is empty.
    if (!ApiEndpoints.hasBaseUrl) {
      return _mockLogin(
        email: email,
        password: password,
      );
    }

    final response = await _dio.post(
      ApiEndpoints.login,
      data: {
        'admin_email': email,
        'admin_password': password,
      },
    );

    return LoginResponseModel.fromJson(response.data);
  }

  Future<String> forgotPassword({
    required String email,
  }) async {
    // Mock mode when API_BASE_URL is empty.
    if (!ApiEndpoints.hasBaseUrl) {
      await Future.delayed(const Duration(seconds: 1));
      return 'تم إرسال رابط إعادة تعيين كلمة السر إلى بريدك.';
    }

    final response = await _dio.post(
      ApiEndpoints.forgotPassword,
      data: {
        'email': email,
      },
    );

    return _getMessageFromResponse(
      response.data,
      fallback: 'تم إرسال رابط إعادة تعيين كلمة السر.',
    );
  }

  Future<String> resetPassword({
    required String email,
    required String token,
    required String password,
    required String passwordConfirmation,
  }) async {
    // Mock mode when API_BASE_URL is empty.
    if (!ApiEndpoints.hasBaseUrl) {
      await Future.delayed(const Duration(seconds: 1));
      return 'تم تغيير كلمة السر بنجاح.';
    }

    final response = await _dio.post(
      ApiEndpoints.resetPassword,
      data: {
        'token': token,
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation,
      },
    );

    return _getMessageFromResponse(
      response.data,
      fallback: 'تم تغيير كلمة السر بنجاح.',
    );
  }

  Future<String> logout() async {
    // Mock mode when API_BASE_URL is empty.
    if (!ApiEndpoints.hasBaseUrl) {
      await Future.delayed(const Duration(seconds: 1));
      return 'تم تسجيل الخروج بنجاح.';
    }

    final response = await _dio.post(ApiEndpoints.logout);

    return _getMessageFromResponse(
      response.data,
      fallback: 'تم تسجيل الخروج بنجاح.',
    );
  }

  String _getMessageFromResponse(
      dynamic data, {
        required String fallback,
      }) {
    if (data is Map<String, dynamic>) {
      final message = data['message'];

      if (message != null && message.toString().trim().isNotEmpty) {
        return message.toString();
      }
    }

    return fallback;
  }

  Future<LoginResponseModel> _mockLogin({
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 1));

    if (email == 'test10@test.org' && password == 'password123') {
      return LoginResponseModel.fromJson({
        'message': 'تم تسجيل الدخول بنجاح.',
        'user': {
          'id': 10,
          'name': 'التجربة 10',
          'email': 'test10@test.org',
          'role': 'org_admin',
          'organization_id': 9,
          'must_change_password': false,
        },
        'token': 'mock_org_admin_token',
      });
    }

    if (email == 'employee@test.org' && password == '5saJRe2H') {
      return LoginResponseModel.fromJson({
        'message': 'تم تسجيل الدخول بنجاح.',
        'user': {
          'id': 11,
          'name': 'Employee1',
          'email': 'employee@test.org',
          'role': 'employee',
          'organization_id': 9,
          'must_change_password': true,
        },
        'token': 'mock_employee_token',
      });
    }

    if (email == 'test13@test.org') {
      throw DioException(
        requestOptions: RequestOptions(path: ApiEndpoints.login),
        response: Response(
          requestOptions: RequestOptions(path: ApiEndpoints.login),
          statusCode: 403,
          data: {
            'message': 'طلبك قيد المراجعة من الإدارة، يرجى الانتظار.',
          },
        ),
      );
    }

    throw DioException(
      requestOptions: RequestOptions(path: ApiEndpoints.login),
      response: Response(
        requestOptions: RequestOptions(path: ApiEndpoints.login),
        statusCode: 401,
        data: {
          'message': 'بيانات تسجيل الدخول غير صحيحة.',
        },
      ),
    );
  }
}