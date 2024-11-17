import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snipp/core/utils/ui_utils.dart';
import 'package:snipp/features/auth/data/models/verify_code_request.dart';
import 'package:snipp/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:snipp/features/auth/presentation/cubit/auth_states.dart';
import 'package:snipp/features/profile/presentation/screens/profile_screen.dart';
import '../../../../core/di/service_locator.dart';

class VerficationCodeScreen extends StatefulWidget {
  static const String routeName = '/verfication';

  const VerficationCodeScreen({super.key});

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
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
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
      startTimer();
      // Add resend code logic here
    }
  }

  final _authCubit = serviceLocator.get<AuthCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F8FF),
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
                  fontSize: 48.sp,
                  fontFamily: "WorkSans"),
            ),
            SizedBox(
              height: 10.h,
            ),
            Icon(Icons.email, size: 200.h, color: Colors.blue),
            SizedBox(height: 20.h),
            Text(
              'Enter the verification code sent to your email ${_authCubit.emailController.text}',
              style: TextStyle(fontSize: 32.sp),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: Form(
                key: formKey,
                child: TextFormField(
                  validator: (p1) {
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
                        borderSide: BorderSide(color: Colors.blue.shade300)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue.shade300)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue.shade300)),
                    hintText: 'Enter Code',
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            BlocListener(
              bloc: _authCubit,
              listener: (_, state) {
                if (state is LoginLoading) {
                  UIUtils.showLoading(context);
                } else if (state is LoginSuccess) {
                  UIUtils.hideLoading(context);
                  // Navigator.of(context).pushNamed();
                } else if (state is LoginError) {
                  UIUtils.hideLoading(context);
                  UIUtils.showMessage(state.message);
                }
              },
              child: SizedBox(
                width: double.infinity,
                child: BlocListener<AuthCubit,AuthState>(
                  listener: (contexxt,state ){
                    if(state is  VerifyCodeLoading){
                      UIUtils.showLoading(context);
                    }
                    else if(state is VerifyCodeError){
                      UIUtils.showMessage(state.message);
                    }
                    else if (state is VerifyCodeSuccess){
                      UIUtils.hideLoading(context);
                      Navigator.of(context).pushReplacementNamed(Profile_Screen.routeName);
                    }
                  },
                  child: ElevatedButton(
                    onPressed: _verifyCode
                    //     () {
                    //   if (formKey.currentState?.validate() == true) {
                    //     // if(!isLogIn) {
                    //     //   isClient ? Navigator.of(context).pushNamed(TestWidget.routeName) :
                    //     //   Navigator.of(context).pushNamed(EmployeeDetails.routeName);
                    //     // }else{
                    //     Navigator.of(context)
                    //         .pushNamed(AccountTypeScreen.routeName);
                    //     // }
                    //   }
                    // },
                    ,
                    style: ButtonStyle(
                        backgroundColor:
                            const WidgetStatePropertyAll(Colors.white),
                        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                            side: const BorderSide(color: Colors.blue, width: 1),
                            borderRadius: BorderRadius.circular(30.r))),
                        padding: WidgetStatePropertyAll(
                            EdgeInsets.symmetric(vertical: 16.h))),
                    child: Text('Verify',
                        style: TextStyle(fontSize: 32.sp, color: Colors.blue)),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              _canResend
                  ? 'Didn\'t receive a code?'
                  : 'Resend code in $_start seconds',
              style: TextStyle(fontSize: 30.sp),
            ),
            TextButton(
              onPressed: _canResend ? resendCode : null,
              child: Text(
                'Resend Code',
                style: TextStyle(
                  fontSize: 30.sp,
                  color: _canResend ? Colors.blue : Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _verifyCode() {
// if(formKey.currentState?.validate()==true){
//     Navigator.of(context).pushNamed(
//       TestWidget.routeName,
//     );
// }

    if (formKey.currentState?.validate() == true) {
      // if(!isLogIn) {
      //   isClient ? Navigator.of(context).pushNamed(TestWidget.routeName) :
      //   Navigator.of(context).pushNamed(EmployeeDetails.routeName);
      // }else{
       
      //Navigator.of(context).pushNamed(Profile_Screen.routeName);
      // }
      _authCubit.verifyCode(VerifyCodeRequest(
        email: _authCubit.emailController.text, code: codeController.text));
    }
    
  }
}
