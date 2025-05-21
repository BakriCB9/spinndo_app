// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:app/core/di/register_module.dart' as _i313;
import 'package:app/core/network/remote/api_manager.dart' as _i989;
import 'package:app/core/utils/app_shared_prefrence.dart' as _i279;
import 'package:app/features/auth/data/data_sources/local/auth_local_data_source.dart'
    as _i456;
import 'package:app/features/auth/data/data_sources/local/auth_shared_pref_local_data_source.dart'
    as _i545;
import 'package:app/features/auth/data/data_sources/remote/auth_api_remote_data_source.dart'
    as _i27;
import 'package:app/features/auth/data/data_sources/remote/auth_remote_data_source.dart'
    as _i856;
import 'package:app/features/auth/data/repository/auth_repository_impl.dart'
    as _i201;
import 'package:app/features/auth/domain/repository/auth_repository.dart'
    as _i651;
import 'package:app/features/auth/domain/use_cases/getCountryName.dart'
    as _i728;
import 'package:app/features/auth/domain/use_cases/login.dart' as _i293;
import 'package:app/features/auth/domain/use_cases/register.dart' as _i374;
import 'package:app/features/auth/domain/use_cases/register_service.dart'
    as _i156;
import 'package:app/features/auth/domain/use_cases/resend_code.dart' as _i128;
import 'package:app/features/auth/domain/use_cases/reset_password.dart'
    as _i801;
import 'package:app/features/auth/domain/use_cases/upgrade_account_use_case.dart'
    as _i1020;
import 'package:app/features/auth/domain/use_cases/verify_code.dart' as _i833;
import 'package:app/features/auth/presentation/cubit/auth_cubit.dart' as _i580;
import 'package:app/features/auth/presentation/cubit/cubit/login_cubit.dart'
    as _i720;
import 'package:app/features/auth/presentation/cubit/cubit/register_cubit.dart'
    as _i113;
import 'package:app/features/auth/presentation/cubit/cubit/verification_cubit.dart'
    as _i673;
import 'package:app/features/discount/data/dataSource/remote/remote_dataSource.dart'
    as _i678;
import 'package:app/features/discount/data/dataSource/remote/remote_dataSource_impl.dart'
    as _i145;
import 'package:app/features/discount/data/repositry/discount_repo_impl.dart'
    as _i206;
import 'package:app/features/discount/domain/repositry/discount_repo.dart'
    as _i292;
import 'package:app/features/discount/domain/useCase/add_discount.dart'
    as _i449;
import 'package:app/features/discount/domain/useCase/delete_discount.dart'
    as _i595;
import 'package:app/features/discount/domain/useCase/get_discount.dart'
    as _i762;
import 'package:app/features/discount/presentation/view_model/cubit/discount_view_model_cubit.dart'
    as _i967;
import 'package:app/features/drawer/data/data_source/remote/drawer_api_remote_data_source.dart'
    as _i543;
import 'package:app/features/drawer/data/data_source/remote/drawer_remote_data_source.dart'
    as _i535;
import 'package:app/features/drawer/data/repository/drawer_repository_impl.dart'
    as _i97;
import 'package:app/features/drawer/domain/repository/drawer_repository.dart'
    as _i193;
import 'package:app/features/drawer/domain/use_cases/change_password_use_case.dart'
    as _i35;
import 'package:app/features/drawer/presentation/cubit/drawer_cubit.dart'
    as _i649;
import 'package:app/features/favorite/data/dataSource/remote/remote_datasource.dart'
    as _i306;
import 'package:app/features/favorite/data/dataSource/remote/remote_datasource_impl.dart'
    as _i685;
import 'package:app/features/favorite/data/repositry/fav_repositry_impl.dart'
    as _i983;
import 'package:app/features/favorite/domain/repositry/fav_repositry.dart'
    as _i258;
import 'package:app/features/favorite/domain/usecase/add_to_fav_useCase.dart'
    as _i619;
import 'package:app/features/favorite/domain/usecase/get_all_fav_useCase.dart'
    as _i614;
import 'package:app/features/favorite/domain/usecase/remove_from_fav_useCase.dart'
    as _i654;
import 'package:app/features/favorite/presentation/view_model/cubit/favorite_cubit_cubit.dart'
    as _i364;
