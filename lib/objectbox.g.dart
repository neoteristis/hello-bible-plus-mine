// GENERATED CODE - DO NOT MODIFY BY HAND
// This code was generated by ObjectBox. To update it run the generator again:
// With a Flutter package, run `flutter pub run build_runner build`.
// With a Dart package, run `dart run build_runner build`.
// See also https://docs.objectbox.io/getting-started#generate-objectbox-code

// ignore_for_file: camel_case_types, depend_on_referenced_packages
// coverage:ignore-file

import 'dart:typed_data';

import 'package:flat_buffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart';
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';

import 'features/user/data/models/box/user_box.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <ModelEntity>[
  ModelEntity(
      id: const IdUid(1, 7838920545034932613),
      name: 'UserBox',
      lastPropertyId: const IdUid(6, 1172951633420248115),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 4926795869182575631),
            name: 'idInt',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 534331793983346611),
            name: 'idString',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 3638541182721892749),
            name: 'lastName',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 5537996165916685530),
            name: 'firstName',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 266519307572371390),
            name: 'email',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(6, 1172951633420248115),
            name: 'country',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[])
];

/// Open an ObjectBox store with the model declared in this file.
Future<Store> openStore(
        {String? directory,
        int? maxDBSizeInKB,
        int? fileMode,
        int? maxReaders,
        bool queriesCaseSensitiveDefault = true,
        String? macosApplicationGroup}) async =>
    Store(getObjectBoxModel(),
        directory: directory ?? (await defaultStoreDirectory()).path,
        maxDBSizeInKB: maxDBSizeInKB,
        fileMode: fileMode,
        maxReaders: maxReaders,
        queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
        macosApplicationGroup: macosApplicationGroup);

/// ObjectBox model definition, pass it to [Store] - Store(getObjectBoxModel())
ModelDefinition getObjectBoxModel() {
  final model = ModelInfo(
      entities: _entities,
      lastEntityId: const IdUid(1, 7838920545034932613),
      lastIndexId: const IdUid(1, 1244437634396254790),
      lastRelationId: const IdUid(0, 0),
      lastSequenceId: const IdUid(0, 0),
      retiredEntityUids: const [],
      retiredIndexUids: const [1244437634396254790],
      retiredPropertyUids: const [],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, EntityDefinition>{
    UserBox: EntityDefinition<UserBox>(
        model: _entities[0],
        toOneRelations: (UserBox object) => [],
        toManyRelations: (UserBox object) => {},
        getId: (UserBox object) => object.idInt,
        setId: (UserBox object, int id) {
          object.idInt = id;
        },
        objectToFB: (UserBox object, fb.Builder fbb) {
          final idStringOffset = object.idString == null
              ? null
              : fbb.writeString(object.idString!);
          final lastNameOffset = object.lastName == null
              ? null
              : fbb.writeString(object.lastName!);
          final firstNameOffset = object.firstName == null
              ? null
              : fbb.writeString(object.firstName!);
          final emailOffset =
              object.email == null ? null : fbb.writeString(object.email!);
          final countryOffset =
              object.country == null ? null : fbb.writeString(object.country!);
          fbb.startTable(7);
          fbb.addInt64(0, object.idInt ?? 0);
          fbb.addOffset(1, idStringOffset);
          fbb.addOffset(2, lastNameOffset);
          fbb.addOffset(3, firstNameOffset);
          fbb.addOffset(4, emailOffset);
          fbb.addOffset(5, countryOffset);
          fbb.finish(fbb.endTable());
          return object.idInt ?? 0;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = UserBox(
              idInt: const fb.Int64Reader()
                  .vTableGetNullable(buffer, rootOffset, 4),
              idString: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 6),
              lastName: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 8),
              firstName: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 10),
              email: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 12),
              country: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 14));

          return object;
        })
  };

  return ModelDefinition(model, bindings);
}

/// [UserBox] entity fields to define ObjectBox queries.
class UserBox_ {
  /// see [UserBox.idInt]
  static final idInt =
      QueryIntegerProperty<UserBox>(_entities[0].properties[0]);

  /// see [UserBox.idString]
  static final idString =
      QueryStringProperty<UserBox>(_entities[0].properties[1]);

  /// see [UserBox.lastName]
  static final lastName =
      QueryStringProperty<UserBox>(_entities[0].properties[2]);

  /// see [UserBox.firstName]
  static final firstName =
      QueryStringProperty<UserBox>(_entities[0].properties[3]);

  /// see [UserBox.email]
  static final email = QueryStringProperty<UserBox>(_entities[0].properties[4]);

  /// see [UserBox.country]
  static final country =
      QueryStringProperty<UserBox>(_entities[0].properties[5]);
}
