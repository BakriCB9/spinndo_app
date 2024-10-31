import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snipp/auth/view/screen/employee_details.dart';
import 'package:snipp/profile/view/screen/profile_screen.dart';

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

  void verifyCode(bool isClient,bool isLogIn) {
    // Code to verify the entered code
    if(!isLogIn) {
      isClient ? Navigator.of(context).pushNamed(TestWidget.routeName) :
      Navigator.of(context).pushNamed(EmployeeDetails.routeName);
    }else{
      Navigator.of(context).pushNamed(TestWidget.routeName);
    }
    print('Verification code entered: ${codeController.text}');
    // Add your verification logic here
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
    bool args = ModalRoute.of(context)!.settings.arguments as bool;
    bool argsLog = ModalRoute.of(context)!.settings.arguments as bool;
    return Scaffold(
      appBar: AppBar(
        title: Text('Email Verification'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.email, size: 100.h, color: Colors.blue),
            SizedBox(height: 20.h),
            Text(
              'Enter the verification code sent to your email',
              style: TextStyle(fontSize: 18.sp),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.h),
            TextField(
              controller: codeController,
              maxLength: 6,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter Code',
                counterText: '',
              ),
            ),
            SizedBox(height: 20.h),
            ElevatedButton(
              onPressed: (){
                 verifyCode(args,argsLog);

              },
              child: Text('Verify', style: TextStyle(fontSize: 18.sp,color: Colors.blue)),
              style: ButtonStyle(
                padding: MaterialStateProperty.all(
                    EdgeInsets.symmetric(vertical: 12.h, horizontal: 24.w)),
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

