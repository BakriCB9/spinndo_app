import 'package:app/core/resources/values_manager.dart';
import 'package:app/core/routes/routes.dart';
import 'package:app/features/google_map/presentation/view/google_map_screen.dart';
import 'package:app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SectionUpdateLocation extends StatefulWidget {
  final ProfileCubit profileCubit;
  final String cityName;
  const SectionUpdateLocation(
      {required this.profileCubit, required this.cityName, super.key});

  @override
  State<SectionUpdateLocation> createState() => _SectionUpdateLocationState();
}

class _SectionUpdateLocationState extends State<SectionUpdateLocation> {
  String? address;
  @override
  void initState() {
    address = widget.cityName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(Routes.googleMapSccren,
            arguments: {"type": MapType.chosseLocation}).then((value) {
          if (value != null) {
            setState(() {
              if (value is List<dynamic>) {
                widget.profileCubit.lat = value[0].toString();
                widget.profileCubit.long = value[1].toString();
                widget.profileCubit.cityName = value[2];
                address = value[3];
              }
              widget.profileCubit.updateJobDetails(
                  curServiceName: widget.profileCubit.providerProfile!.details!.name!,
                  newServiceName: widget.profileCubit.serviceNameController.text,
                  curWebSite: widget.profileCubit.providerProfile?.details?.website,
                  newWebSite: widget.profileCubit.webSiteController.text,
                  curDescription: widget.profileCubit.providerProfile!.details!.description!,
                  newDescription: widget.profileCubit.descriptionController.text,
                  curLat:widget.profileCubit.providerProfile!.details!.latitude!,
                              newLat: widget.profileCubit.lat!,
                              curLong:widget. profileCubit.providerProfile!.details!.longitude!,
                              newLong: widget.profileCubit.long!,
                  );
            });
          }
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColorDark,
          borderRadius: BorderRadius.circular(25.r),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 28.h),
        child: Row(
          children: [
            const Icon(
              Icons.location_on_outlined,
            ),
            SizedBox(
              width: 24.w,
            ),
            Expanded(
              child: Text(address ?? '',
                  maxLines: 4,
                  style: Theme.of(context).textTheme.displayMedium),
            )
          ],
        ),
      ),
    );
  }
}
