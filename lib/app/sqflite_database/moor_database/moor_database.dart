import 'package:moor/moor.dart';
import 'package:moor_flutter/moor_flutter.dart';
part 'moor_database.g.dart';

class Transactions extends Table {
  TextColumn get type => text()();
  TextColumn get day => text()();
  TextColumn get month => text()();
  TextColumn get memory => text()();
  IntColumn get id => integer().autoIncrement()();
  IntColumn get amount => integer()();
  IntColumn get categoryindex => integer()();
}

@UseMoor(tables: [Transactions], daos: [TransactionDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(
            path: "assets/list_it.db" , logStatements: true));



  int get schemaVersion => 1;
}


@UseDao(
  tables: [Transactions],
  queries: {
    'getTransactionForMonth': 'SELECT * FROM transactions WHERE month = :month',
    'sumTheMoneyForMonth':
        'SELECT SUM(amount) FROM transactions WHERE month = :month AND type = :type',
    'getAllTransactionsForType':
        'SELECT * FROM transactions WHERE month = :month AND type = :type'
  },
)
class TransactionDao extends DatabaseAccessor<AppDatabase>
    with _$TransactionDaoMixin {
  final AppDatabase db;

  TransactionDao(this.db) : super(db);

  Future<List<Transaction>> getAllTransactions() => select(transactions).get();

  Future insertTransaction(Transaction transaction) =>
      into(transactions).insert(transaction);

  Future updateTransaction(Transaction transaction) =>
      update(transactions).replace(transaction);

  Future deleteTransaction(Transaction transaction) =>
      delete(transactions).delete(transaction);
}
