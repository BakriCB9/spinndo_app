import 'package:app/features/packages/data/model/package_model.dart';
import 'package:app/features/packages/data/model/subscription/subscribe_model.dart';
import 'package:app/features/packages/data/model/subscription/subscribe_response.dart';
import 'package:app/features/packages/data/model/subscription/unsubscribe_response.dart';
import 'package:app/features/packages/domain/usecase/subscription/add_subscribe.dart';
import 'package:app/features/packages/domain/usecase/subscription/add_unsubscribe.dart';
import 'package:app/features/profile/data/data_source/local/profile_local_data_source.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/apiResult.dart';
import '../../domain/usecase/get_all_packages_usecase.dart';
import 'packages_state.dart';
import 'package:uuid/uuid.dart';


@injectable
class PackagesCubit extends Cubit<PackagesState> {
  PackagesCubit(this.getAllPackagesUseCase, this.addSubscribeUseCase,this.addUnSubscribeUseCase, this._profileLocalDataSource) : super(PackagesInitial());

  final GetAllPackagesUseCase getAllPackagesUseCase;
  final AddSubscribeUseCase addSubscribeUseCase;
  final AddUnsubscribeUseCase addUnSubscribeUseCase;
  final ProfileLocalDataSource _profileLocalDataSource;

  int getUserId() {
    return _profileLocalDataSource.getUserId();
  }

  Future<void> getAllPackages() async {
    emit(PackagesLoading());
    ApiResult<List<PackageModel?>> result = await getAllPackagesUseCase();
    switch (result) {
      case ApiResultSuccess():
        {
          print('');
          print('sssssss the ans of value list is ${result.data}');
          print('');
          emit(PackagesSuccess(result.data));
        }
      case ApiresultError(message: final message, error: final error):
        {
          print('Errorrrrzz: ${result.error}');
          emit(PackagesError(result.message, result.error));
        }
    }
  }

  Future<void> addSubscription(SubscribeModel subscription) async {
    ApiResult<SubscribeResponse?> result = await addSubscribeUseCase(subscription);

    if (result is ApiResultSuccess<SubscribeResponse>) {
      print('the result is ${result.data}');
      _updatePackageSubscriptionStatus(subscription.packageId??0, true);
    } else if (result is ApiresultError<SubscribeResponse>) {
      print('the fail result is ${result.message}');
    }
  }


  void _updatePackageSubscriptionStatus(int packageId, bool isSubscribed) {
    if (state is PackagesSuccess) {
      final currentState = state as PackagesSuccess;
      final updatedPackages = currentState.packages.map((package) {
        if (package?.id == packageId) {
          return package!.copyWith(is_subscribed: isSubscribed);
        }
        return package!;
      }).toList();

      emit(PackagesSuccess(updatedPackages));
    }
  }


  Future<void> cancelSubscription(int? userId) async {
    if (userId == null) return;

    ApiResult<UnSubscribeResponse> result = await addUnSubscribeUseCase(userId);

    switch (result) {
      case ApiResultSuccess():
        {
          print('Unsubscription successful: ${result.data}');
        }
      case ApiresultError(message: final message, error: final error):
        {
          print('Failed to cancel subscription: $message');
        }
    }
  }

  final uuid = Uuid();
  SubscribeModel createSubscribeModel(PackageModel package, int userId) {
    return SubscribeModel(
      id: 0,
      userId: userId,
      packageId: package.id ?? 0,
      startDate: '',
      endDate: '',
      status: 'active',
    );
  }

  bool isUserSubscribed(int userId) {
    if (state is PackagesSuccess) {
      final packages = (state as PackagesSuccess).packages;
      return packages.any((pkg) => pkg?.is_subscribed == true);
    }
    return false;
  }




}


