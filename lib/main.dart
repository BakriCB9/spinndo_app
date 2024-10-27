import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snipp/profile/view/screen/profile_screen.dart';

void main() {
  runApp(DevicePreview(
      enabled: true,
      builder: (_) {
        return const MyApp();
      }));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(412, 870),
        builder: (context, _) {
          return  MaterialApp(
            theme: ThemeData(appBarTheme: AppBarTheme(backgroundColor: Colors.blue)),
            home: TestWidget(),
            debugShowCheckedModeBanner: false,
          );
        });
  }
}

class HomeAppState extends StatefulWidget {
  const HomeAppState({super.key});

  @override
  State<HomeAppState> createState() => _HomeAppStateState();
}

class _HomeAppStateState extends State<HomeAppState> {
  double value = 200;
  bool active = false;
  double index = 1.0;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: size.height * 0.08,
            backgroundColor: Colors.red,
            expandedHeight: size.height * 0.3,
            floating: false,
            pinned: true,
            stretch: true,
            flexibleSpace: LayoutBuilder(builder: (
              context,
              constrain,
            ) {
              print('index is $index EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE');

              if (constrain.biggest.height > 140.0) {
                index-=0.1;
                return AnimatedOpacity(
                  opacity: 1,
                  duration: const Duration(seconds: 1),
                  child: FlexibleSpaceBar(
                    background: Image.asset(
                      'asset/images/messi.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              } else {
                index += 0.1;
                print(
                    'the index value is ${index} *********************************');
                return Padding(
                  padding: EdgeInsets.only(
                      top: size.height * 0.03,
                      left: size.width * 0.03,
                      bottom: size.height * 0.01),
                  child: Row(
                    children: [
                      AnimatedScale(
                        duration: const Duration(seconds: 1),
                        scale: index,
                        alignment: Alignment.topLeft,
                        child: Container(
                          width: 70,
                          height: 70,
                          decoration: const BoxDecoration(
                              color: Colors.deepPurple, shape: BoxShape.circle),
                        ),
                      )
                    ],
                  ),
                );
              }
            }),
            onStretchTrigger: () async {
              setState(() {});
            },
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: List.generate(100, (index) {
                return SizedBox(height: 20, child: Text('$index'));
              }),
            ),
          )
        ],
      ),
    );
  }
}
