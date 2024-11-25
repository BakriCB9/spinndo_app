// import 'package:flutter/material.dart';
// import 'package:flutter_speed_dial/flutter_speed_dial.dart';
//
// void main() => runApp(MyApp());
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: SpeedDialExample(),
//     );
//   }
// }
//
// class SpeedDialExample extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Speed Dial Example')),
//       body: Center(child: Text('Press the FAB')),
//       floatingActionButton: SpeedDial(
//         animatedIcon: AnimatedIcons.menu_close,
//         backgroundColor: Colors.blue,
//         overlayColor: Colors.black,
//         overlayOpacity: 0.5,
//         children: [
//           SpeedDialChild(
//             child: Icon(Icons.add),
//             label: 'Add',
//             onTap: () => print('Add pressed'),
//           ),
//           SpeedDialChild(
//             child: Icon(Icons.edit),
//             label: 'Edit',
//             onTap: () => print('Edit pressed'),
//           ),
//         ],
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: FloatingActionButtonExample(),
//     );
//   }
// }
//
// class FloatingActionButtonExample extends StatefulWidget {
//   @override
//   _FloatingActionButtonExampleState createState() =>
//       _FloatingActionButtonExampleState();
// }
//
// class _FloatingActionButtonExampleState
//     extends State<FloatingActionButtonExample> with SingleTickerProviderStateMixin {
//   late AnimationController _animationController;
//   late Animation<double> _animation;
//   bool isExpanded = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       vsync: this,
//       duration: Duration(milliseconds: 300),
//     );
//     _animation = CurvedAnimation(
//       parent: _animationController,
//       curve: Curves.easeInOut,
//     );
//   }
//
//   void toggleFAB() {
//     setState(() {
//       isExpanded = !isExpanded;
//       if (isExpanded) {
//         _animationController.forward();
//       } else {
//         _animationController.reverse();
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('FAB Animation Example')),
//       body: Center(child: Text('Press the FAB')),
//       floatingActionButton: Stack(
//         children: [
//           Positioned(
//             bottom: 80,
//             right: 20,
//             child: ScaleTransition(
//               scale: _animation,
//               child: FloatingActionButton(
//                 heroTag: 'btn1',
//                 onPressed: () => print("Button 1 Pressed"),
//                 child: Icon(Icons.add),
//               ),
//             ),
//           ),
//           Positioned(
//             bottom: 140,
//             right: 20,
//             child: ScaleTransition(
//               scale: _animation,
//               child: FloatingActionButton(
//                 heroTag: 'btn2',
//                 onPressed: () => print("Button 2 Pressed"),
//                 child: Icon(Icons.edit),
//               ),
//             ),
//           ),
//           Positioned(
//             bottom: 20,
//             right: 20,
//             child: FloatingActionButton(
//               heroTag: 'main',
//               onPressed: toggleFAB,
//               child: Icon(isExpanded ? Icons.close : Icons.menu),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }
// }
