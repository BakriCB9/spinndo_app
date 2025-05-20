import 'dart:io';

import 'package:app/core/error/app_exception.dart';
import 'package:app/main.dart';
import 'package:dio/dio.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HandleException {
  static AppLocalizations get localization =>
      AppLocalizations.of(navigatorKey.currentContext!)!;
  static String exceptionType(dynamic exception) {
    if (exception is DioException) {
      return handleDioException(exception, localization);
    } else if (exception is AppException) {
      return exception.message;
    } else if (exception is SocketException) {
      return localization.noInternetConnection;
    } else if (exception is FormatException) {
      return localization.dataParsingException;
    }else if(exception is LocalAppException){
      return '';
      // return localization.un;
    }

    else {
      return localization.unexpectederror;
    }
  }
}

String handleDioException<T>(DioException e, AppLocalizations localization) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
      return _getTimeoutMessage(e.type, localization);

    case DioExceptionType.badCertificate:
      return localization.invalidcertificate;

    case DioExceptionType.badResponse:
      if (e.response == null) {
        return localization.unexpectedservererror;
      }
      return _handleBadResponse<T>(e.response!, localization);
    case DioExceptionType.cancel:
      return localization.requestcancelled;

    case DioExceptionType.connectionError:
      return localization.connectionfailed;

    case DioExceptionType.unknown:
      return localization.unexpectederror;
  }
}

String _handleBadResponse<T>(Response response, AppLocalizations localization) {
  final statusCode = response.statusCode ?? 500;
  final errorMessage = _extractErrorMessage(response.data, localization);

  switch (statusCode) {
    case 400:
      return errorMessage;

    case 401:
      return errorMessage;

    case 403:
      return errorMessage;

    case 404:
      return errorMessage;

    case 500:
      return errorMessage;

    default:
      return errorMessage;
  }
}

String _extractErrorMessage(dynamic data, AppLocalizations localization) {
  if (data is Map<String, dynamic>) {
    return data['message']?.toString() ?? localization.unexpectedservererror;
  }
  return data.toString();
}

String _getTimeoutMessage(
    DioExceptionType type, AppLocalizations localization) {
  switch (type) {
    case DioExceptionType.connectionTimeout:
      return localization.connectiontimeout;

    case DioExceptionType.sendTimeout:
      return localization.sendtimeout;

    case DioExceptionType.receiveTimeout:
      return localization.receivetimeout;

    default:
      return localization.timeoutoccurred;
  }
}