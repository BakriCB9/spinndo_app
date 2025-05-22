part of 'google_map_cubit.dart';

class GoogleMapState extends Equatable {
  BaseState? currentLocationState;
  BaseState? getNameOfCountry;
  BaseState? getLatlangcountry;
  bool? isSelected = false;
  GoogleMapState(
      {this.currentLocationState,
      this.getNameOfCountry,
      this.isSelected,
      this.getLatlangcountry});
  GoogleMapState copyWith(
      {BaseState? currentLocationState,
      BaseState? getNameOfCountry,
      BaseState? getLatlangcountry,
      bool? isSelected}) {
    return GoogleMapState(
        getLatlangcountry: getLatlangcountry ?? this.getLatlangcountry,
        isSelected: isSelected ?? this.isSelected,
        currentLocationState: currentLocationState ?? this.currentLocationState,
        getNameOfCountry: getNameOfCountry ?? this.getNameOfCountry);
  }

  @override
  List<Object?> get props => [
        currentLocationState,
        getNameOfCountry,
        getLatlangcountry,
        isSelected,
      ];
}
