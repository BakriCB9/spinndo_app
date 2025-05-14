part of 'service_setting_cubit.dart';

class ServiceSettingState extends Equatable {
  BaseState? getCurrentLocation;
  BaseState? getCountryAndCategory;
  BaseState? getAllServiceState;
  BaseState? getAllDiscountState;
  BaseState? getDetailsUserState;
  BaseState? getAllNotificationState;
  BaseState? getMainCategoryState;
  ServiceSettingState(
      {this.getCurrentLocation,
      this.getCountryAndCategory,
      this.getAllServiceState,
      this.getAllDiscountState,
      this.getDetailsUserState,
      this.getAllNotificationState,
      this.getMainCategoryState});

  ServiceSettingState copyWith(
      {BaseState? getCurrentLocation,
      BaseState? getCountryAndCategory,
      BaseState? getAllServiceState,
      BaseState? getAllDiscountState,
      BaseState? getDetailsUserState,
      BaseState? getAllNotificationState,
      BaseState? getMainCategoryState}) {
    return ServiceSettingState(
        getMainCategoryState: getMainCategoryState ?? this.getMainCategoryState,
        getCurrentLocation: getCurrentLocation ?? this.getCurrentLocation,
        getCountryAndCategory:
            getCountryAndCategory ?? this.getCountryAndCategory,
        getAllServiceState: getAllServiceState ?? this.getAllServiceState,
        getAllDiscountState: getAllDiscountState ?? this.getAllDiscountState,
        getDetailsUserState: getDetailsUserState ?? this.getDetailsUserState,
        getAllNotificationState:
            getAllNotificationState ?? this.getAllNotificationState);
  }

  @override
  List<Object?> get props => [
        getCurrentLocation,
        getCountryAndCategory,
        getAllServiceState,
        getAllDiscountState,
        getDetailsUserState,
        getAllNotificationState,
        getMainCategoryState
      ];
}
