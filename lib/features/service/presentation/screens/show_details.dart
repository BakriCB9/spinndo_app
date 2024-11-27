import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snipp/core/di/service_locator.dart';
import 'package:snipp/core/widgets/loading_indicator.dart';
import 'package:snipp/features/profile/presentation/widget/provider_profile_screen.dart';
import 'package:snipp/features/service/presentation/cubit/service_cubit.dart';
import 'package:snipp/features/service/presentation/cubit/service_states.dart';

class ShowDetails extends StatefulWidget {
  final int id;
  const ShowDetails({required this.id, super.key});

  @override
  State<ShowDetails> createState() => _ShowDetailsState();
}

class _ShowDetailsState extends State<ShowDetails> {
  @override
  final _serviceCubit = serviceLocator.get<ServiceCubit>();
  void initState() {
    _serviceCubit.showDetailsUser(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder(
          bloc: _serviceCubit,
          builder: (context, state) {
            if (state is ShowDetailsLoading) {
              return LoadingIndicator(Theme.of(context).primaryColor);
            } else if (state is ShowDetailsError) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(state.message),
                  )
                ],
              );
            } else if (state is ShowDetailsSuccess) {
              return ProviderProfileScreen(
                  providerProfile: state.providerProfile);
            } else {
              return SizedBox();
            }
          }),
    );
  }
}
