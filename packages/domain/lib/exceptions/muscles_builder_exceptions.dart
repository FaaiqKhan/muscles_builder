abstract class MusclesBuilderExceptions implements Exception {
  MusclesBuilderExceptions(this.message);

  final String message;
}

class UserNotFoundException implements MusclesBuilderExceptions {
  @override
  String get message => "User not found";
}

class WrongPasswordException implements MusclesBuilderExceptions {
  @override
  String get message => "Wrong password";
}

class InvalidCredentialsException implements MusclesBuilderExceptions {
  @override
  String get message => "Invalid credentials";
}

class EmailAlreadyExistException implements MusclesBuilderExceptions {
  @override
  String get message => "Email already exist";
}

class GeneralException implements MusclesBuilderExceptions {
  @override
  String get message => "Ops! something went wrong";
}