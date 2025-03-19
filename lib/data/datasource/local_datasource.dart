import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:puntored/domain/entities/recharge_result_entity.dart';

import '../failure.dart';
class LocalDataSource {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'puntored.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE recharge_result(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            username TEXT,
            transaccion_id TEXT,
            status TEXT,
            supply TEXT,
            amount TEXT,
            number TEXT
          )
        ''');
      },
    );
  }


  Future<Either<Failure, void>> saveRechargeResult(RechargeResultEntity result) async {
    try {
      final db = await database;
      await db.insert(
        'recharge_result',
        result.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure('Error guardando en base local: $e'));
    }
  }


  Future<Either<Failure, List<RechargeResultEntity>>> getRechargeResultsByUser(String username) async {
    try {
      final db = await database;
      final maps = await db.query(
        'recharge_result',
        where: 'username = ?',
        whereArgs: [username],
      );
      final list = maps.map((map) => RechargeResultEntity.fromMap(map)).toList();
      return Right(list);
    } catch (e) {
      return Left(DatabaseFailure('Error consultando base local: $e'));
    }
  }
}
