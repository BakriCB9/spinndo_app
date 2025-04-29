import 'package:app/core/error/apiResult.dart';
import 'package:app/features/service_requist/data/model/request_model/update_my_service_request.dart';
import 'package:app/features/service_requist/doamin/entity/get_service_entity.dart';
import 'package:app/features/service_requist/doamin/useCase/add_service_request.dart';
import 'package:app/features/service_requist/doamin/useCase/delete_service_request.dart';
import 'package:app/features/service_requist/doamin/useCase/get_service_request.dart';
import 'package:app/features/service_requist/doamin/useCase/update_service_request.dart';
import 'package:app/features/service_requist/presentation/view-model/cubit/service_request_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ServiceRequestCubit extends Cubit<ServiceRequestState> {
  ServiceRequestCubit(
      this._getServiceRequestUseCase,
      this._addServiceRequestUseCase,
      this._updateServiceRequestUseCase,
      this._deleteServiceRequestUseCase)
      : super(ServiceRequestState());

  final GetServiceRequestUseCase _getServiceRequestUseCase;
  final AddServiceRequestUseCase _addServiceRequestUseCase;
  final UpdateServiceRequestUseCase _updateServiceRequestUseCase;
  final DeleteServiceRequestUseCase _deleteServiceRequestUseCase;
//variable
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  List<ServiceRequestEntity> listOfAllService = [];

  
  getServiceRequest(int? userId) async {
    emit(state.copyWith(
        updateServiceState: null,
        createServiceState: null,
        deleteServiceState: null,
        getServiceState: BaseLoadingState()));
    ApiResult<List<ServiceRequestEntity>> ans =
        await _getServiceRequestUseCase(userId);
    switch (ans) {
      case ApiResultSuccess():
        {
          listOfAllService = ans.data;

          emit(state.copyWith(
            updateServiceState: null,
            createServiceState: null,
            deleteServiceState: null,
            getServiceState:
                BaseSuccessState<List<ServiceRequestEntity>>(ans.data),
          ));
        }
      case ApiresultError():
        {
          emit(state.copyWith(
              updateServiceState: null,
              createServiceState: null,
              deleteServiceState: null,
              getServiceState: BaseErrorState(ans.message)));
        }
    }
  }

  createRequest(MyServiceRequest myservice) async {
    emit(state.copyWith(
        getServiceState: null,
        updateServiceState: null,
        deleteServiceState: null,
        createServiceState: BaseLoadingState()));
    ApiResult<ServiceRequestEntity> ans =
        await _addServiceRequestUseCase(myservice);
    switch (ans) {
      case ApiResultSuccess():
        {
          print('');
          print('yes we didi it and add the item ${ans.data.desCription}');
          print('');
          emit(state.copyWith(
              deleteServiceState: null,
              updateServiceState: null,
              getServiceState: BaseSuccessState<List<ServiceRequestEntity>>(
                  listOfAllService),
              createServiceState:
                  BaseSuccessState<ServiceRequestEntity>(ans.data)));
          listOfAllService.add(ans.data);
        }
      case ApiresultError():
        {
          emit(state.copyWith(
              deleteServiceState: null,
              updateServiceState: null,
              getServiceState: null,
              createServiceState: BaseErrorState(ans.message)));
        }
    }
  }

  updateRequest(int idOfSerivce, MyServiceRequest myservice) async {
    emit(state.copyWith(
        getServiceState: null,
        createServiceState: null,
        deleteServiceState: null,
        updateServiceState: BaseLoadingState()));
    ApiResult<ServiceRequestEntity> ans =
        await _updateServiceRequestUseCase(idOfSerivce, myservice);
    switch (ans) {
      case ApiResultSuccess():
        {
          final aux = listOfAllService.indexWhere((serviceRequest) {
            return serviceRequest.id == myservice.id;
          });

          listOfAllService[aux].title = myservice.title;
          listOfAllService[aux].desCription = myservice.desCription;
          listOfAllService[aux].dayDuration = myservice.dayDuration;
          listOfAllService[aux].price = myservice.price;
          emit(state.copyWith(
              deleteServiceState: null,
              createServiceState: null,
              getServiceState: BaseSuccessState<List<ServiceRequestEntity>>(
                  listOfAllService),
              updateServiceState:
                  BaseSuccessState<ServiceRequestEntity>(ans.data)));
        }
      case ApiresultError():
        {
          emit(state.copyWith(
              deleteServiceState: null,
              getServiceState: null,
              createServiceState: null,
              updateServiceState: BaseErrorState(ans.message)));
        }
    }
  }

  deleteRequest(int idOfService) async {
    emit(state.copyWith(
        updateServiceState: null,
        createServiceState: null,
        getServiceState: null,
        deleteServiceState: BaseLoadingState()));
    final ans = await _deleteServiceRequestUseCase(idOfService);
    switch (ans) {
      case ApiResultSuccess():
        {
          final aux = listOfAllService.indexWhere((e) {
            return e.id == idOfService;
          });
          listOfAllService.removeAt(aux);
          emit(state.copyWith(
              updateServiceState: null,
              createServiceState: null,
              getServiceState: BaseSuccessState<List<ServiceRequestEntity>>(
                  listOfAllService),
              deleteServiceState: BaseSuccessState<String>(ans.data)));
        }
      case ApiresultError():
        {
          emit(state.copyWith(
              updateServiceState: null,
              getServiceState: null,
              createServiceState: null,
              deleteServiceState: BaseErrorState(ans.message)));
        }
    }
  }
}
