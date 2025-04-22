import 'package:app/features/service/data/models/get_package_reponse/data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/apiResult.dart';
import '../../../auth/data/models/category_response/datum.dart';
import '../../../service/data/models/get_package_reponse/get_package_reponse.dart';
import '../../domain/usecase/get_all_packages_usecase.dart';
import 'packages_state.dart';

@injectable
class PackagesCubit extends Cubit<PackagesState> {
  PackagesCubit(this.getAllPackagesUseCase) : super(PackagesInitial());

  final GetAllPackagesUseCase getAllPackagesUseCase;


  Future<void> getAllPackages() async {
    emit(PackagesLoading());
    ApiResult<List<PackagesData?>> result = await getAllPackagesUseCase();
    switch (result) {
      case ApiResultSuccess():
        {
          print('');
          print('the ans of value list is ${result.data}');
          print('');
          emit(PackagesSuccess(result.data));
        }
      case ApiresultError():
        {
          emit(PackagesError("error ya error"));
        }
    }
  }
}


