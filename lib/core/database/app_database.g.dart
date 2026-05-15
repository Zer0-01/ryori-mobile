// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $RecipesTable extends Recipes with TableInfo<$RecipesTable, Recipe> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RecipesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  @override
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
    'uuid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imageUrlMeta = const VerificationMeta(
    'imageUrl',
  );
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
    'image_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<List<String>, String> steps =
      GeneratedColumn<String>(
        'steps',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<List<String>>($RecipesTable.$convertersteps);
  @override
  late final GeneratedColumnWithTypeConverter<List<String>, String>
  ingredients = GeneratedColumn<String>(
    'ingredients',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<List<String>>($RecipesTable.$converteringredients);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    uuid,
    title,
    description,
    imageUrl,
    type,
    steps,
    ingredients,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recipes';
  @override
  VerificationContext validateIntegrity(
    Insertable<Recipe> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('uuid')) {
      context.handle(
        _uuidMeta,
        uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta),
      );
    } else if (isInserting) {
      context.missing(_uuidMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('image_url')) {
      context.handle(
        _imageUrlMeta,
        imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta),
      );
    } else if (isInserting) {
      context.missing(_imageUrlMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {uuid};
  @override
  Recipe map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Recipe(
      uuid:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}uuid'],
          )!,
      title:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}title'],
          )!,
      description:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}description'],
          )!,
      imageUrl:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}image_url'],
          )!,
      type:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}type'],
          )!,
      steps: $RecipesTable.$convertersteps.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}steps'],
        )!,
      ),
      ingredients: $RecipesTable.$converteringredients.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}ingredients'],
        )!,
      ),
      createdAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}created_at'],
          )!,
    );
  }

  @override
  $RecipesTable createAlias(String alias) {
    return $RecipesTable(attachedDatabase, alias);
  }

  static TypeConverter<List<String>, String> $convertersteps =
      const StringListConverter();
  static TypeConverter<List<String>, String> $converteringredients =
      const StringListConverter();
}

