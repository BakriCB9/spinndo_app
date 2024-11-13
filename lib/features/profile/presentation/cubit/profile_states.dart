import 'package:snipp/features/profile/domain/entities/client.dart';

abstract class ProfileStates {

}
class ProfileInitial extends ProfileStates{}
class GetClientLoading extends ProfileStates{}
class GetClientSucces extends ProfileStates{
  final Client client;

  GetClientSucces(this.client);
}
class GetClientError extends ProfileStates{
  final String message;

  GetClientError(this.message);
}

