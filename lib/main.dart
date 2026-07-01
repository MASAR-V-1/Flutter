import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'core/network/api_client.dart';
import 'core/storage/token_storage.dart';
import 'features/auth/data/auth_api_service.dart';
import 'features/auth/data/auth_repository.dart';
import 'app.dart';
import 'features/manager/data/manager_dashboard_api_service.dart';
import 'features/manager/data/manager_dashboard_repository.dart';
import 'features/manager/data/manager_tasks_api_service.dart';
import 'features/manager/data/manager_tasks_repository.dart';
import 'features/manager/data/manager_reports_api_service.dart';
import 'features/manager/data/manager_reports_repository.dart';
import 'features/manager/data/manager_operations_api_service.dart';
import 'features/manager/data/manager_operations_repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final tokenStorage = TokenStorage(const FlutterSecureStorage());
  final dio = ApiClient(tokenStorage).createDio();

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<TokenStorage>(create: (_) => tokenStorage),
        RepositoryProvider<Dio>(create: (_) => dio),

        // Auth
        RepositoryProvider<AuthApiService>(
          create: (context) => AuthApiService(context.read<Dio>()),
        ),
        RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepository(
            authApiService: context.read<AuthApiService>(),
            tokenStorage: context.read<TokenStorage>(),
          ),
        ),

        // Manager Dashboard
        RepositoryProvider<ManagerDashboardApiService>(
          create: (context) => ManagerDashboardApiService(context.read<Dio>()),
        ),
        RepositoryProvider<ManagerDashboardRepository>(
          create: (context) => ManagerDashboardRepository(
            apiService: context.read<ManagerDashboardApiService>(),
          ),
        ),

        RepositoryProvider<ManagerTasksApiService>(
          create: (context) => ManagerTasksApiService(context.read<Dio>()),
        ),
        RepositoryProvider<ManagerTasksRepository>(
          create: (context) => ManagerTasksRepository(
            apiService: context.read<ManagerTasksApiService>(),
          ),
        ),

        RepositoryProvider<ManagerReportsApiService>(
          create: (context) => ManagerReportsApiService(context.read<Dio>()),
        ),
        RepositoryProvider<ManagerReportsRepository>(
          create: (context) => ManagerReportsRepository(
            apiService: context.read<ManagerReportsApiService>(),
          ),
        ),

        RepositoryProvider<ManagerOperationsApiService>(
          create: (context) => ManagerOperationsApiService(context.read<Dio>()),
        ),
        RepositoryProvider<ManagerOperationsRepository>(
          create: (context) => ManagerOperationsRepository(
            apiService: context.read<ManagerOperationsApiService>(),
          ),
        ),
      ],
      child: const MasarApp(),
    ),
  );
}
