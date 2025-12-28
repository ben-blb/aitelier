import '../dsl/purpose_definition.dart';
import '../../utils/logger.dart';

class PurposeRegistry {
  final Map<String, PurposeDefinition> _purposes = {};

  void register(PurposeDefinition purpose) {
    appLogger.i('Registering purpose ${purpose.key}');
    _purposes[purpose.key] = purpose;
  }

  PurposeDefinition get(String key) {
    final purpose = _purposes[key];
    if (purpose == null) {
      appLogger.e('Unknown purpose requested: $key');
      throw Exception('Unknown purpose: $key');
    }
    return purpose;
  }

  List<PurposeDefinition> listAll() {
    return _purposes.values.toList();
  }
}
