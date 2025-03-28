import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../portfolio_tab.dart';
import '../rebalancing_tab.dart';

PortfolioRepository getRepository() {
  if (kIsWeb) {
    return NoOpPortfolioRepository();
  } else {
    return SQLitePortfolioRepository();
  }
}

class NoOpPortfolioRepository implements PortfolioRepository {
  @override
  Future<Map<String, PortfolioItem>> fetchPortfolioItems() async {
    return {}; // 웹에서는 빈 데이터를 반환
  }

  @override
  Future<void> addPortfolioItem(PortfolioItem item) async {
    // 아무 작업도 수행하지 않음
  }

  @override
  Future<void> removePortfolioItem(String id) async {
    // 아무 작업도 수행하지 않음
  }

  @override
  Future<void> updatePortfolioItem(PortfolioItem item) async {
    // 아무 작업도 수행하지 않음
  }
}

/// Repository 추상화: Portfolio 데이터를 저장/조회/수정/삭제하는 인터페이스
abstract class PortfolioRepository {
  Future<Map<String, PortfolioItem>> fetchPortfolioItems();

  Future<void> addPortfolioItem(PortfolioItem item);

  Future<void> removePortfolioItem(String id);

  Future<void> updatePortfolioItem(PortfolioItem item);
}

/// SQLite 기반 Repository 구현
class SQLitePortfolioRepository implements PortfolioRepository {
  Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'portfolio.db');
    return await openDatabase(
      path,
      version: 2, // 버전 올림
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE portfolio (
            id TEXT PRIMARY KEY,
            savedAt INTEGER,
            totalInvestment REAL,
            beforeCashValue REAL,
            beforeStockValue REAL,
            beforeBondValue REAL,
            beforeIndexValue REAL,
            result TEXT
          )
        ''');
      },
    );
  }

  @override
  Future<Map<String, PortfolioItem>> fetchPortfolioItems() async {
    final dbClient = await database;
    final results = await dbClient.query('portfolio');
    final Map<String, PortfolioItem> items = {};

    for (final row in results) {
      final resultJson = json.decode(row['result'] as String);
      final item = PortfolioItem(
        id: row['id'] as String,
        savedAt: DateTime.fromMillisecondsSinceEpoch(row['savedAt'] as int),
        totalInvestment: row['totalInvestment'] as double,
        beforeCashValue: row['beforeCashValue'] as double,
        beforeStockValue: row['beforeStockValue'] as double,
        beforeBondValue: row['beforeBondValue'] as double?,
        beforeIndexValue: row['beforeIndexValue'] as double?,
        result: RebalanceResult.fromJson(resultJson),
      );
      items[item.id] = item;
    }
    return items;
  }

  @override
  Future<void> addPortfolioItem(PortfolioItem item) async {
    final dbClient = await database;
    await dbClient.insert(
      'portfolio',
      {
        'id': item.id,
        'savedAt': item.savedAt.millisecondsSinceEpoch,
        'totalInvestment': item.totalInvestment,
        'beforeCashValue': item.beforeCashValue,
        'beforeStockValue': item.beforeStockValue,
        'beforeBondValue': item.beforeBondValue,
        'beforeIndexValue': item.beforeIndexValue,
        'result': json.encode(item.result.toJson()),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> removePortfolioItem(String id) async {
    final dbClient = await database;
    await dbClient.delete(
      'portfolio',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<void> updatePortfolioItem(PortfolioItem item) async {
    final dbClient = await database;
    await dbClient.update(
      'portfolio',
      {
        'id': item.id,
        'savedAt': item.savedAt.millisecondsSinceEpoch,
        'totalInvestment': item.totalInvestment,
        'beforeCashValue': item.beforeCashValue,
        'beforeStockValue': item.beforeStockValue,
        'beforeBondValue': item.beforeBondValue,
        'beforeIndexValue': item.beforeIndexValue,
        'result': json.encode(item.result.toJson()),
      },
      where: 'id = ?',
      whereArgs: [item.id],
    );
  }
}
