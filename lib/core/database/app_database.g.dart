// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ConversationsTable extends Conversations
    with TableInfo<$ConversationsTable, Conversation> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ConversationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _projectIdMeta = const VerificationMeta(
    'projectId',
  );
  @override
  late final GeneratedColumn<String> projectId = GeneratedColumn<String>(
    'project_id',
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
  static const VerificationMeta _purposeMeta = const VerificationMeta(
    'purpose',
  );
  @override
  late final GeneratedColumn<String> purpose = GeneratedColumn<String>(
    'purpose',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isArchivedMeta = const VerificationMeta(
    'isArchived',
  );
  @override
  late final GeneratedColumn<bool> isArchived = GeneratedColumn<bool>(
    'is_archived',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_archived" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
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
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    projectId,
    title,
    purpose,
    status,
    isArchived,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'conversations';
  @override
  VerificationContext validateIntegrity(
    Insertable<Conversation> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('project_id')) {
      context.handle(
        _projectIdMeta,
        projectId.isAcceptableOrUnknown(data['project_id']!, _projectIdMeta),
      );
    } else if (isInserting) {
      context.missing(_projectIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('purpose')) {
      context.handle(
        _purposeMeta,
        purpose.isAcceptableOrUnknown(data['purpose']!, _purposeMeta),
      );
    } else if (isInserting) {
      context.missing(_purposeMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('is_archived')) {
      context.handle(
        _isArchivedMeta,
        isArchived.isAcceptableOrUnknown(data['is_archived']!, _isArchivedMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Conversation map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Conversation(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      projectId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}project_id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      purpose: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}purpose'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      isArchived: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_archived'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ConversationsTable createAlias(String alias) {
    return $ConversationsTable(attachedDatabase, alias);
  }
}

class Conversation extends DataClass implements Insertable<Conversation> {
  final String id;
  final String projectId;
  final String title;
  final String purpose;
  final String status;
  final bool isArchived;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Conversation({
    required this.id,
    required this.projectId,
    required this.title,
    required this.purpose,
    required this.status,
    required this.isArchived,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['project_id'] = Variable<String>(projectId);
    map['title'] = Variable<String>(title);
    map['purpose'] = Variable<String>(purpose);
    map['status'] = Variable<String>(status);
    map['is_archived'] = Variable<bool>(isArchived);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ConversationsCompanion toCompanion(bool nullToAbsent) {
    return ConversationsCompanion(
      id: Value(id),
      projectId: Value(projectId),
      title: Value(title),
      purpose: Value(purpose),
      status: Value(status),
      isArchived: Value(isArchived),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Conversation.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Conversation(
      id: serializer.fromJson<String>(json['id']),
      projectId: serializer.fromJson<String>(json['projectId']),
      title: serializer.fromJson<String>(json['title']),
      purpose: serializer.fromJson<String>(json['purpose']),
      status: serializer.fromJson<String>(json['status']),
      isArchived: serializer.fromJson<bool>(json['isArchived']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'projectId': serializer.toJson<String>(projectId),
      'title': serializer.toJson<String>(title),
      'purpose': serializer.toJson<String>(purpose),
      'status': serializer.toJson<String>(status),
      'isArchived': serializer.toJson<bool>(isArchived),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Conversation copyWith({
    String? id,
    String? projectId,
    String? title,
    String? purpose,
    String? status,
    bool? isArchived,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Conversation(
    id: id ?? this.id,
    projectId: projectId ?? this.projectId,
    title: title ?? this.title,
    purpose: purpose ?? this.purpose,
    status: status ?? this.status,
    isArchived: isArchived ?? this.isArchived,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Conversation copyWithCompanion(ConversationsCompanion data) {
    return Conversation(
      id: data.id.present ? data.id.value : this.id,
      projectId: data.projectId.present ? data.projectId.value : this.projectId,
      title: data.title.present ? data.title.value : this.title,
      purpose: data.purpose.present ? data.purpose.value : this.purpose,
      status: data.status.present ? data.status.value : this.status,
      isArchived: data.isArchived.present
          ? data.isArchived.value
          : this.isArchived,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Conversation(')
          ..write('id: $id, ')
          ..write('projectId: $projectId, ')
          ..write('title: $title, ')
          ..write('purpose: $purpose, ')
          ..write('status: $status, ')
          ..write('isArchived: $isArchived, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    projectId,
    title,
    purpose,
    status,
    isArchived,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Conversation &&
          other.id == this.id &&
          other.projectId == this.projectId &&
          other.title == this.title &&
          other.purpose == this.purpose &&
          other.status == this.status &&
          other.isArchived == this.isArchived &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ConversationsCompanion extends UpdateCompanion<Conversation> {
  final Value<String> id;
  final Value<String> projectId;
  final Value<String> title;
  final Value<String> purpose;
  final Value<String> status;
  final Value<bool> isArchived;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const ConversationsCompanion({
    this.id = const Value.absent(),
    this.projectId = const Value.absent(),
    this.title = const Value.absent(),
    this.purpose = const Value.absent(),
    this.status = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ConversationsCompanion.insert({
    required String id,
    required String projectId,
    required String title,
    required String purpose,
    required String status,
    this.isArchived = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       projectId = Value(projectId),
       title = Value(title),
       purpose = Value(purpose),
       status = Value(status),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Conversation> custom({
    Expression<String>? id,
    Expression<String>? projectId,
    Expression<String>? title,
    Expression<String>? purpose,
    Expression<String>? status,
    Expression<bool>? isArchived,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (projectId != null) 'project_id': projectId,
      if (title != null) 'title': title,
      if (purpose != null) 'purpose': purpose,
      if (status != null) 'status': status,
      if (isArchived != null) 'is_archived': isArchived,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ConversationsCompanion copyWith({
    Value<String>? id,
    Value<String>? projectId,
    Value<String>? title,
    Value<String>? purpose,
    Value<String>? status,
    Value<bool>? isArchived,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return ConversationsCompanion(
      id: id ?? this.id,
      projectId: projectId ?? this.projectId,
      title: title ?? this.title,
      purpose: purpose ?? this.purpose,
      status: status ?? this.status,
      isArchived: isArchived ?? this.isArchived,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (projectId.present) {
      map['project_id'] = Variable<String>(projectId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (purpose.present) {
      map['purpose'] = Variable<String>(purpose.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (isArchived.present) {
      map['is_archived'] = Variable<bool>(isArchived.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ConversationsCompanion(')
          ..write('id: $id, ')
          ..write('projectId: $projectId, ')
          ..write('title: $title, ')
          ..write('purpose: $purpose, ')
          ..write('status: $status, ')
          ..write('isArchived: $isArchived, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LlmSettingsTableTable extends LlmSettingsTable
    with TableInfo<$LlmSettingsTableTable, LlmSettingsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LlmSettingsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _providerMeta = const VerificationMeta(
    'provider',
  );
  @override
  late final GeneratedColumn<String> provider = GeneratedColumn<String>(
    'provider',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _modelMeta = const VerificationMeta('model');
  @override
  late final GeneratedColumn<String> model = GeneratedColumn<String>(
    'model',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _streamingMeta = const VerificationMeta(
    'streaming',
  );
  @override
  late final GeneratedColumn<bool> streaming = GeneratedColumn<bool>(
    'streaming',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("streaming" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    provider,
    model,
    streaming,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'llm_settings_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<LlmSettingsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('provider')) {
      context.handle(
        _providerMeta,
        provider.isAcceptableOrUnknown(data['provider']!, _providerMeta),
      );
    } else if (isInserting) {
      context.missing(_providerMeta);
    }
    if (data.containsKey('model')) {
      context.handle(
        _modelMeta,
        model.isAcceptableOrUnknown(data['model']!, _modelMeta),
      );
    } else if (isInserting) {
      context.missing(_modelMeta);
    }
    if (data.containsKey('streaming')) {
      context.handle(
        _streamingMeta,
        streaming.isAcceptableOrUnknown(data['streaming']!, _streamingMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LlmSettingsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LlmSettingsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      provider: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}provider'],
      )!,
      model: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}model'],
      )!,
      streaming: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}streaming'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $LlmSettingsTableTable createAlias(String alias) {
    return $LlmSettingsTableTable(attachedDatabase, alias);
  }
}

class LlmSettingsTableData extends DataClass
    implements Insertable<LlmSettingsTableData> {
  final int id;
  final String provider;
  final String model;
  final bool streaming;
  final DateTime updatedAt;
  const LlmSettingsTableData({
    required this.id,
    required this.provider,
    required this.model,
    required this.streaming,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['provider'] = Variable<String>(provider);
    map['model'] = Variable<String>(model);
    map['streaming'] = Variable<bool>(streaming);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  LlmSettingsTableCompanion toCompanion(bool nullToAbsent) {
    return LlmSettingsTableCompanion(
      id: Value(id),
      provider: Value(provider),
      model: Value(model),
      streaming: Value(streaming),
      updatedAt: Value(updatedAt),
    );
  }

  factory LlmSettingsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LlmSettingsTableData(
      id: serializer.fromJson<int>(json['id']),
      provider: serializer.fromJson<String>(json['provider']),
      model: serializer.fromJson<String>(json['model']),
      streaming: serializer.fromJson<bool>(json['streaming']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'provider': serializer.toJson<String>(provider),
      'model': serializer.toJson<String>(model),
      'streaming': serializer.toJson<bool>(streaming),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  LlmSettingsTableData copyWith({
    int? id,
    String? provider,
    String? model,
    bool? streaming,
    DateTime? updatedAt,
  }) => LlmSettingsTableData(
    id: id ?? this.id,
    provider: provider ?? this.provider,
    model: model ?? this.model,
    streaming: streaming ?? this.streaming,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  LlmSettingsTableData copyWithCompanion(LlmSettingsTableCompanion data) {
    return LlmSettingsTableData(
      id: data.id.present ? data.id.value : this.id,
      provider: data.provider.present ? data.provider.value : this.provider,
      model: data.model.present ? data.model.value : this.model,
      streaming: data.streaming.present ? data.streaming.value : this.streaming,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LlmSettingsTableData(')
          ..write('id: $id, ')
          ..write('provider: $provider, ')
          ..write('model: $model, ')
          ..write('streaming: $streaming, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, provider, model, streaming, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LlmSettingsTableData &&
          other.id == this.id &&
          other.provider == this.provider &&
          other.model == this.model &&
          other.streaming == this.streaming &&
          other.updatedAt == this.updatedAt);
}

class LlmSettingsTableCompanion extends UpdateCompanion<LlmSettingsTableData> {
  final Value<int> id;
  final Value<String> provider;
  final Value<String> model;
  final Value<bool> streaming;
  final Value<DateTime> updatedAt;
  const LlmSettingsTableCompanion({
    this.id = const Value.absent(),
    this.provider = const Value.absent(),
    this.model = const Value.absent(),
    this.streaming = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  LlmSettingsTableCompanion.insert({
    this.id = const Value.absent(),
    required String provider,
    required String model,
    this.streaming = const Value.absent(),
    required DateTime updatedAt,
  }) : provider = Value(provider),
       model = Value(model),
       updatedAt = Value(updatedAt);
  static Insertable<LlmSettingsTableData> custom({
    Expression<int>? id,
    Expression<String>? provider,
    Expression<String>? model,
    Expression<bool>? streaming,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (provider != null) 'provider': provider,
      if (model != null) 'model': model,
      if (streaming != null) 'streaming': streaming,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  LlmSettingsTableCompanion copyWith({
    Value<int>? id,
    Value<String>? provider,
    Value<String>? model,
    Value<bool>? streaming,
    Value<DateTime>? updatedAt,
  }) {
    return LlmSettingsTableCompanion(
      id: id ?? this.id,
      provider: provider ?? this.provider,
      model: model ?? this.model,
      streaming: streaming ?? this.streaming,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (provider.present) {
      map['provider'] = Variable<String>(provider.value);
    }
    if (model.present) {
      map['model'] = Variable<String>(model.value);
    }
    if (streaming.present) {
      map['streaming'] = Variable<bool>(streaming.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LlmSettingsTableCompanion(')
          ..write('id: $id, ')
          ..write('provider: $provider, ')
          ..write('model: $model, ')
          ..write('streaming: $streaming, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $PipelinesTableTable extends PipelinesTable
    with TableInfo<$PipelinesTableTable, PipelinesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PipelinesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _stepIdsMeta = const VerificationMeta(
    'stepIds',
  );
  @override
  late final GeneratedColumn<String> stepIds = GeneratedColumn<String>(
    'step_ids',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _enabledMeta = const VerificationMeta(
    'enabled',
  );
  @override
  late final GeneratedColumn<bool> enabled = GeneratedColumn<bool>(
    'enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, stepIds, enabled];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pipelines_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<PipelinesTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('step_ids')) {
      context.handle(
        _stepIdsMeta,
        stepIds.isAcceptableOrUnknown(data['step_ids']!, _stepIdsMeta),
      );
    } else if (isInserting) {
      context.missing(_stepIdsMeta);
    }
    if (data.containsKey('enabled')) {
      context.handle(
        _enabledMeta,
        enabled.isAcceptableOrUnknown(data['enabled']!, _enabledMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PipelinesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PipelinesTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      stepIds: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}step_ids'],
      )!,
      enabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}enabled'],
      )!,
    );
  }

  @override
  $PipelinesTableTable createAlias(String alias) {
    return $PipelinesTableTable(attachedDatabase, alias);
  }
}

class PipelinesTableData extends DataClass
    implements Insertable<PipelinesTableData> {
  final String id;
  final String name;
  final String stepIds;
  final bool enabled;
  const PipelinesTableData({
    required this.id,
    required this.name,
    required this.stepIds,
    required this.enabled,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['step_ids'] = Variable<String>(stepIds);
    map['enabled'] = Variable<bool>(enabled);
    return map;
  }

  PipelinesTableCompanion toCompanion(bool nullToAbsent) {
    return PipelinesTableCompanion(
      id: Value(id),
      name: Value(name),
      stepIds: Value(stepIds),
      enabled: Value(enabled),
    );
  }

  factory PipelinesTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PipelinesTableData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      stepIds: serializer.fromJson<String>(json['stepIds']),
      enabled: serializer.fromJson<bool>(json['enabled']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'stepIds': serializer.toJson<String>(stepIds),
      'enabled': serializer.toJson<bool>(enabled),
    };
  }

  PipelinesTableData copyWith({
    String? id,
    String? name,
    String? stepIds,
    bool? enabled,
  }) => PipelinesTableData(
    id: id ?? this.id,
    name: name ?? this.name,
    stepIds: stepIds ?? this.stepIds,
    enabled: enabled ?? this.enabled,
  );
  PipelinesTableData copyWithCompanion(PipelinesTableCompanion data) {
    return PipelinesTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      stepIds: data.stepIds.present ? data.stepIds.value : this.stepIds,
      enabled: data.enabled.present ? data.enabled.value : this.enabled,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PipelinesTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('stepIds: $stepIds, ')
          ..write('enabled: $enabled')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, stepIds, enabled);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PipelinesTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.stepIds == this.stepIds &&
          other.enabled == this.enabled);
}

class PipelinesTableCompanion extends UpdateCompanion<PipelinesTableData> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> stepIds;
  final Value<bool> enabled;
  final Value<int> rowid;
  const PipelinesTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.stepIds = const Value.absent(),
    this.enabled = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PipelinesTableCompanion.insert({
    required String id,
    required String name,
    required String stepIds,
    this.enabled = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       stepIds = Value(stepIds);
  static Insertable<PipelinesTableData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? stepIds,
    Expression<bool>? enabled,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (stepIds != null) 'step_ids': stepIds,
      if (enabled != null) 'enabled': enabled,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PipelinesTableCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? stepIds,
    Value<bool>? enabled,
    Value<int>? rowid,
  }) {
    return PipelinesTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      stepIds: stepIds ?? this.stepIds,
      enabled: enabled ?? this.enabled,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (stepIds.present) {
      map['step_ids'] = Variable<String>(stepIds.value);
    }
    if (enabled.present) {
      map['enabled'] = Variable<bool>(enabled.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PipelinesTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('stepIds: $stepIds, ')
          ..write('enabled: $enabled, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PipelinePurposeTableTable extends PipelinePurposeTable
    with TableInfo<$PipelinePurposeTableTable, PipelinePurposeTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PipelinePurposeTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _purposeMeta = const VerificationMeta(
    'purpose',
  );
  @override
  late final GeneratedColumn<String> purpose = GeneratedColumn<String>(
    'purpose',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pipelineIdMeta = const VerificationMeta(
    'pipelineId',
  );
  @override
  late final GeneratedColumn<String> pipelineId = GeneratedColumn<String>(
    'pipeline_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [purpose, pipelineId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pipeline_purpose_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<PipelinePurposeTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('purpose')) {
      context.handle(
        _purposeMeta,
        purpose.isAcceptableOrUnknown(data['purpose']!, _purposeMeta),
      );
    } else if (isInserting) {
      context.missing(_purposeMeta);
    }
    if (data.containsKey('pipeline_id')) {
      context.handle(
        _pipelineIdMeta,
        pipelineId.isAcceptableOrUnknown(data['pipeline_id']!, _pipelineIdMeta),
      );
    } else if (isInserting) {
      context.missing(_pipelineIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {purpose};
  @override
  PipelinePurposeTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PipelinePurposeTableData(
      purpose: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}purpose'],
      )!,
      pipelineId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pipeline_id'],
      )!,
    );
  }

  @override
  $PipelinePurposeTableTable createAlias(String alias) {
    return $PipelinePurposeTableTable(attachedDatabase, alias);
  }
}

class PipelinePurposeTableData extends DataClass
    implements Insertable<PipelinePurposeTableData> {
  final String purpose;
  final String pipelineId;
  const PipelinePurposeTableData({
    required this.purpose,
    required this.pipelineId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['purpose'] = Variable<String>(purpose);
    map['pipeline_id'] = Variable<String>(pipelineId);
    return map;
  }

  PipelinePurposeTableCompanion toCompanion(bool nullToAbsent) {
    return PipelinePurposeTableCompanion(
      purpose: Value(purpose),
      pipelineId: Value(pipelineId),
    );
  }

  factory PipelinePurposeTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PipelinePurposeTableData(
      purpose: serializer.fromJson<String>(json['purpose']),
      pipelineId: serializer.fromJson<String>(json['pipelineId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'purpose': serializer.toJson<String>(purpose),
      'pipelineId': serializer.toJson<String>(pipelineId),
    };
  }

  PipelinePurposeTableData copyWith({String? purpose, String? pipelineId}) =>
      PipelinePurposeTableData(
        purpose: purpose ?? this.purpose,
        pipelineId: pipelineId ?? this.pipelineId,
      );
  PipelinePurposeTableData copyWithCompanion(
    PipelinePurposeTableCompanion data,
  ) {
    return PipelinePurposeTableData(
      purpose: data.purpose.present ? data.purpose.value : this.purpose,
      pipelineId: data.pipelineId.present
          ? data.pipelineId.value
          : this.pipelineId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PipelinePurposeTableData(')
          ..write('purpose: $purpose, ')
          ..write('pipelineId: $pipelineId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(purpose, pipelineId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PipelinePurposeTableData &&
          other.purpose == this.purpose &&
          other.pipelineId == this.pipelineId);
}

class PipelinePurposeTableCompanion
    extends UpdateCompanion<PipelinePurposeTableData> {
  final Value<String> purpose;
  final Value<String> pipelineId;
  final Value<int> rowid;
  const PipelinePurposeTableCompanion({
    this.purpose = const Value.absent(),
    this.pipelineId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PipelinePurposeTableCompanion.insert({
    required String purpose,
    required String pipelineId,
    this.rowid = const Value.absent(),
  }) : purpose = Value(purpose),
       pipelineId = Value(pipelineId);
  static Insertable<PipelinePurposeTableData> custom({
    Expression<String>? purpose,
    Expression<String>? pipelineId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (purpose != null) 'purpose': purpose,
      if (pipelineId != null) 'pipeline_id': pipelineId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PipelinePurposeTableCompanion copyWith({
    Value<String>? purpose,
    Value<String>? pipelineId,
    Value<int>? rowid,
  }) {
    return PipelinePurposeTableCompanion(
      purpose: purpose ?? this.purpose,
      pipelineId: pipelineId ?? this.pipelineId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (purpose.present) {
      map['purpose'] = Variable<String>(purpose.value);
    }
    if (pipelineId.present) {
      map['pipeline_id'] = Variable<String>(pipelineId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PipelinePurposeTableCompanion(')
          ..write('purpose: $purpose, ')
          ..write('pipelineId: $pipelineId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $KnowledgeChunksTableTable extends KnowledgeChunksTable
    with TableInfo<$KnowledgeChunksTableTable, KnowledgeChunksTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $KnowledgeChunksTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _projectIdMeta = const VerificationMeta(
    'projectId',
  );
  @override
  late final GeneratedColumn<String> projectId = GeneratedColumn<String>(
    'project_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceIdMeta = const VerificationMeta(
    'sourceId',
  );
  @override
  late final GeneratedColumn<String> sourceId = GeneratedColumn<String>(
    'source_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _positionMeta = const VerificationMeta(
    'position',
  );
  @override
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
    'position',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _charStartMeta = const VerificationMeta(
    'charStart',
  );
  @override
  late final GeneratedColumn<int> charStart = GeneratedColumn<int>(
    'char_start',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _charEndMeta = const VerificationMeta(
    'charEnd',
  );
  @override
  late final GeneratedColumn<int> charEnd = GeneratedColumn<int>(
    'char_end',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
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
    id,
    projectId,
    source,
    sourceId,
    position,
    charStart,
    charEnd,
    version,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'knowledge_chunks_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<KnowledgeChunksTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('project_id')) {
      context.handle(
        _projectIdMeta,
        projectId.isAcceptableOrUnknown(data['project_id']!, _projectIdMeta),
      );
    } else if (isInserting) {
      context.missing(_projectIdMeta);
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceMeta);
    }
    if (data.containsKey('source_id')) {
      context.handle(
        _sourceIdMeta,
        sourceId.isAcceptableOrUnknown(data['source_id']!, _sourceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceIdMeta);
    }
    if (data.containsKey('position')) {
      context.handle(
        _positionMeta,
        position.isAcceptableOrUnknown(data['position']!, _positionMeta),
      );
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    if (data.containsKey('char_start')) {
      context.handle(
        _charStartMeta,
        charStart.isAcceptableOrUnknown(data['char_start']!, _charStartMeta),
      );
    } else if (isInserting) {
      context.missing(_charStartMeta);
    }
    if (data.containsKey('char_end')) {
      context.handle(
        _charEndMeta,
        charEnd.isAcceptableOrUnknown(data['char_end']!, _charEndMeta),
      );
    } else if (isInserting) {
      context.missing(_charEndMeta);
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    } else if (isInserting) {
      context.missing(_versionMeta);
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
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  KnowledgeChunksTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return KnowledgeChunksTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      projectId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}project_id'],
      )!,
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      )!,
      sourceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_id'],
      )!,
      position: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}position'],
      )!,
      charStart: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}char_start'],
      )!,
      charEnd: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}char_end'],
      )!,
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $KnowledgeChunksTableTable createAlias(String alias) {
    return $KnowledgeChunksTableTable(attachedDatabase, alias);
  }
}

class KnowledgeChunksTableData extends DataClass
    implements Insertable<KnowledgeChunksTableData> {
  final String id;
  final String projectId;
  final String source;
  final String sourceId;
  final int position;
  final int charStart;
  final int charEnd;
  final int version;
  final DateTime createdAt;
  const KnowledgeChunksTableData({
    required this.id,
    required this.projectId,
    required this.source,
    required this.sourceId,
    required this.position,
    required this.charStart,
    required this.charEnd,
    required this.version,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['project_id'] = Variable<String>(projectId);
    map['source'] = Variable<String>(source);
    map['source_id'] = Variable<String>(sourceId);
    map['position'] = Variable<int>(position);
    map['char_start'] = Variable<int>(charStart);
    map['char_end'] = Variable<int>(charEnd);
    map['version'] = Variable<int>(version);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  KnowledgeChunksTableCompanion toCompanion(bool nullToAbsent) {
    return KnowledgeChunksTableCompanion(
      id: Value(id),
      projectId: Value(projectId),
      source: Value(source),
      sourceId: Value(sourceId),
      position: Value(position),
      charStart: Value(charStart),
      charEnd: Value(charEnd),
      version: Value(version),
      createdAt: Value(createdAt),
    );
  }

  factory KnowledgeChunksTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return KnowledgeChunksTableData(
      id: serializer.fromJson<String>(json['id']),
      projectId: serializer.fromJson<String>(json['projectId']),
      source: serializer.fromJson<String>(json['source']),
      sourceId: serializer.fromJson<String>(json['sourceId']),
      position: serializer.fromJson<int>(json['position']),
      charStart: serializer.fromJson<int>(json['charStart']),
      charEnd: serializer.fromJson<int>(json['charEnd']),
      version: serializer.fromJson<int>(json['version']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'projectId': serializer.toJson<String>(projectId),
      'source': serializer.toJson<String>(source),
      'sourceId': serializer.toJson<String>(sourceId),
      'position': serializer.toJson<int>(position),
      'charStart': serializer.toJson<int>(charStart),
      'charEnd': serializer.toJson<int>(charEnd),
      'version': serializer.toJson<int>(version),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  KnowledgeChunksTableData copyWith({
    String? id,
    String? projectId,
    String? source,
    String? sourceId,
    int? position,
    int? charStart,
    int? charEnd,
    int? version,
    DateTime? createdAt,
  }) => KnowledgeChunksTableData(
    id: id ?? this.id,
    projectId: projectId ?? this.projectId,
    source: source ?? this.source,
    sourceId: sourceId ?? this.sourceId,
    position: position ?? this.position,
    charStart: charStart ?? this.charStart,
    charEnd: charEnd ?? this.charEnd,
    version: version ?? this.version,
    createdAt: createdAt ?? this.createdAt,
  );
  KnowledgeChunksTableData copyWithCompanion(
    KnowledgeChunksTableCompanion data,
  ) {
    return KnowledgeChunksTableData(
      id: data.id.present ? data.id.value : this.id,
      projectId: data.projectId.present ? data.projectId.value : this.projectId,
      source: data.source.present ? data.source.value : this.source,
      sourceId: data.sourceId.present ? data.sourceId.value : this.sourceId,
      position: data.position.present ? data.position.value : this.position,
      charStart: data.charStart.present ? data.charStart.value : this.charStart,
      charEnd: data.charEnd.present ? data.charEnd.value : this.charEnd,
      version: data.version.present ? data.version.value : this.version,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('KnowledgeChunksTableData(')
          ..write('id: $id, ')
          ..write('projectId: $projectId, ')
          ..write('source: $source, ')
          ..write('sourceId: $sourceId, ')
          ..write('position: $position, ')
          ..write('charStart: $charStart, ')
          ..write('charEnd: $charEnd, ')
          ..write('version: $version, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    projectId,
    source,
    sourceId,
    position,
    charStart,
    charEnd,
    version,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is KnowledgeChunksTableData &&
          other.id == this.id &&
          other.projectId == this.projectId &&
          other.source == this.source &&
          other.sourceId == this.sourceId &&
          other.position == this.position &&
          other.charStart == this.charStart &&
          other.charEnd == this.charEnd &&
          other.version == this.version &&
          other.createdAt == this.createdAt);
}

class KnowledgeChunksTableCompanion
    extends UpdateCompanion<KnowledgeChunksTableData> {
  final Value<String> id;
  final Value<String> projectId;
  final Value<String> source;
  final Value<String> sourceId;
  final Value<int> position;
  final Value<int> charStart;
  final Value<int> charEnd;
  final Value<int> version;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const KnowledgeChunksTableCompanion({
    this.id = const Value.absent(),
    this.projectId = const Value.absent(),
    this.source = const Value.absent(),
    this.sourceId = const Value.absent(),
    this.position = const Value.absent(),
    this.charStart = const Value.absent(),
    this.charEnd = const Value.absent(),
    this.version = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  KnowledgeChunksTableCompanion.insert({
    required String id,
    required String projectId,
    required String source,
    required String sourceId,
    required int position,
    required int charStart,
    required int charEnd,
    required int version,
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       projectId = Value(projectId),
       source = Value(source),
       sourceId = Value(sourceId),
       position = Value(position),
       charStart = Value(charStart),
       charEnd = Value(charEnd),
       version = Value(version),
       createdAt = Value(createdAt);
  static Insertable<KnowledgeChunksTableData> custom({
    Expression<String>? id,
    Expression<String>? projectId,
    Expression<String>? source,
    Expression<String>? sourceId,
    Expression<int>? position,
    Expression<int>? charStart,
    Expression<int>? charEnd,
    Expression<int>? version,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (projectId != null) 'project_id': projectId,
      if (source != null) 'source': source,
      if (sourceId != null) 'source_id': sourceId,
      if (position != null) 'position': position,
      if (charStart != null) 'char_start': charStart,
      if (charEnd != null) 'char_end': charEnd,
      if (version != null) 'version': version,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  KnowledgeChunksTableCompanion copyWith({
    Value<String>? id,
    Value<String>? projectId,
    Value<String>? source,
    Value<String>? sourceId,
    Value<int>? position,
    Value<int>? charStart,
    Value<int>? charEnd,
    Value<int>? version,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return KnowledgeChunksTableCompanion(
      id: id ?? this.id,
      projectId: projectId ?? this.projectId,
      source: source ?? this.source,
      sourceId: sourceId ?? this.sourceId,
      position: position ?? this.position,
      charStart: charStart ?? this.charStart,
      charEnd: charEnd ?? this.charEnd,
      version: version ?? this.version,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (projectId.present) {
      map['project_id'] = Variable<String>(projectId.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (sourceId.present) {
      map['source_id'] = Variable<String>(sourceId.value);
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    if (charStart.present) {
      map['char_start'] = Variable<int>(charStart.value);
    }
    if (charEnd.present) {
      map['char_end'] = Variable<int>(charEnd.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
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
    return (StringBuffer('KnowledgeChunksTableCompanion(')
          ..write('id: $id, ')
          ..write('projectId: $projectId, ')
          ..write('source: $source, ')
          ..write('sourceId: $sourceId, ')
          ..write('position: $position, ')
          ..write('charStart: $charStart, ')
          ..write('charEnd: $charEnd, ')
          ..write('version: $version, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ConversationsTable conversations = $ConversationsTable(this);
  late final $LlmSettingsTableTable llmSettingsTable = $LlmSettingsTableTable(
    this,
  );
  late final $PipelinesTableTable pipelinesTable = $PipelinesTableTable(this);
  late final $PipelinePurposeTableTable pipelinePurposeTable =
      $PipelinePurposeTableTable(this);
  late final $KnowledgeChunksTableTable knowledgeChunksTable =
      $KnowledgeChunksTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    conversations,
    llmSettingsTable,
    pipelinesTable,
    pipelinePurposeTable,
    knowledgeChunksTable,
  ];
}

typedef $$ConversationsTableCreateCompanionBuilder =
    ConversationsCompanion Function({
      required String id,
      required String projectId,
      required String title,
      required String purpose,
      required String status,
      Value<bool> isArchived,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$ConversationsTableUpdateCompanionBuilder =
    ConversationsCompanion Function({
      Value<String> id,
      Value<String> projectId,
      Value<String> title,
      Value<String> purpose,
      Value<String> status,
      Value<bool> isArchived,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$ConversationsTableFilterComposer
    extends Composer<_$AppDatabase, $ConversationsTable> {
  $$ConversationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get projectId => $composableBuilder(
    column: $table.projectId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get purpose => $composableBuilder(
    column: $table.purpose,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ConversationsTableOrderingComposer
    extends Composer<_$AppDatabase, $ConversationsTable> {
  $$ConversationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get projectId => $composableBuilder(
    column: $table.projectId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get purpose => $composableBuilder(
    column: $table.purpose,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ConversationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ConversationsTable> {
  $$ConversationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get projectId =>
      $composableBuilder(column: $table.projectId, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get purpose =>
      $composableBuilder(column: $table.purpose, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$ConversationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ConversationsTable,
          Conversation,
          $$ConversationsTableFilterComposer,
          $$ConversationsTableOrderingComposer,
          $$ConversationsTableAnnotationComposer,
          $$ConversationsTableCreateCompanionBuilder,
          $$ConversationsTableUpdateCompanionBuilder,
          (
            Conversation,
            BaseReferences<_$AppDatabase, $ConversationsTable, Conversation>,
          ),
          Conversation,
          PrefetchHooks Function()
        > {
  $$ConversationsTableTableManager(_$AppDatabase db, $ConversationsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ConversationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ConversationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ConversationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> projectId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> purpose = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<bool> isArchived = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ConversationsCompanion(
                id: id,
                projectId: projectId,
                title: title,
                purpose: purpose,
                status: status,
                isArchived: isArchived,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String projectId,
                required String title,
                required String purpose,
                required String status,
                Value<bool> isArchived = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => ConversationsCompanion.insert(
                id: id,
                projectId: projectId,
                title: title,
                purpose: purpose,
                status: status,
                isArchived: isArchived,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ConversationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ConversationsTable,
      Conversation,
      $$ConversationsTableFilterComposer,
      $$ConversationsTableOrderingComposer,
      $$ConversationsTableAnnotationComposer,
      $$ConversationsTableCreateCompanionBuilder,
      $$ConversationsTableUpdateCompanionBuilder,
      (
        Conversation,
        BaseReferences<_$AppDatabase, $ConversationsTable, Conversation>,
      ),
      Conversation,
      PrefetchHooks Function()
    >;
typedef $$LlmSettingsTableTableCreateCompanionBuilder =
    LlmSettingsTableCompanion Function({
      Value<int> id,
      required String provider,
      required String model,
      Value<bool> streaming,
      required DateTime updatedAt,
    });
typedef $$LlmSettingsTableTableUpdateCompanionBuilder =
    LlmSettingsTableCompanion Function({
      Value<int> id,
      Value<String> provider,
      Value<String> model,
      Value<bool> streaming,
      Value<DateTime> updatedAt,
    });

class $$LlmSettingsTableTableFilterComposer
    extends Composer<_$AppDatabase, $LlmSettingsTableTable> {
  $$LlmSettingsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get provider => $composableBuilder(
    column: $table.provider,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get model => $composableBuilder(
    column: $table.model,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get streaming => $composableBuilder(
    column: $table.streaming,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LlmSettingsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $LlmSettingsTableTable> {
  $$LlmSettingsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get provider => $composableBuilder(
    column: $table.provider,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get model => $composableBuilder(
    column: $table.model,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get streaming => $composableBuilder(
    column: $table.streaming,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LlmSettingsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $LlmSettingsTableTable> {
  $$LlmSettingsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get provider =>
      $composableBuilder(column: $table.provider, builder: (column) => column);

  GeneratedColumn<String> get model =>
      $composableBuilder(column: $table.model, builder: (column) => column);

  GeneratedColumn<bool> get streaming =>
      $composableBuilder(column: $table.streaming, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$LlmSettingsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LlmSettingsTableTable,
          LlmSettingsTableData,
          $$LlmSettingsTableTableFilterComposer,
          $$LlmSettingsTableTableOrderingComposer,
          $$LlmSettingsTableTableAnnotationComposer,
          $$LlmSettingsTableTableCreateCompanionBuilder,
          $$LlmSettingsTableTableUpdateCompanionBuilder,
          (
            LlmSettingsTableData,
            BaseReferences<
              _$AppDatabase,
              $LlmSettingsTableTable,
              LlmSettingsTableData
            >,
          ),
          LlmSettingsTableData,
          PrefetchHooks Function()
        > {
  $$LlmSettingsTableTableTableManager(
    _$AppDatabase db,
    $LlmSettingsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LlmSettingsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LlmSettingsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LlmSettingsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> provider = const Value.absent(),
                Value<String> model = const Value.absent(),
                Value<bool> streaming = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => LlmSettingsTableCompanion(
                id: id,
                provider: provider,
                model: model,
                streaming: streaming,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String provider,
                required String model,
                Value<bool> streaming = const Value.absent(),
                required DateTime updatedAt,
              }) => LlmSettingsTableCompanion.insert(
                id: id,
                provider: provider,
                model: model,
                streaming: streaming,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LlmSettingsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LlmSettingsTableTable,
      LlmSettingsTableData,
      $$LlmSettingsTableTableFilterComposer,
      $$LlmSettingsTableTableOrderingComposer,
      $$LlmSettingsTableTableAnnotationComposer,
      $$LlmSettingsTableTableCreateCompanionBuilder,
      $$LlmSettingsTableTableUpdateCompanionBuilder,
      (
        LlmSettingsTableData,
        BaseReferences<
          _$AppDatabase,
          $LlmSettingsTableTable,
          LlmSettingsTableData
        >,
      ),
      LlmSettingsTableData,
      PrefetchHooks Function()
    >;
typedef $$PipelinesTableTableCreateCompanionBuilder =
    PipelinesTableCompanion Function({
      required String id,
      required String name,
      required String stepIds,
      Value<bool> enabled,
      Value<int> rowid,
    });
typedef $$PipelinesTableTableUpdateCompanionBuilder =
    PipelinesTableCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> stepIds,
      Value<bool> enabled,
      Value<int> rowid,
    });

class $$PipelinesTableTableFilterComposer
    extends Composer<_$AppDatabase, $PipelinesTableTable> {
  $$PipelinesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get stepIds => $composableBuilder(
    column: $table.stepIds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get enabled => $composableBuilder(
    column: $table.enabled,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PipelinesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $PipelinesTableTable> {
  $$PipelinesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get stepIds => $composableBuilder(
    column: $table.stepIds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get enabled => $composableBuilder(
    column: $table.enabled,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PipelinesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $PipelinesTableTable> {
  $$PipelinesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get stepIds =>
      $composableBuilder(column: $table.stepIds, builder: (column) => column);

  GeneratedColumn<bool> get enabled =>
      $composableBuilder(column: $table.enabled, builder: (column) => column);
}

class $$PipelinesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PipelinesTableTable,
          PipelinesTableData,
          $$PipelinesTableTableFilterComposer,
          $$PipelinesTableTableOrderingComposer,
          $$PipelinesTableTableAnnotationComposer,
          $$PipelinesTableTableCreateCompanionBuilder,
          $$PipelinesTableTableUpdateCompanionBuilder,
          (
            PipelinesTableData,
            BaseReferences<
              _$AppDatabase,
              $PipelinesTableTable,
              PipelinesTableData
            >,
          ),
          PipelinesTableData,
          PrefetchHooks Function()
        > {
  $$PipelinesTableTableTableManager(
    _$AppDatabase db,
    $PipelinesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PipelinesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PipelinesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PipelinesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> stepIds = const Value.absent(),
                Value<bool> enabled = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PipelinesTableCompanion(
                id: id,
                name: name,
                stepIds: stepIds,
                enabled: enabled,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String stepIds,
                Value<bool> enabled = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PipelinesTableCompanion.insert(
                id: id,
                name: name,
                stepIds: stepIds,
                enabled: enabled,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PipelinesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PipelinesTableTable,
      PipelinesTableData,
      $$PipelinesTableTableFilterComposer,
      $$PipelinesTableTableOrderingComposer,
      $$PipelinesTableTableAnnotationComposer,
      $$PipelinesTableTableCreateCompanionBuilder,
      $$PipelinesTableTableUpdateCompanionBuilder,
      (
        PipelinesTableData,
        BaseReferences<_$AppDatabase, $PipelinesTableTable, PipelinesTableData>,
      ),
      PipelinesTableData,
      PrefetchHooks Function()
    >;
typedef $$PipelinePurposeTableTableCreateCompanionBuilder =
    PipelinePurposeTableCompanion Function({
      required String purpose,
      required String pipelineId,
      Value<int> rowid,
    });
typedef $$PipelinePurposeTableTableUpdateCompanionBuilder =
    PipelinePurposeTableCompanion Function({
      Value<String> purpose,
      Value<String> pipelineId,
      Value<int> rowid,
    });

class $$PipelinePurposeTableTableFilterComposer
    extends Composer<_$AppDatabase, $PipelinePurposeTableTable> {
  $$PipelinePurposeTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get purpose => $composableBuilder(
    column: $table.purpose,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pipelineId => $composableBuilder(
    column: $table.pipelineId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PipelinePurposeTableTableOrderingComposer
    extends Composer<_$AppDatabase, $PipelinePurposeTableTable> {
  $$PipelinePurposeTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get purpose => $composableBuilder(
    column: $table.purpose,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pipelineId => $composableBuilder(
    column: $table.pipelineId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PipelinePurposeTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $PipelinePurposeTableTable> {
  $$PipelinePurposeTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get purpose =>
      $composableBuilder(column: $table.purpose, builder: (column) => column);

  GeneratedColumn<String> get pipelineId => $composableBuilder(
    column: $table.pipelineId,
    builder: (column) => column,
  );
}

class $$PipelinePurposeTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PipelinePurposeTableTable,
          PipelinePurposeTableData,
          $$PipelinePurposeTableTableFilterComposer,
          $$PipelinePurposeTableTableOrderingComposer,
          $$PipelinePurposeTableTableAnnotationComposer,
          $$PipelinePurposeTableTableCreateCompanionBuilder,
          $$PipelinePurposeTableTableUpdateCompanionBuilder,
          (
            PipelinePurposeTableData,
            BaseReferences<
              _$AppDatabase,
              $PipelinePurposeTableTable,
              PipelinePurposeTableData
            >,
          ),
          PipelinePurposeTableData,
          PrefetchHooks Function()
        > {
  $$PipelinePurposeTableTableTableManager(
    _$AppDatabase db,
    $PipelinePurposeTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PipelinePurposeTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PipelinePurposeTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$PipelinePurposeTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> purpose = const Value.absent(),
                Value<String> pipelineId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PipelinePurposeTableCompanion(
                purpose: purpose,
                pipelineId: pipelineId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String purpose,
                required String pipelineId,
                Value<int> rowid = const Value.absent(),
              }) => PipelinePurposeTableCompanion.insert(
                purpose: purpose,
                pipelineId: pipelineId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PipelinePurposeTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PipelinePurposeTableTable,
      PipelinePurposeTableData,
      $$PipelinePurposeTableTableFilterComposer,
      $$PipelinePurposeTableTableOrderingComposer,
      $$PipelinePurposeTableTableAnnotationComposer,
      $$PipelinePurposeTableTableCreateCompanionBuilder,
      $$PipelinePurposeTableTableUpdateCompanionBuilder,
      (
        PipelinePurposeTableData,
        BaseReferences<
          _$AppDatabase,
          $PipelinePurposeTableTable,
          PipelinePurposeTableData
        >,
      ),
      PipelinePurposeTableData,
      PrefetchHooks Function()
    >;
typedef $$KnowledgeChunksTableTableCreateCompanionBuilder =
    KnowledgeChunksTableCompanion Function({
      required String id,
      required String projectId,
      required String source,
      required String sourceId,
      required int position,
      required int charStart,
      required int charEnd,
      required int version,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$KnowledgeChunksTableTableUpdateCompanionBuilder =
    KnowledgeChunksTableCompanion Function({
      Value<String> id,
      Value<String> projectId,
      Value<String> source,
      Value<String> sourceId,
      Value<int> position,
      Value<int> charStart,
      Value<int> charEnd,
      Value<int> version,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$KnowledgeChunksTableTableFilterComposer
    extends Composer<_$AppDatabase, $KnowledgeChunksTableTable> {
  $$KnowledgeChunksTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get projectId => $composableBuilder(
    column: $table.projectId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceId => $composableBuilder(
    column: $table.sourceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get charStart => $composableBuilder(
    column: $table.charStart,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get charEnd => $composableBuilder(
    column: $table.charEnd,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$KnowledgeChunksTableTableOrderingComposer
    extends Composer<_$AppDatabase, $KnowledgeChunksTableTable> {
  $$KnowledgeChunksTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get projectId => $composableBuilder(
    column: $table.projectId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceId => $composableBuilder(
    column: $table.sourceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get charStart => $composableBuilder(
    column: $table.charStart,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get charEnd => $composableBuilder(
    column: $table.charEnd,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$KnowledgeChunksTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $KnowledgeChunksTableTable> {
  $$KnowledgeChunksTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get projectId =>
      $composableBuilder(column: $table.projectId, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<String> get sourceId =>
      $composableBuilder(column: $table.sourceId, builder: (column) => column);

  GeneratedColumn<int> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  GeneratedColumn<int> get charStart =>
      $composableBuilder(column: $table.charStart, builder: (column) => column);

  GeneratedColumn<int> get charEnd =>
      $composableBuilder(column: $table.charEnd, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$KnowledgeChunksTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $KnowledgeChunksTableTable,
          KnowledgeChunksTableData,
          $$KnowledgeChunksTableTableFilterComposer,
          $$KnowledgeChunksTableTableOrderingComposer,
          $$KnowledgeChunksTableTableAnnotationComposer,
          $$KnowledgeChunksTableTableCreateCompanionBuilder,
          $$KnowledgeChunksTableTableUpdateCompanionBuilder,
          (
            KnowledgeChunksTableData,
            BaseReferences<
              _$AppDatabase,
              $KnowledgeChunksTableTable,
              KnowledgeChunksTableData
            >,
          ),
          KnowledgeChunksTableData,
          PrefetchHooks Function()
        > {
  $$KnowledgeChunksTableTableTableManager(
    _$AppDatabase db,
    $KnowledgeChunksTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$KnowledgeChunksTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$KnowledgeChunksTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$KnowledgeChunksTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> projectId = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<String> sourceId = const Value.absent(),
                Value<int> position = const Value.absent(),
                Value<int> charStart = const Value.absent(),
                Value<int> charEnd = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => KnowledgeChunksTableCompanion(
                id: id,
                projectId: projectId,
                source: source,
                sourceId: sourceId,
                position: position,
                charStart: charStart,
                charEnd: charEnd,
                version: version,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String projectId,
                required String source,
                required String sourceId,
                required int position,
                required int charStart,
                required int charEnd,
                required int version,
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => KnowledgeChunksTableCompanion.insert(
                id: id,
                projectId: projectId,
                source: source,
                sourceId: sourceId,
                position: position,
                charStart: charStart,
                charEnd: charEnd,
                version: version,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$KnowledgeChunksTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $KnowledgeChunksTableTable,
      KnowledgeChunksTableData,
      $$KnowledgeChunksTableTableFilterComposer,
      $$KnowledgeChunksTableTableOrderingComposer,
      $$KnowledgeChunksTableTableAnnotationComposer,
      $$KnowledgeChunksTableTableCreateCompanionBuilder,
      $$KnowledgeChunksTableTableUpdateCompanionBuilder,
      (
        KnowledgeChunksTableData,
        BaseReferences<
          _$AppDatabase,
          $KnowledgeChunksTableTable,
          KnowledgeChunksTableData
        >,
      ),
      KnowledgeChunksTableData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ConversationsTableTableManager get conversations =>
      $$ConversationsTableTableManager(_db, _db.conversations);
  $$LlmSettingsTableTableTableManager get llmSettingsTable =>
      $$LlmSettingsTableTableTableManager(_db, _db.llmSettingsTable);
  $$PipelinesTableTableTableManager get pipelinesTable =>
      $$PipelinesTableTableTableManager(_db, _db.pipelinesTable);
  $$PipelinePurposeTableTableTableManager get pipelinePurposeTable =>
      $$PipelinePurposeTableTableTableManager(_db, _db.pipelinePurposeTable);
  $$KnowledgeChunksTableTableTableManager get knowledgeChunksTable =>
      $$KnowledgeChunksTableTableTableManager(_db, _db.knowledgeChunksTable);
}
