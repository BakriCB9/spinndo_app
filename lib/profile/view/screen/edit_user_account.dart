import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snipp/shared/widget/custom_text_form_field_bakri.dart';

class EditUserAccountScreen extends StatefulWidget {
  const EditUserAccountScreen({super.key});

  @override
  State<EditUserAccountScreen> createState() => _EditUserAccountScreenState();
}

class _EditUserAccountScreenState extends State<EditUserAccountScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double avatarRadius = MediaQuery.of(context).size.width * 0.3;
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
                        radius: avatarRadius * 0.7,
                        backgroundColor: Colors.grey,
                        child: Icon(
                          Icons.person,
                          size: avatarRadius,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      right: size.width / 80,
                      child: Container(
                        width: avatarRadius * 0.4,
                        height: avatarRadius * 0.4,
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.black,
                          size: avatarRadius * 0.15,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              CustomTextFromFieldBakri(
                icon: Icons.person_2_outlined,
                label: 'First Name',
                initialvalue: 'Bakri',
              ),
              SizedBox(height: 40.h),
              CustomTextFromFieldBakri(
                icon: Icons.person_2_outlined,
                label: 'Last Name',
                initialvalue: 'aweja',
              ),
              SizedBox(height: 40.h),
              CustomTextFromFieldBakri(
                icon: Icons.email_outlined,
                label: 'Email',
                initialvalue: 'bakriaweja@gmail.com',
              ),
              SizedBox(height: 40.h),
              CustomTextFromFieldBakri(
                icon: Icons.phone,
                label: 'Phone',
                initialvalue: '0959280119',
              ),
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