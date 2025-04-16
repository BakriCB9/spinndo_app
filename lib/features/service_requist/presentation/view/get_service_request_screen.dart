import 'package:app/core/constant.dart';
import 'package:app/core/di/service_locator.dart';
import 'package:app/features/drawer/presentation/cubit/drawer_cubit.dart';
import 'package:app/features/service_requist/presentation/view-model/cubit/service_request_cubit.dart';
import 'package:app/features/service_requist/presentation/view/add_service_request_screen.dart';
import 'package:app/features/service_requist/presentation/view/widget/show_service_request.dart';
import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GetServiceRequestScreen extends StatefulWidget {
  const GetServiceRequestScreen({super.key});
  static String routeName = 'serviceRquest';
  @override
  State<GetServiceRequestScreen> createState() =>
      _GetServiceRequestScreenState();
}

class _GetServiceRequestScreenState extends State<GetServiceRequestScreen> {
  late final _drawerCubit;
  late ServiceRequestCubit _serviceRequestCubit;
  @override
  void initState() {
    _serviceRequestCubit = serviceLocator.get<ServiceRequestCubit>();
    _drawerCubit = serviceLocator.get<DrawerCubit>();
    super.initState();
  }

  @override
  void deactivate() {
    print('we deactive no rohiiiii');
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    final myId = sharedPref.getInt(CacheConstant.userId);
    final theme = Theme.of(context);
    final localization = AppLocalizations.of(context)!;
    return BlocProvider(
      create: (context) => _serviceRequestCubit,
      child: DefaultTabController(
        length: 2,
        child: Container(
          decoration: _drawerCubit.themeMode == ThemeMode.dark
              ? const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("asset/images/bg.png"),
                      fit: BoxFit.fill))
              : null,
          child: Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => BlocProvider.value(
                              value: _serviceRequestCubit,
                              child: AddServiceRequestScreen(
                                userId: myId,
                              ))));
                      // .pushNamed(AddServiceRequestScreen.routeName);
                    },
                    icon: const Icon(Icons.add))
              ],
              bottom: TabBar(
                  overlayColor: WidgetStateProperty.resolveWith<Color?>(
                      (Set<WidgetState> states) {
                    return states.contains(WidgetState.focused)
                        ? null
                        : Colors.transparent;
                  }),
                  splashFactory: NoSplash.splashFactory,
                  dividerColor: Colors.transparent,
                  indicatorColor: theme.primaryColor,
                  tabs: [
                    Tab(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          localization.allServiceRequest,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontSize: 32.sp),
                        ),
                      ),
                    ),
                    Tab(
                      child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            localization.myServiceRequest,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(fontSize: 32.sp),
                          )),
                    )
                  ]),
            ),
            body: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  ShowServiceRequest(
                    serviceCubit: _serviceRequestCubit,
                  ),
                  ShowServiceRequest(
                    userId: myId,
                    serviceCubit: _serviceRequestCubit,
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
