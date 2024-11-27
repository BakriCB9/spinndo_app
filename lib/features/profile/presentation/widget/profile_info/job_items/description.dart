import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snipp/core/di/service_locator.dart';
import 'package:snipp/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:snipp/features/profile/presentation/screens/edit_job_details.dart';
import 'package:snipp/features/profile/presentation/widget/profile_info/job_items/show_more_and_show_less_text.dart';
import 'package:snipp/features/profile/presentation/widget/profile_info/user_account/details_info.dart';

class CustomDescription extends StatelessWidget {
  final String category;
  final String serviceName;
  final String description;
  const CustomDescription(
      {required this.category,
      required this.serviceName,
      required this.description,
      super.key});

  @override
  Widget build(BuildContext context) {
    final _authCubit = serviceLocator.get<AuthCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Job Details', style: Theme.of(context).textTheme.labelLarge),
            // IconButton(
            //     onPressed: () {
            //       Navigator.of(context).push(MaterialPageRoute(
            //           builder: (context) =>const  EditJobDetails()));
            //     },
            //     icon: const Icon(Icons.edit))
          ],
        ),
        InfoDetails(
            icon: Icons.work_outline_outlined,
            title: 'Work',
            content: category),
        InfoDetails(
            icon: Icons.maps_home_work, title: 'Title', content: serviceName),
        InfoDetails(
            icon: Icons.location_on_outlined,
            title: 'Location',
            content: 'Aleppo'),
        SizedBox(
          height: 10.h,
        ),
        Text('Description', style: Theme.of(context).textTheme.labelLarge),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
            child: ShowMoreAndShowLess(txt: description)),
        SizedBox(
          height: 10.h,
        ),
      ],
    );
  }
}

// 'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don'
//                     't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn'
//                     't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.'
