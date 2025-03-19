import 'package:puntored/domain/entities/app_config_entity.dart';
import 'package:yaml/yaml.dart';

class AppConfigModel extends AppConfig {
  AppConfigModel({
    required super.baseUrl,
    required super.apiKey,
    required super.connectTimeOut,
    required super.receiveTimeOut,
    required super.ts
  });

  factory AppConfigModel.fromMap(YamlMap json) => AppConfigModel(
      baseUrl: json["baseUrl"],
      apiKey: json["apiKey"],
      ts: json["ts"],
      connectTimeOut: json["connectTimeOut"],
      receiveTimeOut: json["receiveTimeOut"]);
}
