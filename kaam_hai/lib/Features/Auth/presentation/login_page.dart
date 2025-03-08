// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// // import 'package:kaam_hai/Features/Auth/presentation/sign_up_page.dart';
// // import '../bloc/auth_bloc.dart';
// // import '../bloc/auth_event.dart';
// // import '../bloc/auth_state.dart';
// // import '../../employee/presentation/worker_home_page.dart';

// // class LoginPage extends StatefulWidget {
// //   const LoginPage({super.key});

// //   @override
// //   State<LoginPage> createState() => _LoginPageState();
// // }

// // class _LoginPageState extends State<LoginPage> {
// //   final emailController = TextEditingController();
// //   final passwordController = TextEditingController();

// //   @override
// //   void dispose() {
// //     emailController.dispose();
// //     passwordController.dispose();
// //     super.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(

// //       body: Stack(
// //         children: [
// //           Positioned.fill(
// //             child: Container(
// //               decoration: const BoxDecoration(
// //                 image: DecorationImage(
// //                   image: AssetImage('assets/background_image.jpg'),
// //                   fit: BoxFit.cover,
// //                 ),
// //               ),
// //             ),
// //           ),
// //           Scaffold(
// //             backgroundColor: Colors.transparent,
// //             body: BlocListener<AuthBloc, AuthState>(
// //               listener: (context, state) {
// //                 if (state is AuthSuccess) {
// //                   // Clear text fields before navigation
// //                   emailController.clear();
// //                   passwordController.clear();
// //                   Navigator.of(context).pushReplacement(
// //                     MaterialPageRoute(builder: (context) => const HomePage()),
// //                   );
// //                 } else if (state is AuthError) {
// //                   ScaffoldMessenger.of(context)
// //                     ..hideCurrentSnackBar()
// //                     ..showSnackBar(
// //                       SnackBar(
// //                         content: Text(state.message),
// //                         backgroundColor: Colors.red,
// //                       ),
// //                     );
// //                 }
// //               },
// //               child: Center(
// //                 child: Card(
// //                   color: Colors.white,
// //                   elevation: 8.0,
// //                   margin: const EdgeInsets.all(16.0),
// //                   child: Padding(
// //                     padding: const EdgeInsets.all(16.0),
// //                     child: SingleChildScrollView(
// //                       child: Column(
// //                         mainAxisSize: MainAxisSize.min,
// //                         mainAxisAlignment: MainAxisAlignment.center,
// //                         children: <Widget>[
// //                           TextField(
// //                             controller: emailController,
// //                             decoration: const InputDecoration(
// //                               labelText: 'Email',
// //                               border: OutlineInputBorder(
// //                                 borderRadius: BorderRadius.all(Radius.circular(8.0)),
// //                               ),
// //                               fillColor: Color(0xFFF5F5F5),
// //                               filled: true,
// //                             ),
// //                           ),
// //                           const SizedBox(height: 16.0),
// //                           TextField(
// //                             controller: passwordController,
// //                             decoration: const InputDecoration(
// //                               labelText: 'Password',
// //                               border: OutlineInputBorder(
// //                                 borderRadius: BorderRadius.all(Radius.circular(8.0)),
// //                               ),
// //                               fillColor: Color(0xFFF5F5F5),
// //                               filled: true,
// //                             ),
// //                             obscureText: true,
// //                           ),
// //                           const SizedBox(height: 16.0),
// //                           BlocBuilder<AuthBloc, AuthState>(
// //                             builder: (context, state) {
// //                               return Column(
// //                                 children: [
// //                                   SizedBox(
// //                                     width: double.infinity,
// //                                     child: ElevatedButton(
// //                                       onPressed: state is AuthLoading
// //                                           ? null
// //                                           : () {
// //                                               final email = emailController.text.trim();
// //                                               final password = passwordController.text;

// //                                               if (email.isEmpty || password.isEmpty) {
// //                                                 ScaffoldMessenger.of(context)
// //                                                   ..hideCurrentSnackBar()
// //                                                   ..showSnackBar(
// //                                                     const SnackBar(
// //                                                       content: Text('Please fill in all fields'),
// //                                                       backgroundColor: Colors.orange,
// //                                                     ),
// //                                                   );
// //                                                 return;
// //                                               }

