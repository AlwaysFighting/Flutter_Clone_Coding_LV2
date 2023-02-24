import 'package:flutter/material.dart';
import 'package:flutter_river_project/layout/default_layout.dart';
import 'package:flutter_river_project/riverpod/code_generation_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CodeGenerationScreen extends ConsumerWidget {
  const CodeGenerationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print("build");

    final state1 = ref.watch(gStateProvider);
    final state2 = ref.watch(gStateFutureProvider);
    final state3 = ref.watch(gStateFuture2Provider);
    final state4 = ref.watch(gStateMuliplyProvider(
      number1: 10,
      number2: 20,
    ));

    return DefaultLayout(
      title: "CodeGenerationScreen",
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('State1 : $state1'),
            state2.when(
              data: (data) {
                return Text(
                  'State2 : $data',
                  textAlign: TextAlign.center,
                );
              },
              error: (err, stack) => Text(
                err.toString(),
              ),
              loading: () => Center(child: CircularProgressIndicator()),
            ),
            state3.when(
              data: (data) {
                return Text(
                  'State3 : $data',
                  textAlign: TextAlign.center,
                );
              },
              error: (err, stack) => Text(
                err.toString(),
              ),
              loading: () => Center(child: CircularProgressIndicator()),
            ),
            Text('State4 : $state4'),
            Consumer(
              builder: (context, ref, child) {
                print("builder build");
                final state5 = ref.watch(gStateNotifierProvider);
                return Row(
                  children: [
                    Text('State5 : $state5'),
                    if(child != null) child,
                  ],
                );
              },
              child: Text('Hello'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      ref.read(gStateNotifierProvider.notifier).increment();
                    },
                    child: Text("+")),
                SizedBox(width: 10),
                ElevatedButton(
                    onPressed: () {
                      ref.read(gStateNotifierProvider.notifier).decrement();
                    },
                    child: Text("-")),
              ],
            ),
            // invalidate() => State 를 유효하지 않게 해서 초기 상태로 되돌린다는 의미.
            ElevatedButton(
                onPressed: () {
                  ref.invalidate(gStateNotifierProvider);
                },
                child: Text("Invalidate")),
          ],
        ),
      ),
    );
  }
}

class _StateFiveWidget extends ConsumerWidget {
  const _StateFiveWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state5 = ref.watch(gStateNotifierProvider);
    return Text('State5 : $state5');
  }
}