import 'package:app/features/google_map/data/data_source/remote/google_map_remote_data_source.dart'
    as _i579;
import 'package:app/features/google_map/data/data_source/remote/google_map_remote_data_source_impl.dart'
    as _i410;
import 'package:app/features/google_map/data/repository_impl/google_map_repository_impl.dart'
    as _i272;
import 'package:app/features/google_map/domain/repository/google_map_repository.dart'
    as _i515;
import 'package:app/features/google_map/domain/usecase/google_map_usecase.dart'
    as _i508;
import 'package:app/features/google_map/presentation/view_model/cubit/google_map_cubit.dart'
    as _i1040;
import 'package:app/features/packages/data/data_source/remote/packages_remote_datasource.dart'
    as _i529;
import 'package:app/features/packages/data/data_source/remote/packages_remote_datasource_impl.dart'
    as _i988;
import 'package:app/features/packages/data/repositry/package_repository_impl.dart'
    as _i216;
import 'package:app/features/packages/domain/repositry/package_repository.dart'
    as _i673;
import 'package:app/features/packages/domain/usecase/get_all_packages_usecase.dart'
    as _i392;
import 'package:app/features/packages/domain/usecase/subscription/add_subscribe.dart'
    as _i23;
import 'package:app/features/packages/domain/usecase/subscription/add_unsubscribe.dart'
    as _i898;
import 'package:app/features/packages/presentation/view_model/packages_cubit.dart'
    as _i594;
import 'package:app/features/payment/data/data_source/remote/payements_remote_datasource.dart'
    as _i124;
import 'package:app/features/payment/data/data_source/remote/payements_remote_datasource_impl.dart'
    as _i40;
import 'package:app/features/payment/data/repositry/payements_repository_impl.dart'
    as _i246;
import 'package:app/features/payment/domain/repositry/payments_repository.dart'
    as _i757;
import 'package:app/features/payment/domain/usecase/add_payment_method_usecase.dart'
    as _i456;
import 'package:app/features/payment/domain/usecase/get_all_payments_usecase.dart'
    as _i496;
import 'package:app/features/payment/domain/usecase/refund_payment_usecase.dart'
    as _i846;
import 'package:app/features/payment/presentation/view_model/payments_cubit.dart'
    as _i251;
import 'package:app/features/profile/data/data_source/local/profile_local_data_source.dart'
    as _i597;
import 'package:app/features/profile/data/data_source/local/profile_shared_pref_local_data_source.dart'
    as _i373;
import 'package:app/features/profile/data/data_source/remote/profile_api_remote_data_source.dart'
    as _i1045;
import 'package:app/features/profile/data/data_source/remote/profile_remote_data_source.dart'
    as _i437;
import 'package:app/features/profile/data/repository/profile_repository_impl.dart'
    as _i649;
import 'package:app/features/profile/domain/repository/profile_repository.dart'
    as _i734;
import 'package:app/features/profile/domain/use_cases/add_image_photo.dart'
    as _i814;
import 'package:app/features/profile/domain/use_cases/add_or_update_social.dart'
    as _i83;
import 'package:app/features/profile/domain/use_cases/delete_image.dart'
    as _i628;
import 'package:app/features/profile/domain/use_cases/delete_social_links.dart'
    as _i54;
import 'package:app/features/profile/domain/use_cases/get_client_profile.dart'
    as _i916;
import 'package:app/features/profile/domain/use_cases/get_provider_profile.dart'
    as _i140;
import 'package:app/features/profile/domain/use_cases/get_user_role.dart'
    as _i849;
import 'package:app/features/profile/domain/use_cases/update_client_profile.dart'
    as _i837;
import 'package:app/features/profile/domain/use_cases/update_provider_profile.dart'
    as _i284;
import 'package:app/features/profile/presentation/cubit/profile_cubit.dart'
    as _i87;
import 'package:app/features/service/data/data_sources/service_api_data_source.dart'
    as _i445;
import 'package:app/features/service/data/data_sources/service_data_source.dart'
    as _i328;
import 'package:app/features/service/data/repository/service_repository_impl.dart'
    as _i1038;
import 'package:app/features/service/domain/repository/service_repository.dart'
    as _i1054;
import 'package:app/features/service/domain/use_cases/get_categories.dart'
    as _i779;
