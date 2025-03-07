import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class PhoneAuthPage extends StatefulWidget {
  const PhoneAuthPage({super.key});

  @override
  _PhoneAuthPageState createState() => _PhoneAuthPageState();
}

class _PhoneAuthPageState extends State<PhoneAuthPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  String? verificationId;
  bool otpSent = false;
  bool isLoading = false;

  void sendOTP() async {
    setState(() => isLoading = true);
    await _auth.verifyPhoneNumber(
      phoneNumber: "+91${_phoneController.text.trim()}",
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
        Fluttertoast.showToast(msg: "Auto login successful!");
      },
      verificationFailed: (FirebaseAuthException e) {
        Fluttertoast.showToast(msg: "Verification Failed: ${e.message}");
        setState(() => isLoading = false);
      },
      codeSent: (String id, int? resendToken) {
        setState(() {
          verificationId = id;
          otpSent = true;
          isLoading = false;
        });
        Fluttertoast.showToast(msg: "OTP Sent!");
      },
      codeAutoRetrievalTimeout: (String id) {},
    );
  }

  void verifyOTP() async {
    setState(() => isLoading = true);
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId!,
        smsCode: _otpController.text.trim(),
      );
      await _auth.signInWithCredential(credential);
      Fluttertoast.showToast(msg: "Login Successful!");
    } catch (e) {
      Fluttertoast.showToast(msg: "Invalid OTP!");
    }
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Phone Login",
                style: GoogleFonts.poppins(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: "Enter Phone Number",
                  prefixText: "+91 ",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.black26),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              otpSent
                  ? TextField(
                    controller: _otpController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Enter OTP",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.black26),
                      ),
                    ),
                  )
                  : Container(),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed:
                      isLoading
                          ? null
                          : otpSent
                          ? verifyOTP
                          : sendOTP,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child:
                      isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Text(
                            otpSent ? "Verify OTP" : "Send OTP",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
