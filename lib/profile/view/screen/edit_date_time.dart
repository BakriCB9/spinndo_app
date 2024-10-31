import 'package:flutter/material.dart';
import 'package:snipp/shared/const_variable.dart';

class EditDateTimeScreen extends StatefulWidget {
  final List<String> dayAtcive;
//     List<String> days = [
//   'Saturday',
//   'Sunday',
//   'Monday',
//   'Tuesday',
//   'Wednesday',
//   'Thursday',
//   'Friday'
// ];
  const EditDateTimeScreen({required this.dayAtcive, super.key});

  @override
  State<EditDateTimeScreen> createState() => _EditDateTimeScreenState();
}

class _EditDateTimeScreenState extends State<EditDateTimeScreen> {
  var result;
  int ans=1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select your date'),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
            children: days.asMap().entries.map((day) {
           result = widget.dayAtcive.contains(day.value);
          print('the value is $result');
          final ans = day;

          return Column(
            children: [
              Row(
                children: [Checkbox(value: result, onChanged: (value) {
                  setState(() {
                    result=value??result;
                  });
                })],
              )
            ],
          );
        }).toList()),
      ),
    );
  }
}
