import 'package:aitelier/infrastructure/dependencies.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final pipelinesProvider =
    FutureProvider((ref) => ref.read(pipelineRepositoryProvider).getAll());
