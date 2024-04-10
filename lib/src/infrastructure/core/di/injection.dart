import 'package:get_it/get_it.dart';

final class Injection {
  Injection._();

  static final GetIt _getIt = GetIt.instance;

  static factory<T extends Object>(
    FactoryFunc<T> factoryFunc, {
    String? instanceName,
  }) {
    _getIt.registerFactory(
      factoryFunc,
      instanceName: instanceName,
    );
  }

  static single<T extends Object>(
    T instance, {
    String? instanceName,
    bool? signalsReady,
    DisposingFunc<T>? dispose,
  }) {
    _getIt.registerSingleton(
      instance,
      dispose: dispose,
      instanceName: instanceName,
      signalsReady: signalsReady,
    );
  }

  static T get<T extends Object>({
    dynamic param1,
    dynamic param2,
    String? instanceName,
    Type? type,
  }) {
    return _getIt.get(
      param1: param1,
      param2: param2,
      instanceName: instanceName,
      type: type,
    );
  }
}
