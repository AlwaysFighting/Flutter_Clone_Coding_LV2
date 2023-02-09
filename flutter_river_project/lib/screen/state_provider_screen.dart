import 'package:flutter/material.dart';
import 'package:flutter_river_project/layout/default_layout.dart';
import 'package:flutter_river_project/riverpod/state_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StateProviderScreen extends ConsumerWidget {
  const StateProviderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(numverProvider);

    return DefaultLayout(
      title: 'StateProviderScreen',
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              provider.toString(),
            ),
            ElevatedButton(
                onPressed: () {
                  ref
                      .read(numverProvider.notifier)
                      .update((state) => state + 1);
                },
                child: Text('UP')),
            ElevatedButton(
                onPressed: () {
                  ref
                      .read(numverProvider.notifier).state =
                      ref.read(numverProvider.notifier).state - 1;
                },
                child: Text('Down')),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => _NextScreen()),
                  );
                },
                child: Text('_NextScreen'))
          ],
        ),
      ),
    );
  }
}

class _NextScreen extends ConsumerWidget {
  const _NextScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(numverProvider);

    return DefaultLayout(
      title: 'StateProviderScreen',
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              provider.toString(),
            ),
            ElevatedButton(
                onPressed: () {
                  ref
                      .read(numverProvider.notifier)
                      .update((state) => state + 1);
                },
                child: Text('UP'))
          ],
        ),
      ),
    );
  }
}
