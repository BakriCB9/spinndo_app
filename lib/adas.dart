import 'package:flutter/material.dart';

class SpeechBubble extends StatelessWidget {
  final String text;

  SpeechBubble({required this.text});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: SpeechBubblePainter(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class SpeechBubblePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, 10)
      ..quadraticBezierTo(0, 0, 10, 0)
      ..lineTo(size.width - 20, 0)
      ..quadraticBezierTo(size.width - 10, 0, size.width - 10, 10)
      ..lineTo(size.width - 10, size.height / 2 - 10)
      ..lineTo(size.width, size.height / 2)
      ..lineTo(size.width - 10, size.height / 2 + 10)
      ..lineTo(size.width - 10, size.height)
      ..quadraticBezierTo(size.width - 10, size.height, size.width - 20, size.height)
      ..lineTo(10, size.height)
      ..quadraticBezierTo(0, size.height, 0, size.height - 10)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: Center(
        // child: SpeechBubble(text: 'Brands'),
        child: SizedBox(width: 250,
          child: Stack(children: [
            Container(width: 200,child: Text("dssda"),decoration: BoxDecoration(
              color: Colors.blue,borderRadius: BorderRadius.all(Radius.circular(30))
            ),),
                 Positioned(left: 190,child: Icon(Icons.play_arrow,color: Colors.red,))
          ],),
        ),
      ),
    ),
  ));
}