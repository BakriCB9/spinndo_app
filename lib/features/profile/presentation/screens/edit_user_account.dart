import 'package:app/core/utils/ui_utils.dart';
import 'package:app/features/profile/data/models/client_update/update_account_profile.dart';
import 'package:app/features/profile/data/models/provider_update/update_provider_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/core/di/service_locator.dart';
import 'package:app/core/widgets/custom_text_form_field.dart';
import 'package:app/core/widgets/custom_text_form_field_bakri.dart';
import 'package:app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:app/features/profile/presentation/cubit/profile_states.dart';

class EditUserAccountScreen extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String typeAccount;

  const EditUserAccountScreen(
      {required this.firstName,
      required this.lastName,
      required this.typeAccount,
      super.key});

  @override
  Widget build(BuildContext context) {
    final _profileCubit = serviceLocator.get<ProfileCubit>();
    _profileCubit.firstNameEditController.text = firstName;
    _profileCubit.lastNameEditController.text = lastName;

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 15.h),
              Align(
                alignment: Alignment.center,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      child: CircleAvatar(
                        radius: 150.r,
                        backgroundColor: Colors.grey,
                        child: Icon(
                          Icons.person,
                          size: 150.r,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      right: 10.w,
                      child: Container(
                        width: 80.r,
                        height: 80.r,
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.black,
                          size: 50.r,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // CustomTextFromFieldBakri(
              //   icon: Icons.person_2_outlined,
              //   label: 'First Name',
              //   initialvalue: 'Bakri',
              // ),
              //  CustomTextFormField( labelText: 'FirstName',controller: _profileCubit.firstNameEditController,initValue: 'bakri',icon: Icons.person,),
              // SizedBox(height: 40.h),
              // CustomTextFormField( labelText: 'Last Name',controller: _profileCubit.lastNameEditController,initValue: 'aweja',icon: Icons.person,),
              // SizedBox(height: 40.h),

              // CustomTextFromFieldBakri(
              //   icon: Icons.person_2_outlined,
              //   label: 'Last Name',
              //   initialvalue: 'aweja',
              // ),
              // CustomTextFormField(labelText: 'Email', controller: _profileCubit.emailEditController,initValue: 'bakkaraweja@gmail.com',icon: Icons.email,),
              // SizedBox(height: 40.h),
              // CustomTextFromFieldBakri(
              //   icon: Icons.email_outlined,
              //   label: 'Email',
              //   initialvalue: 'bakriaweja@gmail.com',
              // ),
              // SizedBox(height: 40.h),
              // CustomTextFromFieldBakri(
              //   icon: Icons.phone,
              //   label: 'Phone',
              //   initialvalue: '0959280119',
              // ),

              SizedBox(
                height: 70.h,
              ),
              TextFormField(
                controller: _profileCubit.firstNameEditController,
                style: TextStyle(color: Colors.black, fontSize: 25.sp),
                onChanged: (value) {
                  print('');
                  _profileCubit.updateInfo(
                      curFirst: firstName,
                      newFirst: _profileCubit.firstNameEditController.text,
                      curLast: lastName,
                      newLast: _profileCubit.lastNameEditController.text);
                },
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.person),
                    labelText: 'FirstName',
                    labelStyle:
                        TextStyle(color: Colors.black, fontSize: 20.sp)),
              ),
              SizedBox(
                height: 50.h,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Error';
                  }
                },
                controller: _profileCubit.lastNameEditController,
                style: TextStyle(color: Colors.black, fontSize: 25.sp),
                onChanged: (value) {
                  _profileCubit.updateInfo(
                      curFirst: firstName,
                      newFirst: _profileCubit.firstNameEditController.text,
                      curLast: lastName,
                      newLast: _profileCubit.lastNameEditController.text);
                },
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.person),
                    labelText: "LastName",
                    labelStyle:
                        TextStyle(color: Colors.black, fontSize: 20.sp)),
              ),
              SizedBox(height: 30.h),

              BlocBuilder<ProfileCubit, ProfileStates>(buildWhen: (pre, cur) {
                if (cur is IsUpdated || cur is IsNotUpdated) return true;
                return false;
              }, builder: (context, state) {
                print('the State is ${state}');


                if (state is IsUpdated) {
                  return BlocListener<ProfileCubit, ProfileStates>(
                    listenWhen: (pre, cur) {
                      if (cur is UpdateLoading||
                      cur is UpdateError||
                      cur is UpdateSuccess) {
                        return true;
                      }
                      return false;
                    },
                    listener: (context, state) {
                      if (state is UpdateLoading) {
                        UIUtils.showLoading(context);
                      } else if (state is UpdateError) {
                        UIUtils.hideLoading(context);
                        UIUtils.showMessage(state.message);
                      } else if (state is UpdateSuccess) {
                        UIUtils.hideLoading(context);
                        Navigator.of(context).pop();
                        _profileCubit.getUserRole();
                      }
                    },
                    child: ElevatedButton(
                        onPressed: () {
                          if (_profileCubit
                              .firstNameEditController.text.isEmpty ||
                              _profileCubit
                                  .lastNameEditController.text.isEmpty) {
                            return UIUtils.showMessage(
                                'Enter the name the field is Empty');
                          }
                          if (typeAccount == 'Client') {
                            _profileCubit.updateClientProfile(
                                UpdateAccountProfile(
                                    firstName: _profileCubit
                                        .firstNameEditController.text,
                                    lastName: _profileCubit
                                        .lastNameEditController.text));
                          } else {
                            _profileCubit
                                .updateProviderProfile(UpdateProviderRequest(
                                firstName:
                                _profileCubit.firstNameEditController.text,
                                lastName: _profileCubit.lastNameEditController.text
                            ));
                          }
                        },
                        child: Text('Save')),
                  );
                } else {
                  return const SizedBox();
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: ProfileScreen(),
//     );
//   }
// }

// class ProfileScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     double avatarRadius = MediaQuery.of(context).size.width * 0.3;

//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Center(
//         child: Stack(
//           alignment: Alignment.center,
//           children: [
//             CircleAvatar(
//               radius: avatarRadius,
//               backgroundColor: Colors.grey,
//               child: Icon(
//                 Icons.person,
//                 size: avatarRadius,
//                 color: Colors.white,
//               ),
//             ),
//             Positioned(
//               bottom: 30,
//               right: 30,
//               child: Container(
//                 width: avatarRadius * 0.3,
//                 height: avatarRadius * 0.3,
//                 decoration: BoxDecoration(
//                   color: Colors.green,
//                   shape: BoxShape.circle,
//                 ),
//                 child: Icon(
//                   Icons.camera_alt,
//                   color: Colors.black,
//                   size: avatarRadius * 0.15,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// SizedBox(
//                 width: double.infinity,
//                 height: size.height * 0.28,
//                 child: Stack(
//                   alignment: Alignment.center,
//                   //fit: StackFit.expand,
//                   children: [
//                     Positioned(
//                       top: size.width / 300,
//                       child: Container(
//                         width: size.width / 2,
//                         height: size.height / 4,
//                         decoration: const BoxDecoration(
//                             shape: BoxShape.circle, color: Colors.grey),
//                       ),
//                     ),
//                     Positioned(
//                         top: size.height / 5.5,
//                         right: size.width / 3.5,
//                         child: Container(
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: Colors.red,
//                           ),
//                           width: size.width * 0.12,
//                           height: size.height * 0.06,
//                           padding: EdgeInsets.symmetric(
//                               horizontal: 20.w, vertical: 20.h),
//                         ))
//                   ],
//                 ),
