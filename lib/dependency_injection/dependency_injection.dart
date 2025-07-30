import 'package:domain/domain.dart';
import 'package:domain/repositories/user_profile_repository.dart';
import 'package:get_it/get_it.dart';

class UsecasesDependencyInjectionContainer {
  UsecasesDependencyInjectionContainer._();

  static void init() {
    GetIt.I.registerSingleton(
      UserAuthenticationUseCase(
        UserAuthenticationRepository(),
      ),
    );
    GetIt.I.registerSingleton(
      UserProfileUsecase(
        UserProfileRepository(),
      ),
    );
  }
}
