import 'dart:io';
import 'package:app/main.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../common/api_result.dart';
import 'app_exception.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

@singleton
class ApiManager {
  Future<Result<T>> execute<T>(Future<T> Function() apiCall) async {
    final localization = AppLocalizations.of(navigatorKey.currentContext!)!;
    try {
      final response = await apiCall();
      return SuccessResult<T>(response);
    } on SocketException {
      return FailureResult<T>(
        InternetConnectionException(message: localization.noInternetConnection),
      );
    } on DioException catch (e) {
      return _handleDioException<T>(e, localization);
    } on FormatException {
      return FailureResult<T>(
        DataParsingException(
            // message: LocaleKeys.Error_DataParsingException.tr()
            message: localization.dataParsingException),
      );
    } catch (e) {
      return FailureResult<T>(
        UnknownApiException(
            // message: LocaleKeys.Error_Unexpected_error.tr()
            message: localization.unexpectederror),
      );
    }
  }

  Result<T> 
  _handleDioException<T>(
      DioException e, AppLocalizations localization) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return FailureResult<T>(
          ApiTimeoutException(message: _getTimeoutMessage(e.type, localization)),
        );
      case DioExceptionType.badCertificate:
        return FailureResult<T>(
          CertificateException(
            // message: LocaleKeys.Error_Invalid_certificate.tr()
            message: localization.invalidcertificate,
          ),
        );
      case DioExceptionType.badResponse:
        if (e.response == null) {
          return FailureResult<T>(UnknownApiException(
              // message: LocaleKeys.Error_Unexpected_server_error.tr()
              message: localization.unexpectedservererror));
        }
        return _handleBadResponse<T>(e.response!,localization);
      case DioExceptionType.cancel:
        return FailureResult<T>(
          RequestCancelledException(
              // message: LocaleKeys.Error_Request_cancelled.tr()
              message: localization.requestcancelled),
        );
      case DioExceptionType.connectionError:
        return FailureResult<T>(
          InternetConnectionException(
              // message: LocaleKeys.Error_Connection_failed.tr()
              message: localization.connectionfailed),
        );
      case DioExceptionType.unknown:
        return FailureResult<T>(
          UnknownApiException(
              // message: e.message ?? LocaleKeys.Error_Unexpected_error.tr()
              message: e.message ?? localization.unexpectederror),
        );
    }
  }

  Result<T> _handleBadResponse<T>(Response response ,AppLocalizations localization) {
    final statusCode = response.statusCode ?? 500;
    final errorMessage = _extractErrorMessage(response.data,localization);

    switch (statusCode) {
      case 400:
        return FailureResult<T>(
          BadRequestException(message: errorMessage, statusCode: statusCode),
        );
      case 401:
        return FailureResult<T>(
          UnauthorizedException(message: errorMessage, statusCode: statusCode),
        );
      case 403:
        return FailureResult<T>(
          ForbiddenException(message: errorMessage, statusCode: statusCode),
        );
      case 404:
        return FailureResult<T>(
          NotFoundException(message: errorMessage, statusCode: statusCode),
        );
      case 500:
        return FailureResult<T>(
          InternalServerErrorException(
            message: errorMessage,
            statusCode: statusCode,
          ),
        );
      default:
        return FailureResult<T>(
          UnknownApiException(
              message: 'Unexpected error: $statusCode - $errorMessage'),
        );
    }
  }

  String _extractErrorMessage(dynamic data, AppLocalizations localization) {
    if (data is Map<String, dynamic>) {
      return data['message']?.toString() ??
          // LocaleKeys.Error_Unexpected_server_error.tr();
          localization.unexpectedservererror;
    }
    return data.toString();
  }

  String _getTimeoutMessage(
      DioExceptionType type, AppLocalizations localization) {
    switch (type) {
      case DioExceptionType.connectionTimeout:
        return localization.connectiontimeout;
      // return LocaleKeys.Error_Connection_timeout.tr();

      case DioExceptionType.sendTimeout:
        return localization.sendtimeout;
      // return LocaleKeys.Error_Send_timeout.tr();

      case DioExceptionType.receiveTimeout:
        return localization.receivetimeout;
      // return LocaleKeys.Error_Receive_timeout.tr();
      default:
        return localization.timeoutoccurred;
      // return LocaleKeys.Error_Timeout_occurred.tr();
    }
  }
}
