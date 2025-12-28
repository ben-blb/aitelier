import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../domain/services/secret_storage.dart';

class SecureStorageAdapter implements SecretStorage {
  final FlutterSecureStorage _storage;

  SecureStorageAdapter()
      : _storage = const FlutterSecureStorage();

  @override
  Future<void> write({
    required String key,
    required String value,
  }) {
    return _storage.write(key: key, value: value);
  }

  @override
  Future<String?> read({
    required String key,
  }) {
    return _storage.read(key: key);
  }

  @override
  Future<void> delete({
    required String key,
  }) {
    return _storage.delete(key: key);
  }
}
