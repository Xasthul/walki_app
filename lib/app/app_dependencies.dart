import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vall/app/common/network/dio_client.dart';
import 'package:vall/app/common/network/dio_client_factory.dart';
import 'package:vall/app/common/use_case/secure_storage.dart';
import 'package:vall/authentication/cubit/authentication_cubit.dart';
import 'package:vall/authentication/misc/repository/authentication_repository.dart';
import 'package:vall/authentication/misc/service/authentication_service.dart';

class AppDependencies extends StatelessWidget {
  const AppDependencies({
    super.key,
    required Widget child,
  }) : _child = child;

  final Widget _child;

  @override
  Widget build(BuildContext context) => MultiRepositoryProvider(
        providers: [
          RepositoryProvider<GenericDioClient>(
            create: (context) => DioClientFactory.createGenericDioClient(),
          ),
          RepositoryProvider<SecureStorage>(
            create: (context) => SecureStorage()..load(),
          ),
          RepositoryProvider<AuthenticationService>(
            create: (context) => AuthenticationService(
              client: context.read<GenericDioClient>(),
            ),
          ),
          RepositoryProvider<AuthenticationRepository>(
            create: (context) => AuthenticationRepository(
              authenticationService: context.read<AuthenticationService>(),
              secureStorage: context.read<SecureStorage>(),
            ),
          ),
          RepositoryProvider<AuthorizedDioClient>(
            create: (context) => DioClientFactory.createAuthorizedDioClient(
              secureStorage: context.read<SecureStorage>(),
              authenticationRepository: context.read<AuthenticationRepository>(),
            ),
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => AuthenticationCubit(
                authenticationRepository: context.read<AuthenticationRepository>(),
              )..load(),
            ),
          ],
          child: _child,
        ),
      );
}
