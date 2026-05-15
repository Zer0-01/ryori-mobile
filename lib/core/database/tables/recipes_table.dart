import 'dart:convert';

import 'package:drift/drift.dart';

class StringListConverter extends TypeConverter<List<String>, String> {
  const StringListConverter();

  @override
  List<String> fromSql(String fromDb) {
    final decoded = jsonDecode(fromDb);
    if (decoded is! List) {
      throw const FormatException('Expected a JSON array for string list.');
    }

    return _normalize(decoded);
  }

  @override
  String toSql(List<String> value) {
    return jsonEncode(_normalize(value));
  }

  List<String> _normalize(List<dynamic> values) {
    final normalized =
        values.map((value) => value.toString().trim()).toList(growable: false);

    if (normalized.isEmpty) {
      throw ArgumentError.value(
        values,
        'values',
        'List must contain at least one item.',
      );
    }

    if (normalized.any((value) => value.isEmpty)) {
      throw ArgumentError.value(
        values,
        'values',
        'List items must not be empty.',
      );
    }

    return normalized;
  }
}

class Recipes extends Table {
  TextColumn get uuid => text()();
  TextColumn get title => text()();
  TextColumn get description => text()();
  TextColumn get imageUrl => text()();
  TextColumn get type => text()();
  TextColumn get steps => text().map(const StringListConverter())();
  TextColumn get ingredients => text().map(const StringListConverter())();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {uuid};

  @override
  List<String> get customConstraints => [
    'CHECK (title <> \'\')',
    'CHECK (description <> \'\')',
    'CHECK (image_url <> \'\')',
    'CHECK (type <> \'\')',
    'CHECK (json_valid(steps) AND json_type(steps) = \'array\' AND json_array_length(steps) > 0)',
    'CHECK (json_valid(ingredients) AND json_type(ingredients) = \'array\' AND json_array_length(ingredients) > 0)',
  ];
}
