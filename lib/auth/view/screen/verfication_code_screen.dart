import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snipp/auth/view/screen/employee_details.dart';
import 'package:snipp/auth/view/widgets/custom_text_form_field.dart';
import 'package:snipp/profile/view/screen/profile_screen.dart';

import '../sign_up/account_type_screen.dart';

class VerficationCodeScreen extends StatefulWidget {
    static const String routeName = '/verfication';

  @override
  _VerficationCodeScreenState createState() => _VerficationCodeScreenState();
}

class _VerficationCodeScreenState extends State<VerficationCodeScreen> {


  TextEditingController codeController = TextEditingController();
  int _start = 30;
  bool _canResend = false;
  late Timer _timer;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    _start = 30;
    _canResend = false;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_start > 0) {
          _start--;
        } else {
          _canResend = true;
          timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    codeController.dispose();
    _timer.cancel();
    super.dispose();
  }



  void resendCode() {
    if (_canResend) {
      print('Resending code...');
      startTimer();
      // Add resend code logic here
    }
  }

  @override
  Widget build(BuildContext context) {
    // bool args = ModalRoute.of(context)!.settings.arguments as bool;
    bool argsLog = ModalRoute.of(context)!.settings.arguments as bool;
    return Scaffold(
      backgroundColor: Color(0xFFF0F8FF),
      // resizeToAvoidBottomInset: true,
      appBar: AppBar(

        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Check your email",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28.sp,
                  fontFamily: "WorkSans"),
            ),
            SizedBox(height: 10.h,),
            Icon(Icons.email, size: 100.h, color: Colors.blue),
            SizedBox(height: 20.h),
            Text(
              'Enter the verification code sent to your email',
              style: TextStyle(fontSize: 18.sp),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: Form(
                key: formKey,
                child: TextFormField(
                  validator:  (p1) {
                    if (p1 == null || p1.isEmpty) {
                      return "Password cannott be empty";
                    } else if (p1.length < 6) {
                      return "should be at least 6 charcters";
                    }
                    return null;
                  },
                  controller: codeController,
                  maxLength: 6,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue.shade300)
                    ),
                    enabledBorder:  OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue.shade300)
                    ),focusedBorder:  OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue.shade300)
                  ),
                    hintText: 'Enter Code',
                    fillColor: Colors.white,

                    filled: true,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: (){
    if(formKey.currentState?.validate() == true) {
      // if(!isLogIn) {
      //   isClient ? Navigator.of(context).pushNamed(TestWidget.routeName) :
      //   Navigator.of(context).pushNamed(EmployeeDetails.routeName);
      // }else{
      argsLog?Navigator.of(context).pushNamed(TestWidget.routeName):Navigator.of(context).pushNamed(AccountTypeScreen.routeName);
      // }
    }
                },
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
            SizedBox(height: 20.h),
            Text(
              _canResend
                  ? 'Didn\'t receive a code?'
                  : 'Resend code in $_start seconds',
              style: TextStyle(fontSize: 16.sp),
            ),
            TextButton(
              onPressed: _canResend ? resendCode : null,
              child: Text(
                'Resend Code',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: _canResend ? Colors.blue : Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

