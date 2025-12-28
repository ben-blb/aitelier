import 'purpose_constraints.dart';

class PurposeDefinition {
  final String key;
  final String name;
  final String description;
  final PurposeConstraints constraints;
  final String systemDirective;

  PurposeDefinition({
    required this.key,
    required this.name,
    required this.description,
    required this.constraints,
    required this.systemDirective,
  });
}
