import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'package:puntored/data/datasource/remote_datasource.dart';
import 'package:puntored/data/model/app_config_model.dart';
import 'package:puntored/data/repositories/puntored_repository_impl.dart';
import 'package:puntored/domain/entities/app_config_entity.dart';
import 'package:puntored/domain/repositories/puntored_repository.dart';
import 'package:puntored/domain/use_cases/get_puntored_api.dart';
import 'package:puntored/ui/pages/authentication/login/providers/login_provider.dart';
import 'package:yaml/yaml.dart';

final locator = GetIt.instance;

Future<void> init() async {
  final configFile = await rootBundle.loadString('lib/config/app_config.yaml');
  final YamlMap yamlMap = loadYaml(configFile);
  late AppConfig appConfig = AppConfigModel.fromMap(yamlMap);
 
 
  // bloc

  // locator.registerFactory(() => HomeBloc(locator()));
  // locator.registerFactory(() => SearchListBloc(locator()));
  // locator.registerFactory(() => ProductDetailBloc());

  // cubit

// login provider
locator.registerLazySingleton(() => LoginNotifier(locator()));

  // usecase
  locator.registerLazySingleton(() => GetPuntoredApi(locator()));

  // repository
  locator.registerLazySingleton<PuntoredRepository>(
    () => PuntoredRepositoryImpl(
      remoteDataSource: locator(),
    ),
  );

  locator.registerLazySingleton<RemoteDataSource>(() => RemoteDataSource(
        baseUrl: appConfig.baseUrl,
        connectTimeout: appConfig.connectTimeOut,
        receiveTimeOut: appConfig.receiveTimeOut,
        ts: appConfig.ts,
        apiKey:appConfig.apiKey,
      ));

  // external
  locator.registerLazySingleton(() => http.Client());
}
