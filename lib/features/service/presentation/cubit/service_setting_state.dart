part of 'service_setting_cubit.dart';

class ServiceSettingState extends Equatable {
  BaseState? getCurrentLocation;
  BaseState? getCountryAndCategory;
  BaseState? getAllServiceState;
  BaseState? getAllDiscountState;
  BaseState? getDetailsUserState;
  BaseState? getAllNotificationState;
  BaseState? getMainCategoryState;
  bool? resetData;
  ServiceSettingState(
      {this.getCurrentLocation,
      this.getCountryAndCategory,
      this.getAllServiceState,
      this.getAllDiscountState,
      this.getDetailsUserState,
      this.getAllNotificationState,
      this.getMainCategoryState,
      this.resetData});

  ServiceSettingState copyWith(
      {BaseState? getCurrentLocation,
      BaseState? getCountryAndCategory,
      BaseState? getAllServiceState,
      BaseState? getAllDiscountState,
      BaseState? getDetailsUserState,
      BaseState? getAllNotificationState,
      bool? resetData,
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
            getAllNotificationState ?? this.getAllNotificationState,
        resetData: resetData ?? this.resetData);
  }

  @override
  List<Object?> get props => [
        getCurrentLocation,
        getCountryAndCategory,
        getAllServiceState,
        getAllDiscountState,
        getDetailsUserState,
        getAllNotificationState,
        getMainCategoryState,
        resetData
      ];
}
