import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:my_app/core/network/exception_model.dart';

import 'package:my_app/core/network/local_status_code.dart';

class DioExceptionHandler {
  static ExceptionModel dioHandler(dynamic e) {
    if (e is Exception) {
      if (e is DioException) {
        if (e.type == DioExceptionType.connectionError) {
          return ExceptionModel(
              message: "No internet connection. Please check your network.",
              icon: Icons.wifi_off,
              statusCode: LocalStatusCodes.connectionError);
        } else if (e.type == DioExceptionType.connectionTimeout) {
          return ExceptionModel(
              message:
                  "Connection timeout. Please check your internet connection.",
              icon: Icons.timer_off,
              statusCode: LocalStatusCodes.connectionTimeout);
        } else if (e.type == DioExceptionType.sendTimeout) {
          return ExceptionModel(
              message: "Send timeout. The request took too long to send.",
              icon: Icons.send_time_extension,
              statusCode: LocalStatusCodes.sendTimeout);
        } else if (e.type == DioExceptionType.badCertificate) {
          return ExceptionModel(
            message: 'Security certificate issue. Connection is not secure.',
            icon: Icons.security,
            statusCode: LocalStatusCodes.badCertificate,
          );
        } else if (e.type == DioExceptionType.receiveTimeout) {
          return ExceptionModel(
            message: 'Receive timeout. The server took too long to respond.',
            icon: Icons.hourglass_empty,
            statusCode: LocalStatusCodes.receiveTimeout,
          );
        } else if (e.type == DioExceptionType.badResponse) {
          return ExceptionModel(
            message:
                'Bad response from server: ${e.response?.statusMessage ?? 'Unknown error'}',
            icon: Icons.error_outline,
            statusCode: e.response?.statusCode ?? LocalStatusCodes.badResponse,
          );
        } else if (e.type == DioExceptionType.cancel) {
          return ExceptionModel(
            message: 'The request was cancelled.',
            icon: Icons.cancel,
            statusCode: LocalStatusCodes.cancel,
          );
        } else if (e.type == DioExceptionType.unknown) {
          return ExceptionModel(
            message: 'An unknown error occurred.',
            icon: Icons.error,
            statusCode: LocalStatusCodes.unknown,
          );
        } else {
          return ExceptionModel(
              message: "Something went wrong",
              icon: Icons.error,
              statusCode: LocalStatusCodes.defaultError);
        }
      }
    }
    return ExceptionModel(
        message: "Something went wrong",
        icon: Icons.error,
        statusCode: LocalStatusCodes.defaultError);
  }
}
