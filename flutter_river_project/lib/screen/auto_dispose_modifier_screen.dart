import 'package:flutter/material.dart';
import 'package:flutter_river_project/layout/default_layout.dart';
import 'package:flutter_river_project/riverpod/auto_dispose_modifier_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AutoDisposeModifierScreen extends ConsumerWidget {
  const AutoDisposeModifierScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(autoDisposeModifierProvider);

    return DefaultLayout(
      title: "AutoDisposeModifierScreen",
      body: Center(
        child: state.when(
            data: (data) => Text(data.toString()),
            error: (err, stack) => Text(err.toString()),
            loading: () => CircularProgressIndicator(),
      ),
    ));
  }
}
