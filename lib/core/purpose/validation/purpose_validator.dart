import '../dsl/purpose_schema.dart';
import '../../utils/logger.dart';

class PurposeValidator {
  static void validate(Map<String, dynamic> raw) {
    for (final field in PurposeSchema.requiredFields) {
      if (!raw.containsKey(field)) {
        appLogger.e('Purpose validation failed: missing $field');
        throw Exception('Invalid purpose definition: missing $field');
      }
    }

    if (raw['key'].toString().isEmpty) {
      throw Exception('Purpose key cannot be empty');
    }

    appLogger.i('Purpose ${raw['key']} validated successfully');
  }
}
