import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/auth_repository.dart';
import 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final AuthRepository _authRepository;

  ForgotPasswordCubit(this._authRepository)
      : super(const ForgotPasswordInitial());

  Future<void> sendResetLink({
    required String email,
  }) async {
    emit(const ForgotPasswordLoading());

    try {
      final message = await _authRepository.forgotPassword(email: email);
      emit(ForgotPasswordSuccess(message));
    } on DioException catch (error) {
      emit(ForgotPasswordFailure(_getErrorMessage(error)));
    } catch (_) {
      emit(
        const ForgotPasswordFailure(
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

    return 'تعذر إرسال رابط إعادة التعيين، يرجى المحاولة مرة أخرى.';
  }
}