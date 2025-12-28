import 'dart:convert';
import 'package:flutter/services.dart';
import '../dsl/purpose_definition.dart';
import '../dsl/purpose_constraints.dart';
import '../validation/purpose_validator.dart';
import '../../utils/logger.dart';

class PurposeLoader {
  static Future<PurposeDefinition> loadFromAsset(String path) async {
    appLogger.i('Loading purpose from $path');

    final rawContent = await rootBundle.loadString(path);
    final map = jsonDecode(rawContent) as Map<String, dynamic>;

    PurposeValidator.validate(map);

    final constraints = map['constraints'] as Map<String, dynamic>;

    return PurposeDefinition(
      key: map['key'],
      name: map['name'],
      description: map['description'],
      systemDirective: map['system_directive'],
      constraints: PurposeConstraints(
        allowOffTopic: constraints['allow_off_topic'],
        maxContextTokens: constraints['max_context_tokens'],
        tone: constraints['tone'],
        forbiddenTopics:
            List<String>.from(constraints['forbidden_topics'] ?? []),
      ),
    );
  }
}
