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
import 'package:app/features/drawer/presentation/cubit/drawer_cubit.dart'
    as _i649;
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
import 'package:app/features/service/domain/use_cases/get_services.dart'
    as _i590;
import 'package:app/features/service/presentation/cubit/service_cubit.dart'
    as _i254;
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
    gh.lazySingleton<_i328.ServiceDataSource>(() => _i445.ServiceApiDataSource(
          gh<_i361.Dio>(),
          gh<_i460.SharedPreferences>(),
        ));
    gh.lazySingleton<_i1054.ServiceRepository>(
        () => _i1038.ServiceRepositoryImpl(gh<_i328.ServiceDataSource>()));
    gh.lazySingleton<_i437.ProfileRemoteDataSource>(
        () => _i1045.ProfileApiRemoteDataSource(gh<_i361.Dio>()));
    gh.singleton<_i597.ProfileLocalDataSource>(() =>
        _i373.ProfileSharedPrefLocalDataSource(
            sharedPreferences: gh<_i460.SharedPreferences>()));
    gh.lazySingleton<_i649.DrawerCubit>(() =>
        _i649.DrawerCubit(sharedPreferences: gh<_i460.SharedPreferences>()));
    gh.singleton<_i856.AuthRemoteDataSource>(
        () => _i27.AuthAPIRemoteDataSource(dio: gh<_i361.Dio>()));
    gh.singleton<_i456.AuthLocalDataSource>(() =>
        _i545.AuthSharedPrefLocalDataSource(
            sharedPreferences: gh<_i460.SharedPreferences>()));
    gh.lazySingleton<_i734.ProfileRepository>(() => _i649.ProfileRepositoryImpl(
          gh<_i437.ProfileRemoteDataSource>(),
          gh<_i597.ProfileLocalDataSource>(),
        ));
    gh.lazySingleton<_i779.GetCategories>(
        () => _i779.GetCategories(gh<_i1054.ServiceRepository>()));
    gh.lazySingleton<_i538.GetCountries>(
        () => _i538.GetCountries(gh<_i1054.ServiceRepository>()));
    gh.lazySingleton<_i904.GetServiceProfile>(
        () => _i904.GetServiceProfile(gh<_i1054.ServiceRepository>()));
    gh.lazySingleton<_i590.GetServices>(
        () => _i590.GetServices(gh<_i1054.ServiceRepository>()));
    gh.singleton<_i651.AuthRepository>(() => _i201.AuthRepositoryImpl(
          gh<_i856.AuthRemoteDataSource>(),
          gh<_i456.AuthLocalDataSource>(),
        ));
    gh.singleton<_i254.ServiceCubit>(() => _i254.ServiceCubit(
          gh<_i590.GetServices>(),
          gh<_i538.GetCountries>(),
          gh<_i779.GetCategories>(),
          gh<_i904.GetServiceProfile>(),
        ));
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
    gh.lazySingleton<_i814.AddImagePhoto>(
        () => _i814.AddImagePhoto(gh<_i734.ProfileRepository>()));
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
    gh.lazySingleton<_i87.ProfileCubit>(() => _i87.ProfileCubit(
          gh<_i916.GetClientProfile>(),
          gh<_i140.GetProviderProfile>(),
          gh<_i849.GetUserRole>(),
          gh<_i837.UpdateClientProfile>(),
          gh<_i284.UpdateProviderProfile>(),
          gh<_i779.GetCategories>(),
          gh<_i728.Getcountryname>(),
          gh<_i814.AddImagePhoto>(),
        ));
    return this;
  }
}

class _$RegisterModule extends _i313.RegisterModule {}
