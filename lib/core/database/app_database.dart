import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:ryori/core/database/tables/recipes_table.dart';

part 'app_database.g.dart';

@lazySingleton
@DriftDatabase(tables: [Recipes])
final class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(driftDatabase(name: 'ryori_db'));

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();
    },
  );
}
