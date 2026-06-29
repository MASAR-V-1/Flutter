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