import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'package:puntored/data/datasource/remote_datasource.dart';
import 'package:puntored/data/model/app_config_model.dart';
import 'package:puntored/data/repositories/puntored_repository_impl.dart';
import 'package:puntored/domain/entities/app_config_entity.dart';
import 'package:puntored/domain/repositories/puntored_repository.dart';
import 'package:puntored/domain/repositories/local_repository.dart';
import 'package:puntored/domain/use_cases/get_puntored_api.dart';
import 'package:puntored/ui/pages/authentication/login/providers/login_provider.dart';
import 'package:yaml/yaml.dart';
import '../data/datasource/local_datasource.dart';
import '../data/repositories/database_repository_impl.dart';
import '../domain/use_cases/get_local_use_cases.dart';
import '../ui/pages/recharge/recharge/providers/proveedores_provider/proveedor_provider.dart';
import '../ui/pages/recharge/recharge/providers/purchase_provider/purchase_provider.dart';


final locator = GetIt.instance;

Future<void> init() async {
  final configFile = await rootBundle.loadString('lib/config/app_config.yaml');
  final YamlMap yamlMap = loadYaml(configFile);
  late AppConfig appConfig = AppConfigModel.fromMap(yamlMap);
 
  // providers
  locator.registerLazySingleton(() => LoginNotifier(locator()));
  locator.registerLazySingleton(() => ProveedoresNotifier(locator()));
  locator.registerLazySingleton(() => PurchaseNotifier(locator(),locator()));

  locator.registerLazySingleton(() => GetPuntoredApi(locator()));
  locator.registerLazySingleton(() => GetLocalUseCases(locator()));

  locator.registerLazySingleton<PuntoredRepository>(
    () => PuntoredRepositoryImpl(
      remoteDataSource: locator(),
    ),
  );
locator.registerLazySingleton<LocalRepository>(
  () => LocalRepositoryImpl(localDataSource: locator()),
);

  locator.registerLazySingleton<RemoteDataSource>(() => RemoteDataSource(
        baseUrl: appConfig.baseUrl,
        connectTimeout: appConfig.connectTimeOut,
        receiveTimeOut: appConfig.receiveTimeOut,
        ts: appConfig.ts,
        apiKey: appConfig.apiKey,
      ));
  

  locator.registerLazySingleton<LocalDataSource>(() => LocalDataSource());

  locator.registerLazySingleton(() => http.Client());
}