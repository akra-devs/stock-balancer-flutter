import '../portfolio_tab.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../portfolio_tab.dart';

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

  /// 데이터베이스 객체 getter (없으면 초기화)
  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  /// 데이터베이스 초기화 및 테이블 생성
  Future<Database> _initDb() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'portfolio.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE portfolio (
            id TEXT PRIMARY KEY,
            savedAt INTEGER,
            rebalanceAmount REAL,
            totalInvestment REAL,
            currentStockValue REAL
          )
        ''');
      },
    );
  }

  @override
  Future<Map<String, PortfolioItem>> fetchPortfolioItems() async {
    final dbClient = await database;
    final List<Map<String, dynamic>> results = await dbClient.query('portfolio');
    final Map<String, PortfolioItem> items = {};
    for (var row in results) {
      final item = PortfolioItem(
        id: row['id'] as String,
        savedAt: DateTime.fromMillisecondsSinceEpoch(row['savedAt'] as int),
        rebalanceAmount: row['rebalanceAmount'] as double,
        totalInvestment: row['totalInvestment'] as double,
        currentStockValue: row['currentStockValue'] as double,
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
        'rebalanceAmount': item.rebalanceAmount,
        'totalInvestment': item.totalInvestment,
        'currentStockValue': item.currentStockValue,
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
        'rebalanceAmount': item.rebalanceAmount,
        'totalInvestment': item.totalInvestment,
        'currentStockValue': item.currentStockValue,
      },
      where: 'id = ?',
      whereArgs: [item.id],
    );
  }
}