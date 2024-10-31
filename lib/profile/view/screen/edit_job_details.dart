import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snipp/shared/widget/custom_text_form_field.dart';

class EditJobDetails extends StatefulWidget {
  const EditJobDetails({super.key});

  @override
  State<EditJobDetails> createState() => _EditJobDetailsState();
}

class _EditJobDetailsState extends State<EditJobDetails> {
  TextEditingController _text = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit job details',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          children: [
            SizedBox(height: 60.h),
            CustomTextFromField(
              label: 'Work',
              icon: Icons.work_outline,
              initialvalue: 'Doctor',
            ),
            SizedBox(height: 30.h),
            CustomTextFromField(
              label: 'Title job',
              icon: Icons.work_outline,
              initialvalue: 'Dentist',
            ),
            SizedBox(height: 30.h),
            CustomTextFromField(
              label: 'Location',
              icon: Icons.location_on_outlined,
              initialvalue: 'Doctor',
            ),
            SizedBox(
              height: 30.h,
            ),
            CustomTextFromField(
              maxlines: 20,
              label: 'Description',
              icon: Icons.description_outlined,
              initialvalue:
                  'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don'
                  't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn'
                  't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.',
            ),
            SizedBox(
              height: 10.h,
            ),
            
            SizedBox(height: 30.h)
          ],
        ),
      )),
    );
  }
}
