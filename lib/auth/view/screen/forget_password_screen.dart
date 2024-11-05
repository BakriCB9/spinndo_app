import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snipp/auth/view/screen/reset_password_screen.dart';
import 'package:snipp/auth/view/widgets/custom_text_form_field.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  static const String routeName='/forget';

  void _navigateToResetPassword(BuildContext context) {
    if(formKey.currentState?.validate() == true) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ResetPasswordScreen()),
    );}
  }
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0F8FF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Reset Password",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28.sp,
                      fontFamily: "WorkSans"),
                ),
                SizedBox(
                  height: 4.h,
                ),
                Text(
                  "we will send an email to you with code to reset password",
                  style:
                  TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w300),
                ),
              ],
            ),
            Icon(Icons.lock_reset, size: 100.h, color: Colors.blue),
            SizedBox(height: 20.h),
            Text(
              'Enter your email to reset your password',
              style: TextStyle(fontSize: 18.sp,),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.h),

            Form(key: formKey,
              child: TextFormField(validator:  (p1) {
                if (p1 == null || p1.isEmpty) {
                  return "Password cannott be empty";
                } else if (p1.length < 6) {
                  return "should be at least 6 charcters";
                }
                return null;
              },
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue.shade300)
                  ),
                  enabledBorder:  OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue.shade300)
                  ),focusedBorder:  OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue.shade300)
                ),fillColor: Colors.white,
                  filled: true,
                ),

                keyboardType: TextInputType.emailAddress,

              ),
            ),
Spacer(),            Container(
              width: double.infinity,
              margin: EdgeInsets.only(bottom: 40.h),
              child: ElevatedButton(
                onPressed: () => _navigateToResetPassword(context),

                child: Text('Verify', style: TextStyle(fontSize: 18.sp,color: Colors.blue)),
                style : ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.white),
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                        side: BorderSide(color: Colors.blue,width: 1),
                        borderRadius: BorderRadius.circular(30.r))) ,
                    padding: WidgetStatePropertyAll(
                        EdgeInsets.symmetric(vertical: 16.h))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
