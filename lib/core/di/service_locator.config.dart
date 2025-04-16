// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:app/core/di/register_module.dart' as _i313;
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
import 'package:app/features/auth/domain/use_cases/verify_code.dart' as _i833;
import 'package:app/features/auth/presentation/cubit/auth_cubit.dart' as _i580;
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
    gh.factory<_i328.ServiceDataSource>(() => _i445.ServiceApiDataSource(
          gh<_i361.Dio>(),
          gh<_i460.SharedPreferences>(),
        ));
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
    gh.lazySingleton<_i649.DrawerCubit>(() =>
        _i649.DrawerCubit(sharedPreferences: gh<_i460.SharedPreferences>()));
    gh.singleton<_i856.AuthRemoteDataSource>(
        () => _i27.AuthAPIRemoteDataSource(dio: gh<_i361.Dio>()));
    gh.factory<_i292.DiscountRepo>(
        () => _i206.DiscountRepoImpl(gh<_i678.DiscountRemoteDataSource>()));
    gh.factory<_i258.FavRepositry>(() => _i983.FavRepositryImpl(
          gh<_i306.RemoteDatasource>(),
          gh<_i460.SharedPreferences>(),
        ));
    gh.factory<_i449.AddDiscountUseCase>(
        () => _i449.AddDiscountUseCase(gh<_i292.DiscountRepo>()));
    gh.factory<_i595.DeleteDiscountUseCase>(
        () => _i595.DeleteDiscountUseCase(gh<_i292.DiscountRepo>()));
    gh.factory<_i762.GetAllDiscountUseCase>(
        () => _i762.GetAllDiscountUseCase(gh<_i292.DiscountRepo>()));
    gh.singleton<_i456.AuthLocalDataSource>(() =>
        _i545.AuthSharedPrefLocalDataSource(
            sharedPreferences: gh<_i460.SharedPreferences>()));
    gh.lazySingleton<_i734.ProfileRepository>(() => _i649.ProfileRepositoryImpl(
          gh<_i437.ProfileRemoteDataSource>(),
          gh<_i597.ProfileLocalDataSource>(),
        ));
    gh.factory<_i967.DiscountViewModelCubit>(() => _i967.DiscountViewModelCubit(
          gh<_i449.AddDiscountUseCase>(),
          gh<_i595.DeleteDiscountUseCase>(),
          gh<_i762.GetAllDiscountUseCase>(),
        ));
    gh.factory<_i779.GetCategories>(
        () => _i779.GetCategories(gh<_i1054.ServiceRepository>()));
    gh.factory<_i538.GetCountries>(
        () => _i538.GetCountries(gh<_i1054.ServiceRepository>()));
    gh.factory<_i904.GetServiceProfile>(
        () => _i904.GetServiceProfile(gh<_i1054.ServiceRepository>()));
    gh.factory<_i302.GetNotifications>(
        () => _i302.GetNotifications(gh<_i1054.ServiceRepository>()));
    gh.factory<_i590.GetServices>(
        () => _i590.GetServices(gh<_i1054.ServiceRepository>()));
    gh.factory<_i785.GetMainCategory>(
        () => _i785.GetMainCategory(gh<_i1054.ServiceRepository>()));
    gh.factory<_i881.GetServiceRequestUseCase>(
        () => _i881.GetServiceRequestUseCase(gh<_i461.ServiceRequestRepo>()));
    gh.factory<_i457.UpdateServiceRequestUseCase>(() =>
        _i457.UpdateServiceRequestUseCase(gh<_i461.ServiceRequestRepo>()));
    gh.factory<_i35.AddServiceRequestUseCase>(
        () => _i35.AddServiceRequestUseCase(gh<_i461.ServiceRequestRepo>()));
    gh.factory<_i600.DeleteServiceRequestUseCase>(() =>
        _i600.DeleteServiceRequestUseCase(gh<_i461.ServiceRequestRepo>()));
    gh.singleton<_i651.AuthRepository>(() => _i201.AuthRepositoryImpl(
          gh<_i856.AuthRemoteDataSource>(),
          gh<_i456.AuthLocalDataSource>(),
        ));
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
    gh.factory<_i619.AddFavUseCase>(
        () => _i619.AddFavUseCase(gh<_i258.FavRepositry>()));
    gh.factory<_i614.GetAllFavUsecase>(
        () => _i614.GetAllFavUsecase(gh<_i258.FavRepositry>()));
    gh.factory<_i654.RemoveFromFavUsecase>(
        () => _i654.RemoveFromFavUsecase(gh<_i258.FavRepositry>()));
    gh.singleton<_i728.Getcountryname>(
        () => _i728.Getcountryname(gh<_i651.AuthRepository>()));
    gh.singleton<_i293.Login>(() => _i293.Login(gh<_i651.AuthRepository>()));
    gh.singleton<_i374.Register>(
        () => _i374.Register(gh<_i651.AuthRepository>()));
    gh.singleton<_i156.RegisterService>(
        () => _i156.RegisterService(gh<_i651.AuthRepository>()));
    gh.singleton<_i128.ResendCode>(
        () => _i128.ResendCode(gh<_i651.AuthRepository>()));
    gh.singleton<_i801.ResetPassword>(
        () => _i801.ResetPassword(gh<_i651.AuthRepository>()));
    gh.singleton<_i833.VerifyCode>(
        () => _i833.VerifyCode(gh<_i651.AuthRepository>()));
    gh.factory<_i840.ServiceRequestCubit>(() => _i840.ServiceRequestCubit(
          gh<_i881.GetServiceRequestUseCase>(),
          gh<_i35.AddServiceRequestUseCase>(),
          gh<_i457.UpdateServiceRequestUseCase>(),
          gh<_i600.DeleteServiceRequestUseCase>(),
        ));
    gh.singleton<_i254.ServiceCubit>(() => _i254.ServiceCubit(
          gh<_i590.GetServices>(),
          gh<_i538.GetCountries>(),
          gh<_i779.GetCategories>(),
          gh<_i904.GetServiceProfile>(),
          gh<_i302.GetNotifications>(),
          gh<_i762.GetAllDiscountUseCase>(),
          gh<_i785.GetMainCategory>(),
        ));
    gh.lazySingleton<_i87.ProfileCubit>(() => _i87.ProfileCubit(
          gh<_i916.GetClientProfile>(),
          gh<_i140.GetProviderProfile>(),
          gh<_i849.GetUserRole>(),
          gh<_i837.UpdateClientProfile>(),
          gh<_i284.UpdateProviderProfile>(),
          gh<_i779.GetCategories>(),
          gh<_i728.Getcountryname>(),
          gh<_i814.AddImagePhoto>(),
          gh<_i628.DeleteImage>(),
          gh<_i83.AddOrUpdateSocialUseCase>(),
          gh<_i54.DeleteSocialLinksUseCase>(),
        ));
    gh.singleton<_i580.AuthCubit>(() => _i580.AuthCubit(
          gh<_i293.Login>(),
          gh<_i374.Register>(),
          gh<_i833.VerifyCode>(),
          gh<_i156.RegisterService>(),
          gh<_i128.ResendCode>(),
          gh<_i801.ResetPassword>(),
          gh<_i779.GetCategories>(),
          gh<_i728.Getcountryname>(),
        ));
    gh.factory<_i364.FavoriteCubit>(() => _i364.FavoriteCubit(
          gh<_i619.AddFavUseCase>(),
          gh<_i614.GetAllFavUsecase>(),
          gh<_i654.RemoveFromFavUsecase>(),
        ));
    return this;
  }
}

class _$RegisterModule extends _i313.RegisterModule {}
