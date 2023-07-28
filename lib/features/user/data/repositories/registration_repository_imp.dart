import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:gpt/core/error/failure.dart';
import 'package:gpt/features/user/domain/entities/user.dart';
import 'package:gpt/features/user/domain/repositories/registration_repository.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import 'package:logger/logger.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/network/network_info.dart';
import '../../../../firebase_options.dart';
import '../../domain/entities/user_response.dart';
import '../datasources/datasources.dart';

class RegistrationRepositoryImp implements RegistrationRepository {
  final RegistrationRemoteDatasources remote;
  final RegistrationLocalDatasources local;
  final NetworkInfo network;

  RegistrationRepositoryImp({
    required this.remote,
    required this.local,
    required this.network,
  });

  @override
  Future<Either<Failure, User>> register(User user) async {
    if (await network.isConnected) {
      try {
        final res = await remote.registration(user);
        final userRes = res.user;
        await saveUserResponseAndRegisterFCM(res);
        return Right(userRes!);
      } on ServerException catch (e) {
        return Left(ServerFailure(info: e.message));
      }
    }
    return const Left(NoConnexionFailure());
  }

  @override
  Future<Either<Failure, dynamic>> checkAuth() async {
    try {
      final token = await local.getToken();
      final user = await local.getUser();
      if (user == null || token == null) {
        return const Right(null);
      }
      return Right(token);
    } catch (e) {
      return const Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, dynamic>> deleteAuth() async {
    try {
      final userRes = await local.getUser();
      if (userRes != null) {
        await remote.unregisterUserTopic(userRes);
      }
      return Right(await local.deleteAuth());
    } catch (e) {
      return const Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> checkEmail(String email) async {
    if (await network.isConnected) {
      try {
        final res = await remote.checkEmail(email);

        return Right(res);
      } on ServerException catch (e) {
        return Left(ServerFailure(info: e.message));
      }
    }
    return const Left(NoConnexionFailure());
  }

  @override
  Future<Either<Failure, User>> updateUser(User user) async {
    if (await network.isConnected) {
      try {
        final res = await remote.updateUser(user);

        return Right(res);
      } on ServerException catch (e) {
        return Left(ServerFailure(info: e.message));
      }
    }
    return const Left(NoConnexionFailure());
  }

  @override
  Future<Either<Failure, XFile?>> getPicture(ImageSource source) async {
    final file = await local.getPicture(source);
    if (file == null) {
      return const Left(ServerFailure(info: 'Format non prise en charge'));
    }
    return Right(file);
  }

  @override
  Future<Either<Failure, User>> login(User user) async {
    if (await network.isConnected) {
      try {
        final res = await remote.login(user);
        final userRes = res.user;
        await saveUserResponseAndRegisterFCM(res);

        return Right(userRes!);
      } on ServerException catch (e) {
        return Left(ServerFailure(info: e.message));
      }
    }
    return const Left(NoConnexionFailure());
  }

  @override
  Future<Either<Failure, User>> signInWithApple() async {
    if (await network.isConnected) {
      try {
        final credential = await SignInWithApple.getAppleIDCredential(
          scopes: [
            AppleIDAuthorizationScopes.email,
            AppleIDAuthorizationScopes.fullName,
          ],
        );
        print(credential);
        final queryParams = <String, String>{
          'code': credential.authorizationCode,
          if (credential.givenName != null) 'firstName': credential.givenName!,
          if (credential.familyName != null) 'lastName': credential.familyName!,
          // 'useBundleId': 'true',
          // if (credential.state != null) 'state': credential.state!,
        };
        // final signInWithAppleEndpoint = Uri(
        //   scheme: 'https',
        //   host: 'good-clever-spectrum.glitch.me',
        //   path: '/sign_in_with_apple',
        //   queryParameters: <String, String>{
        //     'code': credential.authorizationCode,
        //     if (credential.givenName != null)
        //       'firstName': credential.givenName!,
        //     if (credential.familyName != null)
        //       'lastName': credential.familyName!,
        //     'useBundleId': !kIsWeb && (Platform.isIOS || Platform.isMacOS)
        //         ? 'true'
        //         : 'false',
        //     if (credential.state != null) 'state': credential.state!,
        //   },
        // );
        final res = await remote.appleConnect(queryParams);
        final userRes = res.user;
        await saveUserResponseAndRegisterFCM(res);

        return Right(userRes!);
      } on ServerException catch (e) {
        return Left(ServerFailure(info: e.message));
      } catch (e) {
        return const Left(ServerFailure(info: 'Connexion canceled'));
      }
    }
    return const Left(NoConnexionFailure());
  }

  @override
  Future<Either<Failure, User>> signInWithGoogle() async {
    if (await network.isConnected) {
      try {
        GoogleSignIn _googleSignIn = GoogleSignIn(
          clientId: DefaultFirebaseOptions.currentPlatform.iosClientId,
        );
        final account = await _googleSignIn.signIn();

        print(account);
        final res = await remote.socialConnect(
          User(
            email: account?.email,
            lastName: account?.displayName,
            firstName: account?.displayName,
            photo: account?.photoUrl,
          ),
        );
        final userRes = res.user;
        await saveUserResponseAndRegisterFCM(res);

        return Right(userRes!);
      } on ServerException catch (e) {
        return Left(ServerFailure(info: e.message));
      } catch (e) {
        return const Left(ServerFailure(info: 'Connexion canceled'));
      }
    }
    return const Left(NoConnexionFailure());
  }

  @override
  Future<Either<Failure, User>> signInWithFacebook() async {
    if (await network.isConnected) {
      try {
        LoginResult res;
        try {
          res = await FacebookAuth.instance.login();
        } catch (_) {
          return const Left(ServerFailure());
        }
        if (res.status == LoginStatus.success) {
          final userData = await FacebookAuth.instance.getUserData(
              fields: 'last_name,first_name,name,email,picture.width(200)');
          print(userData);
          //   final result = await remote.socialConnect(
          //   User(
          //     email: userData.e,
          //     lastName: account?.displayName,
          //     firstName: account?.displayName,
          //   ),
          // );
          // final token = res.token;
          // final userRes = res.user;
          // if (token != null && userRes != null) {
          //   local.saveToken(token);
          //   local.saveUser(userRes);
          // } else {
          //   return const Left(ServerFailure(info: 'Une erreur s\'est produite'));
          // }
          // final res = await remote.socialConnect(
          //   User(
          //     email: userData?.,
          //     lastName: account?.displayName,
          //     firstName: account?.displayName,
          //     photo: account?.photoUrl,
          //   ),
          // );
          // final userRes = res.user;
          // await saveUserResponseAndRegisterFCM(res);

          // return Right(userRes!);

          return const Right(User());
        } else {
          return const Left(ServerFailure());
        }
      } on ServerException catch (e) {
        return Left(ServerFailure(info: e.message));
      } catch (e) {
        return const Left(ServerFailure(info: 'Connexion canceled'));
      }
    }
    return const Left(NoConnexionFailure());
  }

  @override
  Future<Either<Failure, User>> getUser() async {
    if (await network.isConnected) {
      try {
        final user = await remote.getUser();
        await local.saveUser(user);

        return Right(user);
      } on ServerException catch (e) {
        return Left(ServerFailure(info: e.message));
      }
    }
    return const Left(NoConnexionFailure());
  }

  Future saveUserResponseAndRegisterFCM(UserResponse res) async {
    final token = res.token;
    final userRes = res.user;
    if (token != null && userRes != null) {
      await local.saveToken(token);
      await local.saveUser(userRes);
      try {
        remote.sendFirebaseToken(userRes);
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    } else {
      throw const Left(ServerFailure(info: 'Une erreur s\'est produite'));
    }
  }
}
