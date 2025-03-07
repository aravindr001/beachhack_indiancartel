import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kaam_hai/Features/Auth/presentation/category_selector.dart';
import 'package:kaam_hai/Features/Auth/presentation/login_page.dart';
import 'package:kaam_hai/Features/Auth/presentation/sign_up_page.dart';
import 'package:kaam_hai/Features/employee/presentation/worker_pages_router.dart';
import 'package:kaam_hai/firebase_options.dart';
import 'Features/Auth/bloc/auth_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    print('fucked: $e');
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(FirebaseAuth.instance),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: const Color(0xFF6200EE),
          scaffoldBackgroundColor: const Color(0xFFF5F5F5),
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: const Color(0xFF6200EE),
            secondary: const Color(0xFF03DAC6),
            error: const Color(0xFFB00020),
            surface: const Color(0xFFFFFFFF),
          ),
          textTheme: const TextTheme(
            displayLarge: TextStyle(
              color: Color(0xFF6200EE),
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
            displayMedium: TextStyle(
              color: Color(0xFF03DAC6),
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
            bodyLarge: TextStyle(color: Color(0xFF000000), fontSize: 16),
            bodyMedium: TextStyle(color: Color(0xFF757575), fontSize: 14),
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF6200EE),
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          buttonTheme: const ButtonThemeData(
            buttonColor: Color(0xFF6200EE),
            textTheme: ButtonTextTheme.primary,
          ),
        ),
        // home: LoginPage(phoneNumber: "8687696", verificationId: "123456"),
        home: const SignUpPage(),
      ),
    );
  }
}
