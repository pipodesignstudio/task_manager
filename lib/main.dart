import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:task_manager/providers/auth_provider.dart';
import 'package:task_manager/providers/login_form_provider.dart';
import 'package:task_manager/providers/navigator_provider.dart';
import 'package:task_manager/providers/reset_pass_form_provider.dart';
import 'package:task_manager/providers/signup_form_provider.dart';
import 'package:task_manager/screens/home_screen.dart';
import 'package:task_manager/screens/launch_screen.dart';
import 'package:task_manager/screens/login_screen.dart';
import 'package:task_manager/screens/reset_password_screen.dart';
import 'package:task_manager/screens/signup_screen.dart';
import 'package:task_manager/screens/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/shared/custom_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_manager/widgets/loading_toast.dart';

import 'services/user_creation_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),
        Provider(
          create: (_) => SignUpFormProvider(),
        ),
        Provider(create: (_) => LoginFormProvider()),
        Provider(create: (_) => ResetPassFormProvider(),),
        ChangeNotifierProvider(
          create: (_) => UserCreationService(),
        )
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: NavigatorService.navigatorKey,
      title: 'Task Manager',
      routes: {
        'splash': (_) => const SplashScreen(),
        'launch': (_) => const LaunchScreen(),
        'home': (_) => const HomeScreen(),
        'resetpass' : (_) => const ResetPasswordScreen(),
        'login': (_) => const LoginScreen(),
        'signup': (_) => const SignupScreen()
      },
      initialRoute: 'splash',
      navigatorObservers: [FlutterSmartDialog.observer],
      builder: FlutterSmartDialog.init(
        loadingBuilder: (String msg, Color background) {
          return const CustomLoadingToast();
        },
      ),
      theme: ThemeData.light().copyWith(
          textTheme: TextTheme(
              headline1: GoogleFonts.inter(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: CustomColors.headings),
              headline3: GoogleFonts.inter(
                  fontSize: 22,
                  color: CustomColors.headings,
                  fontWeight: FontWeight.w500),
              bodyText1: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: CustomColors.body)),
          textSelectionTheme:
              const TextSelectionThemeData(cursorColor: CustomColors.primary),
          primaryColor: CustomColors.primary,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme:
              const AppBarTheme(elevation: 0, backgroundColor: Colors.white)),
    );
  }
}
