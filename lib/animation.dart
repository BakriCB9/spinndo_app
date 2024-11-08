import 'package:flutter/material.dart';

class AnimationTest extends StatefulWidget {
  const AnimationTest({super.key});

  @override
  State<AnimationTest> createState() => _AnimationTestState();
}

class _AnimationTestState extends State<AnimationTest>
    with SingleTickerProviderStateMixin {
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
            duration: const Duration(seconds: 2),
            curve: Curves.easeInOut,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    // height: ischeck ? 100 : 0,  // Changes height based on ischeck
                    color: Colors.green,
                    child: ischeck ? const Text('Bakri aweja') : null,
                  ),
                ),
                Expanded(
                  child: Container(
                    // height: ischeck ? 100 : 0,  // Changes height based on ischeck
                    color: Colors.red,
                    child: ischeck ? const Text('Bakri aweja') : null,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 20),
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
