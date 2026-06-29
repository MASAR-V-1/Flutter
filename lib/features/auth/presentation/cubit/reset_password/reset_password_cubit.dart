import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/auth_repository.dart';
import 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final AuthRepository _authRepository;

  ResetPasswordCubit(this._authRepository)
    : super(const ResetPasswordInitial());

  Future<void> resetPassword({
    required String email,
    required String token,
    required String password,
    required String passwordConfirmation,
  }) async {
    emit(const ResetPasswordLoading());

    try {
      final message = await _authRepository.resetPassword(
        email: email,
        token: token,
        password: password,
        passwordConfirmation: passwordConfirmation,
      );

      emit(ResetPasswordSuccess(message));
    } on DioException catch (error) {
      emit(ResetPasswordFailure(_getErrorMessage(error)));
    } catch (_) {
      emit(
        const ResetPasswordFailure(
          'حدث خطأ غير متوقع، يرجى المحاولة مرة أخرى.',
        ),
      );
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

    return 'تعذر تغيير كلمة السر، يرجى المحاولة مرة أخرى.';
  }
}
