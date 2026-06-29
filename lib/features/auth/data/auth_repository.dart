import '../../../core/storage/token_storage.dart';
import 'auth_api_service.dart';
import 'models/login_response_model.dart';

class AuthRepository {
  final AuthApiService _authApiService;
  final TokenStorage _tokenStorage;

  AuthRepository({
    required AuthApiService authApiService,
    required TokenStorage tokenStorage,
  })  : _authApiService = authApiService,
        _tokenStorage = tokenStorage;

  Future<LoginResponseModel> login({
    required String email,
    required String password,
  }) async {
    final response = await _authApiService.login(
      email: email,
      password: password,
    );

    await _tokenStorage.saveToken(response.token);

    return response;
  }

  Future<String> forgotPassword({
    required String email,
  }) {
    return _authApiService.forgotPassword(
      email: email,
    );
  }

  Future<String> resetPassword({
    required String email,
    required String token,
    required String password,
    required String passwordConfirmation,
  }) {
    return _authApiService.resetPassword(
      email: email,
      token: token,
      password: password,
      passwordConfirmation: passwordConfirmation,
    );
  }

  Future<String> logout() async {
    try {
      final message = await _authApiService.logout();
      return message;
    } finally {
      await _tokenStorage.deleteToken();
    }
  }
}