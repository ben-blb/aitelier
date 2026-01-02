import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/services/secret_storage.dart';
import '../../infrastructure/security/secure_storage_adapter.dart';

final secretStorageProvider = Provider<SecretStorage>((ref) {
  return SecureStorageAdapter();
});

final saveOpenAIApiKeyProvider = Provider<Future<void> Function(String)>((ref) {// TODO: Create actual fucking ui
  final storage = ref.read(secretStorageProvider);

  return (String key) async {
    await storage.write(
      key: 'openai_api_key',
      value: key,
    );
  };
});
