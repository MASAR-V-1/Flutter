class AppStrings {
  const AppStrings._();

  // App
  static const String appName = 'مسار';

  // Auth shared
  static const String authMainTitle = 'مساحة تشغيل للمؤسسات';
  static const String authMainSubtitle =
      'ادخل إلى مساحة عمل مؤسستك وتابع إجرائتها من مكان واحد.';

  static const List<String> authSideItems = [
    'صلاحيات محمية',
    'وحدات مفعّلة',
    'تقارير ومتابعة',
    'مساحة عمل آمنة',
  ];

  static const String backToLogin = 'العودة إلى تسجيل الدخول';

  // Login
  static const String loginSideTitle = 'الدخول إلى مساحة العمل';
  static const String loginSideSubtitle =
      'أدخل بيانات حسابك للوصول إلى مساحة عمل مؤسستك.';

  static const String loginTitle = 'تسجيل الدخول';
  static const String loginSubtitle = 'مرحبًا بك مجددًا، أدخل بياناتك للمتابعة.';

  static const String emailLabel = 'البريد الإلكتروني';
  static const String emailHint = 'name@organization.org';
  static const String passwordLabel = 'كلمة المرور';
  static const String passwordHint = 'أدخل كلمة المرور';

  static const String rememberMe = 'تذكرني';
  static const String forgotPassword = 'نسيت كلمة المرور؟';
  static const String loginButton = 'تسجيل الدخول';

  static const String loginInfo =
      'يتم منح صلاحيات الدخول وإدارة الحسابات من خلال مدير المؤسسة بعد قبول ملف المؤسسة.';

  // Validation
  static const String emailRequired = 'البريد الإلكتروني مطلوب';
  static const String emailInvalid = 'أدخل بريدًا إلكترونيًا صحيحًا';
  static const String passwordRequired = 'كلمة المرور مطلوبة';
  static const String passwordTooShort =
      'كلمة المرور يجب أن تكون 8 أحرف على الأقل';

  // Onboarding
  static const String onboardingSkip = 'تخطي';
  static const String onboardingNext = 'التالي';
  static const String onboardingLogin = 'تسجيل الدخول';

  static const String onboardingTitle1 = 'مرحبًا بك في مسار';
  static const String onboardingSubtitle1 =
      'تابع مهامك وعمليات مؤسستك من مكان واحد، بطريقة منظمة وواضحة.';
  static const String onboardingLabel1 = 'مساحة عمل ذكية';

  static const String onboardingTitle2 = 'وصول حسب دورك';
  static const String onboardingSubtitle2 =
      'ستظهر لك فقط الوحدات والمهام التي منحك مدير المؤسسة صلاحية الوصول إليها.';
  static const String onboardingLabel2 = 'صلاحيات آمنة';

  static const String onboardingTitle3 = 'ابدأ عملك بسهولة';
  static const String onboardingSubtitle3 =
      'سجّل الدخول باستخدام البريد الإلكتروني أو اسم المستخدم وكلمة المرور التي فعلتها من الرابط.';
  static const String onboardingLabel3 = 'جاهز للانطلاق';

  // Forgot Password
  static const String forgotPasswordPageTitle = 'استعادة كلمة المرور';
  static const String forgotPasswordPageSubtitle =
      'أدخل بريدك الإلكتروني لإرسال رابط إعادة تعيين كلمة المرور.';

  static const String forgotPasswordSideTitle = 'استعادة آمنة لحسابك';
  static const String forgotPasswordSideSubtitle =
      'سنرسل رابط إعادة التعيين إلى البريد المرتبط بحسابك. لا تشارك الرابط مع أي شخص.';

  static const List<String> forgotPasswordSideItems = [
    'تحقق من البريد الإلكتروني',
    'رابط مؤقت وآمن',
    'إعادة تعيين كلمة المرور',
  ];

  static const String forgotPasswordTitle = 'نسيت كلمة المرور؟';
  static const String forgotPasswordSubtitle =
      'أدخل البريد الإلكتروني المرتبط بحسابك وسنرسل لك رابط إعادة التعيين.';

  static const String resetLinkSentMessage =
      'تم إرسال رابط إعادة تعيين كلمة المرور. تحقق من بريدك الإلكتروني واتبع التعليمات.';

  static const String sendResetLinkButton = 'إرسال رابط إعادة التعيين';
  static const String resendResetLinkButton = 'إعادة إرسال رابط التعيين';
  static const String openResetPasswordDemo = 'فتح شاشة إعادة التعيين للتجربة';

  // Reset Password
  static const String resetPasswordPageTitle = 'تعيين كلمة مرور جديدة';
  static const String resetPasswordPageSubtitle =
      'أدخل رمز التحقق وكلمة المرور الجديدة للمتابعة.';

  static const String resetPasswordSideTitle = 'حماية حساب المؤسسة';
  static const String resetPasswordSideSubtitle =
      'اختر كلمة مرور قوية لحماية بيانات المؤسسة ومساحة العمل الخاصة بها.';

  static const List<String> resetPasswordSideItems = [
    '8 أحرف على الأقل',
    'يفضل استخدام رقم ورمز خاص',
    'لا تستخدم كلمة مرور مشتركة',
  ];

  static const String resetPasswordTitle = 'إعادة تعيين كلمة المرور';
  static const String resetPasswordSubtitle =
      'أدخل رمز التحقق المرسل إلى بريدك ثم اختر كلمة مرور جديدة.';

  static const String verificationCodeLabel = 'رمز التحقق';
  static const String verificationCodeHint = 'أدخل رمز التحقق';
  static const String verificationCodeRequired = 'رمز التحقق مطلوب';
  static const String verificationCodeInvalid = 'رمز التحقق غير صحيح';

  static const String newPasswordLabel = 'كلمة المرور الجديدة';
  static const String newPasswordHint = 'أدخل كلمة المرور الجديدة';

  static const String confirmPasswordLabel = 'تأكيد كلمة المرور';
  static const String confirmPasswordHint = 'أعد إدخال كلمة المرور';
  static const String confirmPasswordRequired = 'تأكيد كلمة المرور مطلوب';
  static const String passwordsDoNotMatch = 'كلمتا المرور غير متطابقتين';

  static const String changePasswordButton = 'تغيير كلمة المرور';
  static const String passwordChangedSuccess = 'تم تغيير كلمة المرور بنجاح';
}