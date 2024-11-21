import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snipp/features/profile/domain/entities/client_profile.dart';
import 'package:snipp/features/profile/presentation/widget/profile_info/user_account/user_account.dart';
import 'package:snipp/features/profile/presentation/widget/sliver_header_widget.dart';

class ClientProfileScreen extends StatefulWidget {
 final  ClientProfile clientProfile;
  const ClientProfileScreen({required this.clientProfile ,super.key});

  @override
  State<ClientProfileScreen> createState() => _ClientProfileScreenState();
}
final ScrollController _control = ScrollController();
class _ClientProfileScreenState extends State<ClientProfileScreen> {
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
                  firstName: widget.clientProfile.firstName!,
                  lastName: widget.clientProfile.lastName!,
                  email:widget.clientProfile.email!,
                ),
                // SizedBox(height: 15.h),
                // CustomDescription(
                //   category:
                //   respon.details?.category?.name ?? "No category",
                //   description:
                //   respon.details?.description ?? "No description",
                //   serviceName: respon.details?.name ?? "No emial yet",
                // ),
                // SizedBox(height: 10.h),
                // CustomDayActive(
                //   listOfworkday: state.provider.details!.workingDays!,
                // ),
                // SizedBox(height: 30.h),
                // CustomDiplomaAndProtofile(
                //   imageCertificate:
                //   respon.details?.certificatePath ?? listImage[0],
                //   images: respon.details?.images??[],
                // ),
                // SizedBox(height: 100.h)
              ],
            ),
          ),
        ),
      ],
    );
  }
}
