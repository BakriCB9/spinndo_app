import 'package:app/core/utils/error_network_widget.dart';
import 'package:app/features/discount/presentation/view_model/cubit/discount_view_model_cubit.dart';
import 'package:app/features/service/presentation/cubit/service_setting_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/core/di/service_locator.dart';
import 'package:app/core/widgets/loading_indicator.dart';
import 'package:app/features/profile/presentation/widget/provider_profile_screen.dart';
import 'package:app/features/service/presentation/cubit/service_cubit.dart';
import 'package:app/features/service/presentation/cubit/service_states.dart';

class ShowDetails extends StatefulWidget {
  final int id;
  const ShowDetails({required this.id, super.key});

  @override
  State<ShowDetails> createState() => _ShowDetailsState();
}

class _ShowDetailsState extends State<ShowDetails> {
  @override
  final _serviceCubit = serviceLocator.get<ServiceSettingCubit>();
  void initState() {
    _serviceCubit.showDetailsUser(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<ServiceSettingCubit, ServiceSettingState>(
          bloc: _serviceCubit,
          builder: (context, state) {
            if (state.getDetailsUserState is BaseLoadingState) {
              return LoadingIndicator(Theme.of(context).primaryColor);
            } else if (state.getDetailsUserState is BaseErrorState) {
              final message=state.getDetailsUserState as BaseErrorState;
              return ErrorNetworkWidget(message:message.error! , onTap: (){
                _serviceCubit.showDetailsUser(widget.id);
              });
            } else if (state.getDetailsUserState is BaseSuccessState) {
              return ProviderProfileScreen(
                  providerProfile: (state.getDetailsUserState as BaseSuccessState).data);
            } else {
              return const SizedBox();
            }
          }),
    );
  }
}