// //                                               context.read<AuthBloc>().add(
// //                                                 LoginEvent(
// //                                                   email: email,
// //                                                   password: password,
// //                                                 ),
// //                                               );
// //                                             },
// //                                       style: ElevatedButton.styleFrom(
// //                                         backgroundColor: const Color.fromRGBO(255, 160, 88, 1),
// //                                         shape: RoundedRectangleBorder(
// //                                           borderRadius: BorderRadius.circular(8.0),
// //                                         ),
// //                                       ),
// //                                       child: state is AuthLoading
// //                                           ? const SizedBox(
// //                                               height: 20,
// //                                               width: 20,
// //                                               child: CircularProgressIndicator(
// //                                                 strokeWidth: 2,
// //                                                 color: Colors.white,
// //                                               ),
// //                                             )
// //                                           : const Text('Login'),
// //                                     ),
// //                                   ),
// //                                   const SizedBox(height: 16.0),
// //                                   SizedBox(
// //                                     width: double.infinity,
// //                                     child: ElevatedButton.icon(
// //                                       onPressed: () {
// //                                         context.read<AuthBloc>().add(GoogleSignInEvent());
// //                                       },
// //                                       icon: const FaIcon(
// //                                         FontAwesomeIcons.google,
// //                                         color: Colors.red,
// //                                       ),
// //                                       label: const Text('Sign in with Google'),
// //                                       style: ElevatedButton.styleFrom(
// //                                         foregroundColor: Colors.black,
// //                                         backgroundColor: Colors.white,
// //                                         side: const BorderSide(color: Colors.grey),
// //                                         shape: RoundedRectangleBorder(
// //                                           borderRadius: BorderRadius.circular(8.0),
// //                                         ),
// //                                       ),
// //                                     ),
// //                                   ),
// //                                   const SizedBox(height: 16.0),
// //                                   TextButton(
// //                                     onPressed: () {
// //                                       Navigator.of(context).push(
// //                                         MaterialPageRoute(builder: (context) => const SignUpPage()),
// //                                       );
// //                                     },
// //                                     child: const Text('Don\'t have an account? Sign Up'),
// //                                   ),
// //                                   const SizedBox(height: 16.0),
// //                                 ],
// //                               );
// //                             },
// //                           ),
// //                         ],
// //                       ),
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:kaam_hai/Features/Auth/presentation/category_selector.dart';

// class LoginPage extends StatefulWidget {
//   final String phoneNumber;
//   final String verificationId;

//   const LoginPage({super.key, required this.phoneNumber, required this.verificationId});

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final otpController = TextEditingController();
//   bool isLoading = false;

//   @override
//   void dispose() {
//     otpController.dispose();
//     super.dispose();
//   }

//   void verifyOTP() {
//     if (otpController.text.length != 6) {
//       _handleError('Please enter a valid 6-digit OTP');
//       return;
//     }

//     setState(() => isLoading = true);
//     Navigator.of(context).pushReplacement(
//       MaterialPageRoute(builder: (context) => const SelectRolePage()),
//     );
//   }

//   void _handleError(String message) {
//     setState(() => isLoading = false);
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text(message)),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF6200EE),
//       body: Center(
//         child: Card(
//           color: Colors.white,
//           elevation: 8.0,
//           margin: const EdgeInsets.all(16.0),
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: <Widget>[
//                 Text(
//                   'Enter OTP sent to +91 ${widget.phoneNumber}',
//                   style: const TextStyle(
//                     fontSize: 14,
//                     color: Colors.grey,
//                   ),
//                 ),
//                 const SizedBox(height: 16.0),
//                 TextField(
//                   controller: otpController,
//                   keyboardType: TextInputType.number,
//                   inputFormatters: [
//                     FilteringTextInputFormatter.digitsOnly,
//                     LengthLimitingTextInputFormatter(6),
//                   ],
//                   decoration: const InputDecoration(
//                     labelText: 'Enter OTP',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(8.0)),
//                     ),
//                     fillColor: Color(0xFFF5F5F5),
//                     filled: true,
//                   ),
//                 ),
//                 const SizedBox(height: 16.0),
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: isLoading ? null : () {
//                       verifyOTP();
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFF6200EE),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8.0)),
//                     ),
//                     child: isLoading
//                         ? const SizedBox(
//                             height: 20,
//                             width: 20,
//                             child: CircularProgressIndicator(
//                               strokeWidth: 2,
//                               valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//                             ),
//                           )
//                         : const Text(
//                           'Sign In',
//                           style: TextStyle(color: Colors.white),
//                           ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//     ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kaam_hai/Features/Auth/Services/auth_service.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void logIn() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    User? user = await AuthService().logIn(email, password);
    if (user != null) {
      print("User logged in: ${user.email}");
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      print("Login failed");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: logIn, child: Text("Log In")),
            TextButton(
              onPressed: () => Navigator.pushNamed(context, '/signup'),
              child: Text("Don't have an account? Sign Up"),
            ),
          ],
        ),
      ),
    );
  }
}