import 'package:app/features/service/domain/use_cases/get_countries.dart'
    as _i538;
import 'package:app/features/service/domain/use_cases/get_details.dart'
    as _i904;
import 'package:app/features/service/domain/use_cases/get_main_category.dart'
    as _i785;
import 'package:app/features/service/domain/use_cases/get_notifications.dart'
    as _i302;
import 'package:app/features/service/domain/use_cases/get_services.dart'
    as _i590;
import 'package:app/features/service/presentation/cubit/service_cubit.dart'
    as _i254;
import 'package:app/features/service_requist/data/dataSource/remote/service_request_remote_dataSouce_impl.dart'
    as _i290;
import 'package:app/features/service_requist/data/dataSource/remote/service_requist_remote_dataSource.dart'
    as _i278;
import 'package:app/features/service_requist/data/respositry/service_request_impl.dart'
    as _i195;
import 'package:app/features/service_requist/doamin/repositry/service_request_repo.dart'
    as _i461;
import 'package:app/features/service_requist/doamin/useCase/add_service_request.dart'
    as _i35;
import 'package:app/features/service_requist/doamin/useCase/delete_service_request.dart'
    as _i600;
import 'package:app/features/service_requist/doamin/useCase/get_service_request.dart'
    as _i881;
import 'package:app/features/service_requist/doamin/useCase/update_service_request.dart'
    as _i457;
