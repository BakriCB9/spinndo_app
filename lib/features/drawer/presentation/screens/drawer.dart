import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 150.w,
                      height: 150.h,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('asset/images/no_profile.png'),
                            fit: BoxFit.cover),
                        shape: BoxShape.circle,
                        color: Colors.grey,
                      ),
                    ),
                    // Text(
                    //   'Bakri aweja',
                    //   style: TextStyle(fontSize: 30.sp, color: Colors.white),
                    // ),
                    // Text(
                    //   'bakkaraweja@gmail.com',
                    //   style: TextStyle(fontSize: 20.sp, color: Colors.white),
                    // )
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        'Bakri aweja',
                        style: TextStyle(fontSize: 30.sp, color: Colors.white),
                      ),
                      subtitle: Text(
                        'bakkaraweja@gmail.com',
                        style: TextStyle(fontSize: 25.sp, color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          const Expanded(
              flex: 3,
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.person),
                    title: Text('Profile'),
                  ),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Setting'),
                  ),
                  ListTile(
                    leading: Icon(Icons.login_outlined),
                    title: Text('Log out'),
                  )

                ],
              ))
        ],
      ),
    );
  }
}