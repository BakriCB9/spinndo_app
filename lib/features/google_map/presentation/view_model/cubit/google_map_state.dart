part of 'google_map_cubit.dart';

class GoogleMapState extends Equatable {
  BaseState? currentLocationState;
  BaseState? getNameOfCountry;
  bool? isSelected=false;
  GoogleMapState(
      {this.currentLocationState, this.getNameOfCountry, this.isSelected});
  GoogleMapState copyWith(
      {BaseState? currentLocationState,
      BaseState? getNameOfCountry,
      bool? isSelected}) {
    return GoogleMapState(
        isSelected: isSelected ?? this.isSelected,
        currentLocationState: currentLocationState ?? this.currentLocationState,
        getNameOfCountry: getNameOfCountry ?? this.getNameOfCountry);
  }

  @override
  List<Object?> get props => [
        currentLocationState,
        getNameOfCountry,
        isSelected,
      ];
}
