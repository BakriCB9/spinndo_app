import 'package:snipp/features/profile/data/models/provider_model/data.dart';
import 'package:snipp/features/profile/domain/entities/client.dart';

abstract class ProfileStates {

}
class ProfileInitial extends ProfileStates{}
class GetProfileLoading extends ProfileStates{}
// class GetClientSucces extends ProfileStates{
//   final Client client;

//   GetClientSucces(this.client);
// }
////////////// this is for provider now 
class GetProfileSucces extends ProfileStates{
  final Data client;

  GetProfileSucces(this.client);
}
class GetProfileError extends ProfileStates{
  final String message;

  GetProfileError(this.message);
}

