import 'package:aitelier/core/database/app_database.dart';

class VssCapabilityDetector {
  final AppDatabase db;

  VssCapabilityDetector(this.db);

  Future<bool> isAvailable() async {
    try {
      await db.customSelect(
        "SELECT 1 FROM pragma_module_list WHERE name = 'vss0'",
      ).getSingle();
      return true;
    } catch (_) {
      return false;
    }
  }
}
