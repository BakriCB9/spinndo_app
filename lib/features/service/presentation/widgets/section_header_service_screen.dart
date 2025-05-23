import 'package:app/core/constant.dart';
import 'package:app/core/di/service_locator.dart';
import 'package:app/core/resources/color_manager.dart';
import 'package:app/core/resources/font_manager.dart';
import 'package:app/core/routes/routes.dart';
import 'package:app/core/utils/app_shared_prefrence.dart';
import 'package:app/features/service/presentation/screens/notification_screen.dart';
import 'package:app/features/service/presentation/screens/service_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';

class SectionHeaderServiceScreen extends StatefulWidget {
  const SectionHeaderServiceScreen({super.key});

  @override
  State<SectionHeaderServiceScreen> createState() =>
      _SectionHeaderServiceScreenState();
}

class _SectionHeaderServiceScreenState
    extends State<SectionHeaderServiceScreen> {
  final _sharedPreferences = serviceLocator.get<SharedPreferencesUtils>();
  String? hasToken;
  @override
  void initState() {
    super.initState();
    hasToken = checkToken(_sharedPreferences);
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return Row(
      children: [
        IconButton(
          icon:SvgPicture.asset(
            'asset/icons/menu.svg',
            width: 24,
            height: 24,
            colorFilter: ColorFilter.mode(
              Theme.of(context).primaryColorLight,
              BlendMode.srcIn,
            ),
          ),

          onPressed: () {
            if (hasToken == null) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      backgroundColor: theme.primaryColorDark,
                      title: Text(
                          textAlign: TextAlign.center,
                          localization.note,
                          style: theme.textTheme.titleMedium!
                              .copyWith(fontSize: 36.sp, color: Colors.black)),
                      content: Text(
                        'confirm login',
                        // localization.youdonthaveaccountyouhavetosignin,
                        style: theme.textTheme.displayMedium,
                        textAlign: TextAlign.center,
                      ),
                      actions: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                                style: ButtonStyle(
                                    padding: WidgetStatePropertyAll(
                                        EdgeInsets.symmetric(
                                            horizontal: 30.w, vertical: 10.h)),
                                    side: WidgetStatePropertyAll(BorderSide(
                                        color: theme.primaryColorLight))),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  localization.cancel,
                                  style: theme.textTheme.titleMedium!
                                      .copyWith(fontWeight: FontWeight.w400),
                                )),
                            SizedBox(width: 20.w),
                            TextButton(
                                style: ButtonStyle(
                                    padding: WidgetStatePropertyAll(
                                        EdgeInsets.symmetric(
                                            horizontal: 35.w, vertical: 10.h)),
                                    backgroundColor:
                                    const WidgetStatePropertyAll(
                                        ColorManager.primary)),
                                onPressed: () {
                                  Navigator.of(context).pop();

                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                      Routes.loginRoute, (p) => false);
                                },
                                child: Text(localization.login,
                                    style: theme.textTheme.titleMedium!
                                        .copyWith(
                                        fontWeight: FontWeight.w400))),
                          ],
                        )
                      ],
                    );
                  });
            } else {
              Scaffold.of(context).openDrawer();
            }
          },
        ),
        Expanded(
          child: FittedBox(
            alignment: Directionality.of(context) == TextDirection.rtl
                ? Alignment.centerRight
                : Alignment.centerLeft,
            fit: BoxFit.scaleDown,
            child: Text(localization.homePage,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: FontSize.s22,fontWeight: FontWeight.w600)),
          ),
        ),
        hasToken != null
            ? IconButton(
          onPressed: () {
            Navigator.of(context).pushNamed(NotificationScreen.routeName);
          },
          icon: SvgPicture.asset(
            'asset/icons/bell.svg',
            width: 24,
            height: 24,
            colorFilter: ColorFilter.mode(
              Theme.of(context).primaryColorLight,
              BlendMode.srcIn,
            ),
          ),
        )
            : const SizedBox(),
      ],
    );
  }

  checkToken(SharedPreferencesUtils sharedPref) {
    final token = sharedPref.getData(key: CacheConstant.tokenKey);
    return token as String?;
  }
}
