import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/src/framework.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'code_generation_provider.g.dart';

// 1) 어떤 Provider 를 사용할지 결정할 고민 할 필요 없도록
// Provider, FutureProvider, StreamProvider(x)
// StateNotifierProvider

final _testProvider = Provider<String>((ref) => "Hello Code Generation");

@riverpod
String gState(GStateRef ref) {
  return "Hello Code Generation";
}

@riverpod
Future<int> gStateFuture(GStateFutureRef ref) async {
  await Future.delayed(Duration(seconds: 3));

  return 10;
}

@Riverpod(
  // 기본값은 false
  // <-> 없애지 말고 계속 살게 둬라
  keepAlive: true,
)
Future<int> gStateFuture2(GStateFuture2Ref ref) async {
  await Future.delayed(Duration(seconds: 3));

  return 10;
}

// 2) parameter > Family 파라미터를 일반 함수처럼 사용할 수 있도록 -> code_generation 이 나온 것!
class Parameter {
  final int number1;
  final int number2;

  Parameter({
    required this.number1,
    required this.number2,
  });
}

final _testFamilyProvider = Provider.family<int, Parameter>(
  (ref, Parameter) => Parameter.number1 * Parameter.number2,
);

@riverpod
int gStateMuliply(GStateMuliplyRef ref,
    {required int number1, required int number2}) {
  return number1 * number2;
}

@riverpod
class GStateNotifier extends _$GStateNotifier {

  // 초기상태 값을 지정해준다.
  @override
  int build() {
    return 0;
  }

  increment() {
    state++;
  }

  decrement() {
    state--;
  }

}
