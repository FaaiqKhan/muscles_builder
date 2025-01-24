import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:get_it/get_it.dart';

class UsecasesDependencyInjectionContainer {
  UsecasesDependencyInjectionContainer._();

  static void init() {
    GetIt.I.registerSingleton(
      UserAuthenticationUseCase(
        UserAuthenticationRepositoryImpl(),
      ),
    );
  }
}