import 'package:app/features/service_requist/presentation/view-model/cubit/service_request_cubit.dart'
    as _i840;
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => registerModule.sharedPrefrences,
      preResolve: true,
    );
    gh.singleton<_i989.ApiManager>(() => _i989.ApiManager());
    gh.lazySingleton<_i361.Dio>(() => registerModule.dio);
    gh.factory<_i437.ProfileRemoteDataSource>(
        () => _i1045.ProfileApiRemoteDataSource(
              gh<_i361.Dio>(),
              gh<_i460.SharedPreferences>(),
            ));
    gh.factory<_i678.DiscountRemoteDataSource>(
        () => _i145.DiscountRemoteDatasourceImpl(
              gh<_i361.Dio>(),
              gh<_i460.SharedPreferences>(),
            ));
    gh.singleton<_i456.AuthLocalDataSource>(() =>
        _i545.AuthSharedPrefLocalDataSource(gh<_i460.SharedPreferences>()));
    gh.factory<_i328.ServiceDataSource>(() => _i445.ServiceApiDataSource(
          gh<_i361.Dio>(),
          gh<_i460.SharedPreferences>(),
        ));
    gh.factory<_i535.DrawerRemoteDataSource>(
        () => _i543.DrawerRemoteDataSourceImpl(gh<_i361.Dio>()));
    gh.factory<_i1054.ServiceRepository>(
        () => _i1038.ServiceRepositoryImpl(gh<_i328.ServiceDataSource>()));
    gh.factory<_i278.ServiceRequistRemoteDatasource>(
        () => _i290.ServiceRequestRemoteDatasouceImpl(
              gh<_i361.Dio>(),
              gh<_i460.SharedPreferences>(),
            ));
    gh.factory<_i306.RemoteDatasource>(
        () => _i685.RemoteDatasourceImpl(dio: gh<_i361.Dio>()));
    gh.singleton<_i597.ProfileLocalDataSource>(() =>
        _i373.ProfileSharedPrefLocalDataSource(
            sharedPreferences: gh<_i460.SharedPreferences>()));
    gh.factory<_i461.ServiceRequestRepo>(() =>
        _i195.ServiceRequestImpl(gh<_i278.ServiceRequistRemoteDatasource>()));
    gh.factory<_i579.GoogleMapRemoteDataSource>(
        () => _i410.GoogleMapRemoteDataSourceImpl(dio: gh<_i361.Dio>()));
    gh.singleton<_i279.SharedPreferencesUtils>(
        () => _i279.SharedPreferencesUtils(gh<_i460.SharedPreferences>()));
    gh.factory<_i515.GoogleMapRepository>(() =>
        _i272.GoogleMapRepositoryImpl(gh<_i579.GoogleMapRemoteDataSource>()));
    gh.factory<_i529.PackagesRemoteDataSource>(
        () => _i988.PackagesRemoteDatasourceImpl(dio: gh<_i361.Dio>()));
    gh.factory<_i124.PaymentsRemoteDatasource>(
        () => _i40.PaymentsRemoteDatasourceImpl(dio: gh<_i361.Dio>()));
    gh.factory<_i292.DiscountRepo>(
        () => _i206.DiscountRepoImpl(gh<_i678.DiscountRemoteDataSource>()));
    gh.factory<_i193.DrawerRepository>(
        () => _i97.DrawerRepositoryImpl(gh<_i535.DrawerRemoteDataSource>()));
    gh.factory<_i258.FavRepositry>(() => _i983.FavRepositryImpl(
          gh<_i306.RemoteDatasource>(),
          gh<_i460.SharedPreferences>(),
        ));
    gh.singleton<_i856.AuthRemoteDataSource>(() => _i27.AuthAPIRemoteDataSource(
          gh<_i361.Dio>(),
          gh<_i279.SharedPreferencesUtils>(),
        ));
    gh.factory<_i449.AddDiscountUseCase>(
        () => _i449.AddDiscountUseCase(gh<_i292.DiscountRepo>()));
    gh.factory<_i595.DeleteDiscountUseCase>(
        () => _i595.DeleteDiscountUseCase(gh<_i292.DiscountRepo>()));
    gh.factory<_i762.GetAllDiscountUseCase>(
        () => _i762.GetAllDiscountUseCase(gh<_i292.DiscountRepo>()));
    gh.factory<_i35.ChangePasswordUseCase>(
        () => _i35.ChangePasswordUseCase(gh<_i193.DrawerRepository>()));
    gh.lazySingleton<_i734.ProfileRepository>(() => _i649.ProfileRepositoryImpl(
          gh<_i437.ProfileRemoteDataSource>(),
          gh<_i597.ProfileLocalDataSource>(),
        ));
    gh.factory<_i757.PaymentsRepository>(() => _i246.PaymentsMethodImpl(
          gh<_i124.PaymentsRemoteDatasource>(),
          gh<_i460.SharedPreferences>(),
          gh<_i124.PaymentsRemoteDatasource>(),
          gh<_i124.PaymentsRemoteDatasource>(),
        ));
    gh.factory<_i967.DiscountViewModelCubit>(() => _i967.DiscountViewModelCubit(
          gh<_i449.AddDiscountUseCase>(),
          gh<_i595.DeleteDiscountUseCase>(),
          gh<_i762.GetAllDiscountUseCase>(),
        ));
    gh.factory<_i673.PackageRepository>(() => _i216.PackageRepositoryImpl(
          gh<_i529.PackagesRemoteDataSource>(),
          gh<_i460.SharedPreferences>(),
          gh<_i597.ProfileLocalDataSource>(),
        ));
    gh.factory<_i508.GoogleMapUsecase>(
        () => _i508.GoogleMapUsecase(gh<_i515.GoogleMapRepository>()));
    gh.factory<_i779.GetCategoriesUseCase>(
        () => _i779.GetCategoriesUseCase(gh<_i1054.ServiceRepository>()));
    gh.factory<_i538.GetCountries>(
        () => _i538.GetCountries(gh<_i1054.ServiceRepository>()));
    gh.factory<_i904.GetServiceProfile>(
        () => _i904.GetServiceProfile(gh<_i1054.ServiceRepository>()));
    gh.factory<_i785.GetMainCategory>(
        () => _i785.GetMainCategory(gh<_i1054.ServiceRepository>()));
    gh.factory<_i302.GetNotifications>(
        () => _i302.GetNotifications(gh<_i1054.ServiceRepository>()));
    gh.factory<_i590.GetServices>(
        () => _i590.GetServices(gh<_i1054.ServiceRepository>()));
    gh.factory<_i881.GetServiceRequestUseCase>(
        () => _i881.GetServiceRequestUseCase(gh<_i461.ServiceRequestRepo>()));
    gh.factory<_i457.UpdateServiceRequestUseCase>(() =>
        _i457.UpdateServiceRequestUseCase(gh<_i461.ServiceRequestRepo>()));
    gh.lazySingleton<_i496.GetAllPaymentsUseCase>(
        () => _i496.GetAllPaymentsUseCase(gh<_i757.PaymentsRepository>()));
    gh.factory<_i35.AddServiceRequestUseCase>(
        () => _i35.AddServiceRequestUseCase(gh<_i461.ServiceRequestRepo>()));
    gh.factory<_i600.DeleteServiceRequestUseCase>(() =>
        _i600.DeleteServiceRequestUseCase(gh<_i461.ServiceRequestRepo>()));
    gh.factory<_i1040.GoogleMapCubit>(
        () => _i1040.GoogleMapCubit(gh<_i508.GoogleMapUsecase>()));
    gh.factory<_i456.AddPaymentMethodUseCase>(
        () => _i456.AddPaymentMethodUseCase(gh<_i757.PaymentsRepository>()));
    gh.factory<_i23.AddSubscribeUseCase>(
        () => _i23.AddSubscribeUseCase(gh<_i673.PackageRepository>()));
    gh.factory<_i83.AddOrUpdateSocialUseCase>(
        () => _i83.AddOrUpdateSocialUseCase(gh<_i734.ProfileRepository>()));
    gh.factory<_i54.DeleteSocialLinksUseCase>(
        () => _i54.DeleteSocialLinksUseCase(gh<_i734.ProfileRepository>()));
    gh.lazySingleton<_i814.AddImagePhoto>(
        () => _i814.AddImagePhoto(gh<_i734.ProfileRepository>()));
    gh.lazySingleton<_i628.DeleteImage>(
        () => _i628.DeleteImage(gh<_i734.ProfileRepository>()));
    gh.lazySingleton<_i916.GetClientProfile>(
        () => _i916.GetClientProfile(gh<_i734.ProfileRepository>()));
    gh.lazySingleton<_i140.GetProviderProfile>(
        () => _i140.GetProviderProfile(gh<_i734.ProfileRepository>()));
    gh.lazySingleton<_i849.GetUserRole>(
        () => _i849.GetUserRole(gh<_i734.ProfileRepository>()));
    gh.lazySingleton<_i837.UpdateClientProfile>(
        () => _i837.UpdateClientProfile(gh<_i734.ProfileRepository>()));
    gh.lazySingleton<_i284.UpdateProviderProfile>(
        () => _i284.UpdateProviderProfile(gh<_i734.ProfileRepository>()));
    gh.factory<_i846.RefundPaymentMethodUseCase>(
        () => _i846.RefundPaymentMethodUseCase(gh<_i757.PaymentsRepository>()));
    gh.factory<_i619.AddFavUseCase>(
        () => _i619.AddFavUseCase(gh<_i258.FavRepositry>()));
    gh.factory<_i614.GetAllFavUsecase>(
        () => _i614.GetAllFavUsecase(gh<_i258.FavRepositry>()));
    gh.factory<_i654.RemoveFromFavUsecase>(
        () => _i654.RemoveFromFavUsecase(gh<_i258.FavRepositry>()));
    gh.factory<_i651.AuthRepository>(() => _i201.AuthRepositoryImpl(
          gh<_i856.AuthRemoteDataSource>(),
          gh<_i279.SharedPreferencesUtils>(),
          gh<_i456.AuthLocalDataSource>(),
        ));
    gh.factory<_i251.PaymentsCubit>(() => _i251.PaymentsCubit(
          gh<_i496.GetAllPaymentsUseCase>(),
          gh<_i456.AddPaymentMethodUseCase>(),
          gh<_i846.RefundPaymentMethodUseCase>(),
        ));
    gh.singleton<_i254.ServiceCubit>(() => _i254.ServiceCubit(
          gh<_i590.GetServices>(),
          gh<_i538.GetCountries>(),
          gh<_i779.GetCategoriesUseCase>(),
          gh<_i904.GetServiceProfile>(),
          gh<_i302.GetNotifications>(),
          gh<_i762.GetAllDiscountUseCase>(),
          gh<_i785.GetMainCategory>(),
        ));
    gh.factory<_i898.AddUnsubscribeUseCase>(
        () => _i898.AddUnsubscribeUseCase(gh<_i673.PackageRepository>()));
    gh.factory<_i728.Getcountryname>(
        () => _i728.Getcountryname(gh<_i651.AuthRepository>()));
    gh.factory<_i293.LoginUseCase>(
        () => _i293.LoginUseCase(gh<_i651.AuthRepository>()));
    gh.factory<_i374.RegisterUseCase>(
        () => _i374.RegisterUseCase(gh<_i651.AuthRepository>()));
    gh.factory<_i156.RegisterServiceUseCase>(
        () => _i156.RegisterServiceUseCase(gh<_i651.AuthRepository>()));
    gh.factory<_i801.ResetPasswordUseCase>(
        () => _i801.ResetPasswordUseCase(gh<_i651.AuthRepository>()));
    gh.factory<_i1020.UpgradeAccountUseCase>(
        () => _i1020.UpgradeAccountUseCase(gh<_i651.AuthRepository>()));
    gh.factory<_i833.VerifyCodeUseCase>(
        () => _i833.VerifyCodeUseCase(gh<_i651.AuthRepository>()));
    gh.singleton<_i128.ResendCodeUseCase>(
        () => _i128.ResendCodeUseCase(gh<_i651.AuthRepository>()));
    gh.lazySingleton<_i649.DrawerCubit>(() => _i649.DrawerCubit(
          sharedPreferences: gh<_i460.SharedPreferences>(),
          changePasswordUseCase: gh<_i35.ChangePasswordUseCase>(),
        ));
    gh.factory<_i673.VerificationCubit>(() => _i673.VerificationCubit(
          gh<_i833.VerifyCodeUseCase>(),
          gh<_i128.ResendCodeUseCase>(),
        ));
    gh.factory<_i840.ServiceRequestCubit>(() => _i840.ServiceRequestCubit(
          gh<_i881.GetServiceRequestUseCase>(),
          gh<_i35.AddServiceRequestUseCase>(),
          gh<_i457.UpdateServiceRequestUseCase>(),
          gh<_i600.DeleteServiceRequestUseCase>(),
        ));
    gh.lazySingleton<_i392.GetAllPackagesUseCase>(
        () => _i392.GetAllPackagesUseCase(gh<_i673.PackageRepository>()));
    gh.factory<_i594.PackagesCubit>(() => _i594.PackagesCubit(
          gh<_i392.GetAllPackagesUseCase>(),
          gh<_i23.AddSubscribeUseCase>(),
          gh<_i898.AddUnsubscribeUseCase>(),
          gh<_i597.ProfileLocalDataSource>(),
        ));
    gh.factory<_i580.AuthCubit>(() => _i580.AuthCubit(
          gh<_i374.RegisterUseCase>(),
          gh<_i833.VerifyCodeUseCase>(),
          gh<_i156.RegisterServiceUseCase>(),
          gh<_i128.ResendCodeUseCase>(),
          gh<_i779.GetCategoriesUseCase>(),
          gh<_i728.Getcountryname>(),
          gh<_i1020.UpgradeAccountUseCase>(),
        ));
    gh.factory<_i364.FavoriteCubit>(() => _i364.FavoriteCubit(
          gh<_i619.AddFavUseCase>(),
          gh<_i614.GetAllFavUsecase>(),
          gh<_i654.RemoveFromFavUsecase>(),
        ));
    gh.factory<_i113.RegisterCubit>(() => _i113.RegisterCubit(
          gh<_i156.RegisterServiceUseCase>(),
          gh<_i374.RegisterUseCase>(),
          gh<_i779.GetCategoriesUseCase>(),
        ));
    gh.lazySingleton<_i87.ProfileCubit>(() => _i87.ProfileCubit(
          gh<_i916.GetClientProfile>(),
          gh<_i140.GetProviderProfile>(),
          gh<_i849.GetUserRole>(),
          gh<_i837.UpdateClientProfile>(),
          gh<_i284.UpdateProviderProfile>(),
          gh<_i779.GetCategoriesUseCase>(),
          gh<_i728.Getcountryname>(),
          gh<_i814.AddImagePhoto>(),
          gh<_i628.DeleteImage>(),
          gh<_i83.AddOrUpdateSocialUseCase>(),
          gh<_i54.DeleteSocialLinksUseCase>(),
        ));
    gh.factory<_i720.LoginCubit>(() => _i720.LoginCubit(
          gh<_i293.LoginUseCase>(),
          gh<_i801.ResetPasswordUseCase>(),
          gh<_i128.ResendCodeUseCase>(),
        ));
    return this;
  }
}

class _$RegisterModule extends _i313.RegisterModule {}
