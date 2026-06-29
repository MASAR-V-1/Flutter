import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/auth_repository.dart';
import 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  final AuthRepository _authRepository;

  LogoutCubit(this._authRepository) : super(const LogoutInitial());

  Future<void> logout() async {
    emit(const LogoutLoading());

    try {
      final message = await _authRepository.logout();
      emit(LogoutSuccess(message));
    } on DioException catch (error) {
      emit(LogoutFailure(_getErrorMessage(error)));
    } catch (_) {
      emit(
        const LogoutFailure(
          'حدث خطأ أثناء تسجيل الخروج، يرجى المحاولة مرة أخرى.',
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

    return 'تعذر تسجيل الخروج، يرجى المحاولة مرة أخرى.';
  }
}