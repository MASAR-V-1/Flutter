import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/auth_repository.dart';
import 'login_state.dart';


class LoginCubit extends Cubit<LoginState> {
  final AuthRepository _authRepository;

  LoginCubit(this._authRepository) : super(const LoginInitial());

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(const LoginLoading());

    try {
      final response = await _authRepository.login(
        email: email,
        password: password,
      );

      emit(
        LoginSuccess(
          message: response.message,
          user: response.user,
        ),
      );
    } on DioException catch (error) {
      emit(LoginFailure(_getErrorMessage(error)));
    } catch (_) {
      emit(const LoginFailure('حدث خطأ غير متوقع، يرجى المحاولة مرة أخرى.'));
    }
  }

  String _getErrorMessage(DioException error) {
    final data = error.response?.data;

    if (data is Map<String, dynamic>) {
      final message = data['message'];

      if (message != null && message.toString().trim().isNotEmpty) {
        return message.toString();
      }
    }

    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout ||
        error.type == DioExceptionType.sendTimeout) {
      return 'انتهت مهلة الاتصال، تحقق من الإنترنت وحاول مرة أخرى.';
    }

    return 'فشل تسجيل الدخول، تحقق من البيانات وحاول مرة أخرى.';
  }
}