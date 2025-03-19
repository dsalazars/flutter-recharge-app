class Routes {
  static const String home = 'home';
  static const String login = 'login';
  static const String recargas = 'recargas';
}

class DataBase {
  static const String createTableUsers =
      "CREATE TABLE hour(id INTEGER PRIMARY KEY, username TEXT)";
  static const String createTableRecharge =
      "CREATE TABLE court(id INTEGER PRIMARY KEY, username_id INTEGER,transaccion_id TEXT,status TEXT,supply TEXT,amount TEXT,number TEXT)";
}

class Assets {

}

class Const {}
