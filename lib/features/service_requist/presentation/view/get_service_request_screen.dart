import 'package:app/core/constant.dart';
import 'package:app/core/di/service_locator.dart';
import 'package:app/core/resources/color_manager.dart';
import 'package:app/features/drawer/presentation/cubit/drawer_cubit.dart';
import 'package:app/features/service_requist/presentation/view-model/cubit/service_request_cubit.dart';
import 'package:app/features/service_requist/presentation/view/add_service_request_screen.dart';
import 'package:app/features/service_requist/presentation/view/widget/show_service_request.dart';
import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/resources/font_manager.dart';

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
  final drawerCubit = serviceLocator.get<DrawerCubit>();

  @override
  void initState() {
    _serviceRequestCubit = serviceLocator.get<ServiceRequestCubit>();
    _drawerCubit = serviceLocator.get<DrawerCubit>();
    super.initState();
  }

  @override
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
              color: ColorManager.darkBg
          ): null,
          child: Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => BlocProvider.value(
                      value: _serviceRequestCubit,
                      child: AddServiceRequestScreen(
                        userId: myId,
                      ),
                    ),
                  ),
                );
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              child: Icon(
                Icons.add,
                color: ColorManager.primary,
              ),
            ),
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(100),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: AppBar(
                  backgroundColor: drawerCubit.themeMode == ThemeMode.dark?ColorManager.darkTextFieldBg:ColorManager.white,
                  leading: IconButton(
                    icon: SvgPicture.asset(
                      'asset/icons/back.svg',
                      width: 20,
                      height: 20,
                      colorFilter: ColorFilter.mode(
                        ColorManager.grey,
                        BlendMode.srcIn,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  centerTitle: false,
                  title: Text(
                    localization.serviceRequests,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: FontSize.s22,fontWeight: FontWeight.w600),
                  ),
                  bottom: PreferredSize(
                    preferredSize: Size.fromHeight(50),
                    child: Container(
                      color: drawerCubit.themeMode == ThemeMode.dark?ColorManager.darkTextFieldBg:ColorManager.white,
                      child: TabBar(

                        tabs: [
                          Tab(text: localization.allServiceRequest),
                          Tab(text: localization.myServiceRequest),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
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
