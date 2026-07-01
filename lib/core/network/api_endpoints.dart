class ApiEndpoints {
  const ApiEndpoints._();

  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: '',
  );

  static bool get hasBaseUrl => baseUrl.trim().isNotEmpty;

  // Auth
  static const String registerOrganization = '/register-organization';
  static const String login = '/login';
  static const String resendVerification = '/email/resend-verification';
  static const String forgotPassword = '/forgot-password';
  static const String resetPassword = '/reset-password';
  static const String logout = '/logout';
  static const String refreshToken = '/refresh-token';
  static const String me = '/me';

  // Manager Dashboard
  // This endpoint name is temporary until the backend team confirms the real one.
  // Mobile will use the same dashboard data as the web, only displayed differently.
  static const String managerDashboard = '/manager/dashboard';
  static const String managerTasks = '/manager/tasks';

  static String managerTaskDetails(int taskId) {
    return '/manager/tasks/$taskId';
  }

  static String approveManagerTask(int taskId) {
    return '/manager/tasks/$taskId/approve';
  }

  static String assignManagerTask(int taskId) {
    return '/manager/tasks/$taskId/assign';
  }

  static const String managerReports = '/manager/reports';

  static String managerReportDetails(int reportId) {
    return '/manager/reports/$reportId';
  }

  static String reviewManagerReport(int reportId) {
    return '/manager/reports/$reportId/review';
  }

  static String approveManagerReport(int reportId) {
    return '/manager/reports/$reportId/approve';
  }

  static const String managerOperations = '/manager/operations';

  static String managerOperationDetails(int operationId) {
    return '/manager/operations/$operationId';
  }

  static String followUpManagerOperation(int operationId) {
    return '/manager/operations/$operationId/follow-up';
  }

  // Organization
  static const String organizationProfile = '/organization/profile';
  static const String submitOrganizationForReview =
      '/organization/submit-for-review';

  // Employees
  static const String employees = '/employees';

  static String resendEmployeeActivation(int employeeId) {
    return '/employees/$employeeId/resend-activation';
  }

  static String toggleEmployeeActive(int employeeId) {
    return '/employees/$employeeId/toggle-active';
  }

  static const String activateEmployeeAccount = '/activate-employee-account';
}
