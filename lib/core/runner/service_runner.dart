import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:sisyphus/core/runner/failure.dart';

typedef FutureEither<R> = Future<Either<Failure, R>>;

///this service runner is used to shorten the repository code.
///It returns either a Failure or type [T].
///example of usage:
///``` ServiceRunner<Failure, bool> sR = ServiceRunner(networkInfo);
///
///``` return  sR.tryRemoteandCatch(
/// call: remoteDataSource.logout(user: user),
/// errorTitle: ErrorStrings.LOG_OUT_ERROR);
class ServiceRunner<Failure, T> {
  ServiceRunner();

  ///A don't repeat yourself class,
  /// this is used for catching errors from remote data source.
  /// [call] runs a function that returns the required [Future] type.
  /// [name] string is used as the title for logs.
  /// Consider Removing some of the catch blocks.
  Future<Either<Failure, T>> run({
    required Future<T> call,
    required String name,
    bool disableTimeOut = false,
    int timeOutSeconds = 25,
  }) async {
    try {
      if (kDebugMode) {
        log('$name: ${call.runtimeType}');
      }
      return Right(
        disableTimeOut
            ? await call
            : await call.timeout(
                Duration(seconds: timeOutSeconds),
                onTimeout: () {
                  throw TimeoutException('Time out exception.');
                },
              ),
      );
    } on HandshakeException catch (e) {
      return Left(
        InternetFailure('$name : No Internet access', e.message) as Failure,
      );
    } on SocketException catch (e) {
      return Left(
        InternetFailure('$name : No Internet access', e.message) as Failure,
      );
    } on FormatException catch (e) {
      return Left(InternetFailure(name, e.message) as Failure);
    } on DioException catch (e) {
      if (kDebugMode) {
        log('Service Runner: ${e.response}');
      }
      if (e.response?.data == null) {
        return Left(
          CommonFailure('DioError: $name', 'Network Error') as Failure,
        );
      }
      return Left(
        CommonFailure(
                'DioError: $name', '${(e.response?.data as Map)['message']}')
            as Failure,
      );
    } on Exception catch (e) {
      if (kDebugMode) {
        log('$name: $e');
      }
      return Left(
        CommonFailure(name, e.toString().replaceAll('Exception:', ''))
            as Failure,
      );
    }
  }
}
