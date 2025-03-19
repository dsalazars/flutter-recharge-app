import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:puntored/data/exception.dart';
class RemoteDataSource {
  late BaseOptions _optionsApi;
  late Dio _client;
  final String apiKey;
  final storage = FlutterSecureStorage();

  RemoteDataSource({
    required String baseUrl,
    required int connectTimeout,
    required int receiveTimeOut,
    required this.apiKey,
    required int ts,
  }) {
    _optionsApi = BaseOptions(
      baseUrl: baseUrl,
      responseType: ResponseType.json,
      headers: {'Content-Type': 'application/json', 'accept': '*/*'},
    );
    _client = Dio(_optionsApi);
  }

  addInterceptor() {
    _client.interceptors.clear();
    _client.interceptors.add(
      InterceptorsWrapper(
        onError: (e, handler) {
          // ignore: unnecessary_null_comparison 
          if (e == null) {
            handler.reject(e);
          } else {
            handler.resolve(
              e.response ?? Response(requestOptions: RequestOptions(path: '')),
            );
          }
        },
        onRequest: (r, handler) async {
          r.headers['x-api-key'] = apiKey;
          final token = await getToken(); // Obtener el token dinámicamente
          //print('Token recibido--------: ${token}');

          if (token != null) {
            r.headers['Authorization'] =
                token; // Agregar el token al header
          }
          handler.next(r);
        },
        onResponse: (r, handler) {
          handler.next(r);
        },
      ),
    );
  }
  Future<String?> getToken() async {
    return await storage.read(key: 'auth_token');
  }

  Future<T> post<T, D>(
    String path,
    D data,
    T Function(dynamic)? fromJson,
  ) async {
    try {
      addInterceptor();
      final apiResponse = await _client.post(
        path,
        data: data,
        options: Options(headers: {}),
      );

      if (apiResponse.statusCode == 200) {
        if (fromJson != null) {
          return fromJson(apiResponse.data);
        }
        return (apiResponse.data);
      } else {
        throw ServerException();
      }
    } catch (error) {
      throw ServerException();
    }
  }

  Future<T> get<T>(String path, T Function(dynamic) fromJson) async {
    try {
      addInterceptor();
      final apiResponse = await _client.get(path);

      if (apiResponse.statusCode == 200) {
        return fromJson(apiResponse.data);
      } else {
        throw ServerException();
      }
    } catch (error) {
      throw ServerException();
    }
  }
}
