import 'package:flutter_riverpod/flutter_riverpod.dart';

class Parameter {
  final String name;
  final String company;

  Parameter({
    required this.name,
    required this.company,
});
}

final familyModifierProvider = FutureProvider.family<List<int>, int>((ref, data) async {
  await Future.delayed(Duration(seconds: 2),);

  return List.generate(5, (index) => index * data);
});