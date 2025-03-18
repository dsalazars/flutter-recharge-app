import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:puntored/data/exception.dart';
import 'package:puntored/data/model/proveedores_recarga_model.dart';

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
                'Bearer $token'; // Agregar el token al header
          }
          handler.next(r);
        },
        onResponse: (r, handler) {
          handler.next(r);
        },
      ),
    );
  }

  ///  Obtiene la lista de proveedores de recarga desde la API
  Future<List<ProveedorRecargaModel>> getProveedoresRecarga() async {
    try {
      final apiResponse = await _client.get('/getSuppliers');

      if (apiResponse.statusCode == 200) {
        return ProveedorRecargaModel.fromJsonList(apiResponse.data);
      } else {
        throw ServerException();
      }
    } catch (error) {
      throw ServerException();
    }
  }

  // Future<String> login(String user, String password) async {
  //   final apiResponse = await _client.post(
  //     '/auth',
  //     data: {"user": user, "password": password},
  //     options: Options(headers: {'x-api-key': apiKey}),
  //   );

  //   if (apiResponse.statusCode == 200) {
  //     final token = apiResponse.data['token'];
  //     if (token != null) {
  //       print('Token recibido: $token');

  //       // // Guardar el token en SharedPreferences
  //       // final prefs = await SharedPreferences.getInstance();
  //       // await prefs.setString('auth_token', token);

  //       return token;
  //     } else {
  //       throw ServerException();
  //     }
  //   } else {
  //     throw ServerException();
  //   }
  // }

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
