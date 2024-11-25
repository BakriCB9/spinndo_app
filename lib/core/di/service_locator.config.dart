// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;
import 'package:snipp/core/di/register_module.dart' as _i666;
import 'package:snipp/features/auth/data/data_sources/local/auth_local_data_source.dart'
    as _i1002;
import 'package:snipp/features/auth/data/data_sources/local/auth_shared_pref_local_data_source.dart'
    as _i920;
import 'package:snipp/features/auth/data/data_sources/remote/auth_api_remote_data_source.dart'
    as _i448;
import 'package:snipp/features/auth/data/data_sources/remote/auth_remote_data_source.dart'
    as _i668;
import 'package:snipp/features/auth/data/repository/auth_repository_impl.dart'
    as _i533;
import 'package:snipp/features/auth/domain/repository/auth_repository.dart'
    as _i199;
import 'package:snipp/features/auth/domain/use_cases/getCountryName.dart'
    as _i338;
import 'package:snipp/features/auth/domain/use_cases/login.dart' as _i514;
import 'package:snipp/features/auth/domain/use_cases/register.dart' as _i903;
import 'package:snipp/features/auth/domain/use_cases/register_service.dart'
    as _i19;
import 'package:snipp/features/auth/domain/use_cases/resend_code.dart' as _i153;
import 'package:snipp/features/auth/domain/use_cases/reset_password.dart'
    as _i963;
import 'package:snipp/features/auth/domain/use_cases/verify_code.dart' as _i378;
import 'package:snipp/features/auth/presentation/cubit/auth_cubit.dart'
    as _i673;
import 'package:snipp/features/drawer/presentation/cubit/drawer_cubit.dart'
    as _i884;
import 'package:snipp/features/profile/data/data_source/local/profile_local_data_source.dart'
    as _i587;
import 'package:snipp/features/profile/data/data_source/local/profile_shared_pref_local_data_source.dart'
    as _i514;
import 'package:snipp/features/profile/data/data_source/remote/profile_api_remote_data_source.dart'
    as _i595;
import 'package:snipp/features/profile/data/data_source/remote/profile_remote_data_source.dart'
    as _i378;
import 'package:snipp/features/profile/data/repository/profile_repository_impl.dart'
    as _i629;
import 'package:snipp/features/profile/domain/repository/profile_repository.dart'
    as _i319;
import 'package:snipp/features/profile/domain/use_cases/get_client_profile.dart'
    as _i0;
import 'package:snipp/features/profile/domain/use_cases/get_provider_profile.dart'
    as _i729;
import 'package:snipp/features/profile/domain/use_cases/get_user_role.dart'
    as _i743;
import 'package:snipp/features/profile/presentation/cubit/profile_cubit.dart'
    as _i846;
import 'package:snipp/features/service/data/data_sources/service_api_data_source.dart'
    as _i16;
import 'package:snipp/features/service/data/data_sources/service_data_source.dart'
    as _i555;
import 'package:snipp/features/service/data/repository/service_repository_impl.dart'
    as _i43;
import 'package:snipp/features/service/domain/repository/service_repository.dart'
    as _i131;
import 'package:snipp/features/service/domain/use_cases/get_categories.dart'
    as _i544;
import 'package:snipp/features/service/domain/use_cases/get_countries.dart'
    as _i592;
import 'package:snipp/features/service/domain/use_cases/get_details.dart'
    as _i1031;
import 'package:snipp/features/service/domain/use_cases/get_services.dart'
    as _i447;
