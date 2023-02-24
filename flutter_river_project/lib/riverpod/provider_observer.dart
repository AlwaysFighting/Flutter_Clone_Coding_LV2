import 'package:flutter_riverpod/flutter_riverpod.dart';

class Logger extends ProviderObserver {
  // 어떤 Provider든 업데이트 됐을 때 함수가 무조건 호출된다.
  @override
  void didUpdateProvider(ProviderBase provider, Object? previousValue,
      Object? newValue, ProviderContainer container) {
    // TODO: implement didUpdateProvider
    super.didUpdateProvider(provider, previousValue, newValue, container);
    print(
        '[Provider Updated] provider : $provider / pv : $previousValue / nv : $newValue');
  }

  // Provider 가 어떤 값을 추가했을 때 호출된다.
  @override
  void didAddProvider(ProviderBase provider, Object? value, ProviderContainer container) {
    // TODO: implement didAddProvider
    super.didAddProvider(provider, value, container);
    print(
        '[Provider Added] provider : $provider / pv : $value');
  }

  // Provider 가 어떤 값을 삭제했을 때 호출된다.
  @override
  void didDisposeProvider(ProviderBase provider, ProviderContainer containers) {
    // TODO: implement didDisposeProvider
    super.didDisposeProvider(provider, containers);
    print(
        '[Provider Disposed] provider : $provider');
  }
}
