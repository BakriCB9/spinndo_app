import 'package:flutter/material.dart';
import 'package:snipp/profile/view/widget/profile_info/active_day/box_of_from_to.dart';

class AnimationTest extends StatefulWidget {
  const AnimationTest({super.key});

  @override
  State<AnimationTest> createState() => _AnimationTestState();
}

class _AnimationTestState extends State<AnimationTest> with SingleTickerProviderStateMixin {
  bool ischeck = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Checkbox(
            value: ischeck,
            onChanged: (value) {
              setState(() {
                ischeck = value!;
              });
            },
          ),
          AnimatedSize(
            duration: Duration(seconds: 2),
            curve: Curves.easeInOut,
            
            child: Row(
              children: [
                Expanded(
                  child: Container(
                   // height: ischeck ? 100 : 0,  // Changes height based on ischeck
                    color: Colors.green,
                    child: ischeck ? Text('Bakri aweja') : null,
                  ),
                ),
                 Expanded(
                   child: Container(
                   // height: ischeck ? 100 : 0,  // Changes height based on ischeck
                    color: Colors.red,
                    child: ischeck ? Text('Bakri aweja') : null,
                                   ),
                 )
              ],
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: Container(
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