class Recipe extends DataClass implements Insertable<Recipe> {
  final String uuid;
  final String title;
  final String description;
  final String imageUrl;
  final String type;
  final List<String> steps;
  final List<String> ingredients;
  final DateTime createdAt;
  const Recipe({
    required this.uuid,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.type,
    required this.steps,
    required this.ingredients,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['uuid'] = Variable<String>(uuid);
    map['title'] = Variable<String>(title);
    map['description'] = Variable<String>(description);
    map['image_url'] = Variable<String>(imageUrl);
    map['type'] = Variable<String>(type);
    {
      map['steps'] = Variable<String>(
        $RecipesTable.$convertersteps.toSql(steps),
      );
    }
    {
      map['ingredients'] = Variable<String>(
        $RecipesTable.$converteringredients.toSql(ingredients),
      );
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  RecipesCompanion toCompanion(bool nullToAbsent) {
    return RecipesCompanion(
      uuid: Value(uuid),
      title: Value(title),
      description: Value(description),
      imageUrl: Value(imageUrl),
      type: Value(type),
      steps: Value(steps),
      ingredients: Value(ingredients),
      createdAt: Value(createdAt),
    );
  }

  factory Recipe.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Recipe(
      uuid: serializer.fromJson<String>(json['uuid']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String>(json['description']),
      imageUrl: serializer.fromJson<String>(json['imageUrl']),
      type: serializer.fromJson<String>(json['type']),
      steps: serializer.fromJson<List<String>>(json['steps']),
      ingredients: serializer.fromJson<List<String>>(json['ingredients']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'uuid': serializer.toJson<String>(uuid),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String>(description),
      'imageUrl': serializer.toJson<String>(imageUrl),
      'type': serializer.toJson<String>(type),
      'steps': serializer.toJson<List<String>>(steps),
      'ingredients': serializer.toJson<List<String>>(ingredients),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Recipe copyWith({
    String? uuid,
    String? title,
    String? description,
    String? imageUrl,
    String? type,
    List<String>? steps,
    List<String>? ingredients,
    DateTime? createdAt,
  }) => Recipe(
    uuid: uuid ?? this.uuid,
    title: title ?? this.title,
    description: description ?? this.description,
    imageUrl: imageUrl ?? this.imageUrl,
    type: type ?? this.type,
    steps: steps ?? this.steps,
    ingredients: ingredients ?? this.ingredients,
    createdAt: createdAt ?? this.createdAt,
  );
  Recipe copyWithCompanion(RecipesCompanion data) {
    return Recipe(
      uuid: data.uuid.present ? data.uuid.value : this.uuid,
      title: data.title.present ? data.title.value : this.title,
      description:
          data.description.present ? data.description.value : this.description,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      type: data.type.present ? data.type.value : this.type,
      steps: data.steps.present ? data.steps.value : this.steps,
      ingredients:
          data.ingredients.present ? data.ingredients.value : this.ingredients,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Recipe(')
          ..write('uuid: $uuid, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('type: $type, ')
          ..write('steps: $steps, ')
          ..write('ingredients: $ingredients, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    uuid,
    title,
    description,
    imageUrl,
    type,
    steps,
    ingredients,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Recipe &&
          other.uuid == this.uuid &&
          other.title == this.title &&
          other.description == this.description &&
          other.imageUrl == this.imageUrl &&
          other.type == this.type &&
          other.steps == this.steps &&
          other.ingredients == this.ingredients &&
          other.createdAt == this.createdAt);
}

class RecipesCompanion extends UpdateCompanion<Recipe> {
  final Value<String> uuid;
  final Value<String> title;
  final Value<String> description;
  final Value<String> imageUrl;
  final Value<String> type;
  final Value<List<String>> steps;
  final Value<List<String>> ingredients;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const RecipesCompanion({
    this.uuid = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.type = const Value.absent(),
    this.steps = const Value.absent(),
    this.ingredients = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RecipesCompanion.insert({
    required String uuid,
    required String title,
    required String description,
    required String imageUrl,
    required String type,
    required List<String> steps,
    required List<String> ingredients,
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : uuid = Value(uuid),
       title = Value(title),
       description = Value(description),
       imageUrl = Value(imageUrl),
       type = Value(type),
       steps = Value(steps),
       ingredients = Value(ingredients),
       createdAt = Value(createdAt);
  static Insertable<Recipe> custom({
    Expression<String>? uuid,
    Expression<String>? title,
    Expression<String>? description,
    Expression<String>? imageUrl,
    Expression<String>? type,
    Expression<String>? steps,
    Expression<String>? ingredients,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (uuid != null) 'uuid': uuid,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (imageUrl != null) 'image_url': imageUrl,
      if (type != null) 'type': type,
      if (steps != null) 'steps': steps,
      if (ingredients != null) 'ingredients': ingredients,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RecipesCompanion copyWith({
    Value<String>? uuid,
    Value<String>? title,
    Value<String>? description,
    Value<String>? imageUrl,
    Value<String>? type,
    Value<List<String>>? steps,
    Value<List<String>>? ingredients,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return RecipesCompanion(
      uuid: uuid ?? this.uuid,
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      type: type ?? this.type,
      steps: steps ?? this.steps,
      ingredients: ingredients ?? this.ingredients,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (steps.present) {
      map['steps'] = Variable<String>(
        $RecipesTable.$convertersteps.toSql(steps.value),
      );
    }
    if (ingredients.present) {
      map['ingredients'] = Variable<String>(
        $RecipesTable.$converteringredients.toSql(ingredients.value),
      );
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecipesCompanion(')
          ..write('uuid: $uuid, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('type: $type, ')
          ..write('steps: $steps, ')
          ..write('ingredients: $ingredients, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $RecipesTable recipes = $RecipesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [recipes];
}

typedef $$RecipesTableCreateCompanionBuilder =
    RecipesCompanion Function({
      required String uuid,
      required String title,
      required String description,
      required String imageUrl,
      required String type,
      required List<String> steps,
      required List<String> ingredients,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$RecipesTableUpdateCompanionBuilder =
    RecipesCompanion Function({
      Value<String> uuid,
      Value<String> title,
      Value<String> description,
      Value<String> imageUrl,
      Value<String> type,
      Value<List<String>> steps,
      Value<List<String>> ingredients,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$RecipesTableFilterComposer
    extends Composer<_$AppDatabase, $RecipesTable> {
  $$RecipesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get uuid => $composableBuilder(
    column: $table.uuid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<List<String>, List<String>, String>
  get steps => $composableBuilder(
    column: $table.steps,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<List<String>, List<String>, String>
  get ingredients => $composableBuilder(
    column: $table.ingredients,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$RecipesTableOrderingComposer
    extends Composer<_$AppDatabase, $RecipesTable> {
  $$RecipesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get uuid => $composableBuilder(
    column: $table.uuid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get steps => $composableBuilder(
    column: $table.steps,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ingredients => $composableBuilder(
    column: $table.ingredients,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RecipesTableAnnotationComposer
    extends Composer<_$AppDatabase, $RecipesTable> {
  $$RecipesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get uuid =>
      $composableBuilder(column: $table.uuid, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<String>, String> get steps =>
      $composableBuilder(column: $table.steps, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<String>, String> get ingredients =>
      $composableBuilder(
        column: $table.ingredients,
        builder: (column) => column,
      );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$RecipesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RecipesTable,
          Recipe,
          $$RecipesTableFilterComposer,
          $$RecipesTableOrderingComposer,
          $$RecipesTableAnnotationComposer,
          $$RecipesTableCreateCompanionBuilder,
          $$RecipesTableUpdateCompanionBuilder,
          (Recipe, BaseReferences<_$AppDatabase, $RecipesTable, Recipe>),
          Recipe,
          PrefetchHooks Function()
        > {
  $$RecipesTableTableManager(_$AppDatabase db, $RecipesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$RecipesTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$RecipesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$RecipesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> uuid = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String> imageUrl = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<List<String>> steps = const Value.absent(),
                Value<List<String>> ingredients = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RecipesCompanion(
                uuid: uuid,
                title: title,
                description: description,
                imageUrl: imageUrl,
                type: type,
                steps: steps,
                ingredients: ingredients,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String uuid,
                required String title,
                required String description,
                required String imageUrl,
                required String type,
                required List<String> steps,
                required List<String> ingredients,
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => RecipesCompanion.insert(
                uuid: uuid,
                title: title,
                description: description,
                imageUrl: imageUrl,
                type: type,
                steps: steps,
                ingredients: ingredients,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$RecipesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RecipesTable,
      Recipe,
      $$RecipesTableFilterComposer,
      $$RecipesTableOrderingComposer,
      $$RecipesTableAnnotationComposer,
      $$RecipesTableCreateCompanionBuilder,
      $$RecipesTableUpdateCompanionBuilder,
      (Recipe, BaseReferences<_$AppDatabase, $RecipesTable, Recipe>),
      Recipe,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$RecipesTableTableManager get recipes =>
      $$RecipesTableTableManager(_db, _db.recipes);
}