import 'package:snipp/features/service/presentation/cubit/service_cubit.dart'
    as _i906;

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
    gh.lazySingleton<_i555.ServiceDataSource>(() => _i16.ServiceApiDataSource(
          gh<_i361.Dio>(),
          gh<_i460.SharedPreferences>(),
        ));
    gh.lazySingleton<_i131.ServiceRepository>(
        () => _i43.ServiceRepositoryImpl(gh<_i555.ServiceDataSource>()));
    gh.lazySingleton<_i544.GetCategories>(
        () => _i544.GetCategories(gh<_i131.ServiceRepository>()));
    gh.lazySingleton<_i592.GetCountries>(
        () => _i592.GetCountries(gh<_i131.ServiceRepository>()));
    gh.lazySingleton<_i1031.GetServiceProfile>(
        () => _i1031.GetServiceProfile(gh<_i131.ServiceRepository>()));
    gh.lazySingleton<_i447.GetServices>(
        () => _i447.GetServices(gh<_i131.ServiceRepository>()));
    gh.lazySingleton<_i378.ProfileRemoteDataSource>(
        () => _i595.ProfileApiRemoteDataSource(gh<_i361.Dio>()));
    gh.singleton<_i587.ProfileLocalDataSource>(() =>
        _i514.ProfileSharedPrefLocalDataSource(
            sharedPreferences: gh<_i460.SharedPreferences>()));
    gh.lazySingleton<_i884.DrawerCubit>(() =>
        _i884.DrawerCubit(sharedPreferences: gh<_i460.SharedPreferences>()));
    gh.singleton<_i1002.AuthLocalDataSource>(() =>
        _i920.AuthSharedPrefLocalDataSource(
            sharedPreferences: gh<_i460.SharedPreferences>()));
    gh.singleton<_i906.ServiceCubit>(() => _i906.ServiceCubit(
          gh<_i447.GetServices>(),
          gh<_i592.GetCountries>(),
          gh<_i544.GetCategories>(),
          gh<_i1031.GetServiceProfile>(),
        ));
    gh.singleton<_i668.AuthRemoteDataSource>(
        () => _i448.AuthAPIRemoteDataSource(dio: gh<_i361.Dio>()));
    gh.lazySingleton<_i319.ProfileRepository>(() => _i629.ProfileRepositoryImpl(
          gh<_i378.ProfileRemoteDataSource>(),
          gh<_i587.ProfileLocalDataSource>(),
        ));
    gh.singleton<_i199.AuthRepository>(() => _i533.AuthRepositoryImpl(
          gh<_i668.AuthRemoteDataSource>(),
          gh<_i1002.AuthLocalDataSource>(),
        ));
    gh.singleton<_i514.Login>(() => _i514.Login(gh<_i199.AuthRepository>()));
    gh.singleton<_i903.Register>(
        () => _i903.Register(gh<_i199.AuthRepository>()));
    gh.singleton<_i19.RegisterService>(
        () => _i19.RegisterService(gh<_i199.AuthRepository>()));
    gh.singleton<_i153.ResendCode>(
        () => _i153.ResendCode(gh<_i199.AuthRepository>()));
    gh.singleton<_i963.ResetPassword>(
        () => _i963.ResetPassword(gh<_i199.AuthRepository>()));
    gh.singleton<_i378.VerifyCode>(
        () => _i378.VerifyCode(gh<_i199.AuthRepository>()));
    gh.singleton<_i338.Getcountryname>(
        () => _i338.Getcountryname(gh<_i199.AuthRepository>()));
    gh.lazySingleton<_i0.GetClientProfile>(
        () => _i0.GetClientProfile(gh<_i319.ProfileRepository>()));
    gh.lazySingleton<_i729.GetProviderProfile>(
        () => _i729.GetProviderProfile(gh<_i319.ProfileRepository>()));
    gh.lazySingleton<_i743.GetUserRole>(
        () => _i743.GetUserRole(gh<_i319.ProfileRepository>()));
    gh.lazySingleton<_i846.ProfileCubit>(() => _i846.ProfileCubit(
          gh<_i0.GetClientProfile>(),
          gh<_i729.GetProviderProfile>(),
          gh<_i743.GetUserRole>(),
        ));
    gh.singleton<_i673.AuthCubit>(() => _i673.AuthCubit(
          gh<_i514.Login>(),
          gh<_i903.Register>(),
          gh<_i378.VerifyCode>(),
          gh<_i19.RegisterService>(),
          gh<_i153.ResendCode>(),
          gh<_i963.ResetPassword>(),
          gh<_i544.GetCategories>(),
          gh<_i338.Getcountryname>(),
        ));
    return this;
  }
}

class _$RegisterModule extends _i666.RegisterModule {}
