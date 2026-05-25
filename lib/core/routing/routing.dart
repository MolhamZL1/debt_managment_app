import 'package:debt_managment_app/features/auth/presentation/views/sign_in_view.dart';
import 'package:debt_managment_app/features/auth/presentation/views/verf_code_view.dart';
import 'package:debt_managment_app/features/onboarding/presentation/views/onboarding_view.dart';
import 'package:debt_managment_app/features/settings/presentation/view/about_us_view.dart';
import 'package:debt_managment_app/features/settings/presentation/view/privacy_policy_view.dart';
import 'package:flutter/material.dart';

import '../../features/auth/presentation/views/check_code_reset_password.dart';
import '../../features/auth/presentation/views/forget_password_view.dart';
import '../../features/auth/presentation/views/reset_password_view.dart';
import '../../features/auth/presentation/views/sign_up_view.dart';
import '../../features/clientes/presentation/views/client_detelies_view.dart';
import '../../features/main/presntation/views/main_view.dart';
import '../../features/settings/presentation/view/help_view.dart';
import '../../features/settings/presentation/view/terms_and_conditions_view.dart';
import '../../features/splash/splash_view.dart';

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashView.routename:
      return MaterialPageRoute(builder: (_) => const SplashView());
    case OnboardingView.routename:
      return MaterialPageRoute(builder: (_) => const OnboardingView());
    case SignInView.routename:
      return MaterialPageRoute(builder: (_) => const SignInView());
    case SignUpView.routename:
      return MaterialPageRoute(builder: (_) => const SignUpView());
    case VerfCodeView.routename:
      return MaterialPageRoute(
        builder: (_) {
          final String email = settings.arguments as String;
          return VerfCodeView(email: email);
        },
      );
    case ForgetPasswordView.routename:
      return MaterialPageRoute(builder: (_) => const ForgetPasswordView());
    case CheckCodeResetPasswordView.routename:
      return MaterialPageRoute(
        builder: (_) {
          final String email = settings.arguments as String;
          return CheckCodeResetPasswordView(email: email);
        },
      );
    case ResetPasswordView.routename:
      return MaterialPageRoute(
        builder: (_) {
          final String email = settings.arguments as String;
          return ResetPasswordView(email: email);
        },
      );
    case MainView.routename:
      return MaterialPageRoute(builder: (_) => const MainView());
    case ClientDeteliesView.routename:
      return MaterialPageRoute(
        builder: (_) {
          final data = settings.arguments as Map<String, dynamic>;
          final id = data["id"];
          final name = data["name"];
          return ClientDeteliesView(clinetId: id as int, name: name as String);
        },
      );
    case HelpPage.routename:
      return MaterialPageRoute(builder: (_) => const HelpPage());
    case AboutUsPage.routename:
      return MaterialPageRoute(builder: (_) => const AboutUsPage());

    case PrivacyPolicyView.routename:
      return MaterialPageRoute(builder: (_) => const PrivacyPolicyView());
    case TermsAndConditionsView.routename:
      return MaterialPageRoute(builder: (_) => const TermsAndConditionsView());
    default:
      return MaterialPageRoute(builder: (context) => Scaffold());
  }
}
