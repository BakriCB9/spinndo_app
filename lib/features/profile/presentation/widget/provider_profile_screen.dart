import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snipp/core/const_variable.dart';
import 'package:snipp/features/profile/domain/entities/provider_profile/provider_profile.dart';
import 'package:snipp/features/profile/presentation/widget/profile_info/active_day/custom_day_of_active.dart';
import 'package:snipp/features/profile/presentation/widget/profile_info/job_items/description.dart';
import 'package:snipp/features/profile/presentation/widget/profile_info/user_account/user_account.dart';
import 'package:snipp/features/profile/presentation/widget/protofile_and_diploma/custom_diploma_and_protofile.dart';
import 'package:snipp/features/profile/presentation/widget/sliver_header_widget.dart';
class ProviderProfileScreen extends StatefulWidget {
  final  ProviderProfile providerProfile;
  const ProviderProfileScreen({required this.providerProfile  ,  super.key});

  @override
  State<ProviderProfileScreen> createState() => _ProviderProfileScreenState();
}
final ScrollController _control = ScrollController();
class _ProviderProfileScreenState extends State<ProviderProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CustomScrollView(
      controller: _control,
      slivers: [
        SliverPersistentHeader(
          delegate: SliverPersistentDelegate(size),
          pinned: true,
        ),
        SliverFillRemaining(
          hasScrollBody: false,
          child: Padding(
            padding:
            EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15.h),
                UserAccount(
                  firstName: widget.providerProfile.firstName!,
                  lastName:widget.providerProfile.lastName!,
                  email: widget.providerProfile.email!,
                ),
                SizedBox(height: 15.h),
                CustomDescription(
                  category:
                  widget.providerProfile.details?.category?.name ?? "No category",
                  description:
                  widget.providerProfile.details?.description ?? "No description",
                  serviceName: widget.providerProfile.details?.name ?? "No emial yet",
                ),
                SizedBox(height: 10.h),
                CustomDayActive(
                  listOfworkday: widget.providerProfile.details!.workingDays!,
                ),
                SizedBox(height: 30.h),
                CustomDiplomaAndProtofile(
                  imageCertificate:
                  widget.providerProfile.details?.certificatePath ?? listImage[0],
                  images: widget.providerProfile.details?.images??[],
                ),
                SizedBox(height: 100.h)
              ],
            ),
          ),
        ),
      ],
    );
  }
}