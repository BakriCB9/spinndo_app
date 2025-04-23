import 'package:app/core/constant.dart';
import 'package:app/core/error/apiResult.dart';
import 'package:app/features/packages/data/data_source/remote/packages_remote_datasource.dart';
import 'package:app/features/packages/data/model/package_model.dart';
import 'package:app/features/packages/domain/repositry/package_repository.dart';
import 'package:app/features/payment/data/data_source/remote/payements_remote_datasource.dart';
import 'package:app/features/payment/data/model/payments_model.dart';
import 'package:app/features/payment/domain/repositry/payments_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';


@Injectable(as: PaymentsRepository)
class PaymentsMethodImpl extends PaymentsRepository {
  late PaymentsRemoteDatasource methodsRemoteDataSource;
  late SharedPreferences sharedPreferences;
  PaymentsMethodImpl(this.methodsRemoteDataSource, this.sharedPreferences);

  @override
  Future<ApiResult<List<PaymentMethodModel>>> getAllPaymentsMethods() async {
    try {
      final userToken = sharedPreferences.getString(CacheConstant.tokenKey);
      final ans = await methodsRemoteDataSource.getAllMethods(userToken!);
      print('');
      print('the value of package in repository is $ans');
      print('');
      return ApiResultSuccess<List<PaymentMethodModel>>(ans);
    } catch (e) {
      return ApiresultError<List<PaymentMethodModel>>('Failed to get packages');
    }
  }

}