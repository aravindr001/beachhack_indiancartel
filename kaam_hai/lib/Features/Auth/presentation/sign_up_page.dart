// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:kaam_hai/Features/Auth/presentation/category_selector.dart';
// import 'package:kaam_hai/Features/employee/presentation/worker_home_page.dart';

// class SignUpPage extends StatefulWidget {
//   const SignUpPage({super.key});

//   @override
//   State<SignUpPage> createState() => _SignUpPageState();
// }

// class _SignUpPageState extends State<SignUpPage> {
//   final phoneController = TextEditingController();
//   final otpController = TextEditingController();
//   bool showOTP = false;
//   bool isLoading = false;
//   String verificationId = '';

//   void navigateToHomePage() {
//     Navigator.of(context).pushReplacement(
//       MaterialPageRoute(builder: (context) => const SelectRolePage()),
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
//                 AnimatedCrossFade(
//                   duration: const Duration(milliseconds: 300),
//                   crossFadeState:
//                       !showOTP
//                           ? CrossFadeState.showFirst
//                           : CrossFadeState.showSecond,
//                   firstChild: Column(
//                     children: [
//                       TextField(
//                         controller: phoneController,
//                         keyboardType: TextInputType.phone,
//                         inputFormatters: [
//                           FilteringTextInputFormatter.digitsOnly,
//                           LengthLimitingTextInputFormatter(10),
//                         ],
//                         decoration: const InputDecoration(
//                           labelText: 'Phone Number',
//                           prefixText: '+91 ',
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.all(
//                               Radius.circular(8.0),
//                             ),
//                           ),
//                           fillColor: Color(0xFFF5F5F5),
//                           filled: true,
//                         ),
//                       ),
//                       const SizedBox(height: 16.0),
//                       SizedBox(
//                         width: double.infinity,
//                         child: ElevatedButton(
//                           onPressed:
//                               isLoading
//                                   ? null
//                                   : () {
//                                     if (phoneController.text.length == 10) {
//                                       setState(() {
//                                         showOTP = true;
//                                       });
//                                     } else {
//                                       ScaffoldMessenger.of(
//                                         context,
//                                       ).showSnackBar(
//                                         const SnackBar(
//                                           content: Text(
//                                             'Please enter a valid 10-digit phone number',
//                                           ),
//                                         ),
//                                       );
//                                     }
//                                   },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: const Color(0xFF6200EE),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(8.0),
//                             ),
//                           ),
//                           child:
//                               isLoading
//                                   ? const SizedBox(
//                                     height: 20,
//                                     width: 20,
//                                     child: CircularProgressIndicator(
//                                       strokeWidth: 2,
//                                       valueColor: AlwaysStoppedAnimation<Color>(
//                                         Colors.white,
//                                       ),
//                                     ),
//                                   )
//                                   : const Text(
//                                     'Send OTP',
//                                     style: TextStyle(color: Colors.white),
//                                   ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   secondChild: Column(
//                     children: [
//                       TextField(
//                         controller: otpController,
//                         keyboardType: TextInputType.number,
//                         inputFormatters: [
//                           FilteringTextInputFormatter.digitsOnly,
//                           LengthLimitingTextInputFormatter(6),
//                         ],
//                         decoration: const InputDecoration(
//                           labelText: 'OTP',
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.all(
//                               Radius.circular(8.0),
//                             ),
//                           ),
//                           fillColor: Color(0xFFF5F5F5),
//                           filled: true,
//                         ),
//                       ),
//                       const SizedBox(height: 16.0),
//                       SizedBox(
//                         width: double.infinity,
//                         child: ElevatedButton(
//                           onPressed:
//                               isLoading
//                                   ? null
//                                   : () {
//                                     navigateToHomePage();
//                                   },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: const Color(0xFF6200EE),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(8.0),
//                             ),
//                           ),
//                           child:
//                               isLoading
//                                   ? const SizedBox(
//                                     height: 20,
//                                     width: 20,
//                                     child: CircularProgressIndicator(
//                                       strokeWidth: 2,
//                                       valueColor: AlwaysStoppedAnimation<Color>(
//                                         Colors.white,
//                                       ),
//                                     ),
//                                   )
//                                   : const Text(
//                                     'Verify OTP',
//                                     style: TextStyle(color: Colors.white),
//                                   ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 16.0),
//                 // Placeholder for BlocListener and BlocBuilder
//                 // Remove or replace with actual logic if needed
//                 Container(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kaam_hai/Features/Auth/Services/auth_service.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
  }

  void signUp() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      showToast("Email and Password cannot be empty");
      return;
    }
    if (password.length < 6) {
      showToast("Password must be at least 6 characters");
      return;
    }

    setState(() => isLoading = true);

    try {
      User? user = await AuthService().signUp(email, password);
      if (user != null) {
        Fluttertoast.showToast(
          msg: "Sign up successful!",
          backgroundColor: Colors.green,
        );
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        showToast("Sign up failed. Try again.");
      }
    } on FirebaseAuthException catch (e) {
      showToast(e.message ?? "Sign up error");
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign Up")),
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
            isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(onPressed: signUp, child: Text("Sign Up")),
            TextButton(
              onPressed: () => Navigator.pushNamed(context, '/login'),
              child: Text("Already have an account? Log In"),
            ),
          ],
        ),
      ),
    );
  }
}
