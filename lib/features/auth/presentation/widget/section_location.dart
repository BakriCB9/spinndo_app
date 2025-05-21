import 'package:app/core/resources/values_manager.dart';
import 'package:app/core/routes/routes.dart';
import 'package:app/features/auth/domain/entities/country.dart';
import 'package:app/features/auth/presentation/cubit/cubit/register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SectionLocation extends StatefulWidget {
  RegisterCubit? registerCubit;
  SectionLocation({this.registerCubit, super.key});

  @override
  State<SectionLocation> createState() => _SectionLocationState();
}

class _SectionLocationState extends State<SectionLocation> {
  Country? country;
  double? lat;
  double? lang;
  String? address;
  String? cityName;
  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return InkWell(
        splashColor: Colors.transparent,
        onTap: () {
          Navigator.of(context).pushNamed(Routes.googleMapSccren).then((value) {
            if (value != null) {
              setState(() {
                if (value is List<dynamic>) {
                  widget.registerCubit!.lat = value[0];
                  widget.registerCubit!.lang = value[1];
                  widget.registerCubit!.countryName = value[2];
                  widget.registerCubit!.address = value[3];
                }
              });
            }
          });
        },
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 28.h),
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColorDark,
                borderRadius: BorderRadius.all(Radius.circular(AppSize.s28.r))),
            child: Row(children: [
              const Icon(Icons.location_on_outlined),
              SizedBox(width: 24.w),
              Expanded(
                child: Text(
                    maxLines: 4,
                    widget.registerCubit!.address == null
                        ? localization.chooseLocation
                        : widget.registerCubit!.address!,
                    style: Theme.of(context).textTheme.displayMedium),
              )
            ])));
  }
}
