import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'core/network/api_client.dart';
import 'core/storage/token_storage.dart';
import 'features/auth/data/auth_api_service.dart';
import 'features/auth/data/auth_repository.dart';
import 'app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final tokenStorage = TokenStorage(const FlutterSecureStorage());
  final dio = ApiClient(tokenStorage).createDio();

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<TokenStorage>(
          create: (_) => tokenStorage,
        ),
        RepositoryProvider<Dio>(
          create: (_) => dio,
        ),
        RepositoryProvider<AuthApiService>(
          create: (context) => AuthApiService(
            context.read<Dio>(),
          ),
        ),
        RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepository(
            authApiService: context.read<AuthApiService>(),
            tokenStorage: context.read<TokenStorage>(),
          ),
        ),
      ],
      child: const MasarApp(),
    ),
  );
}