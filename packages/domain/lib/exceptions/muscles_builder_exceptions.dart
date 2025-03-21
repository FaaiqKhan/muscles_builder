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

class EmailAlreadyExistException implements MusclesBuilderExceptions {
  @override
  String get message => "Email already exist";
}

class GeneralException implements MusclesBuilderExceptions {
  @override
  String get message => "Ops! something went wrong";
}

class WeekPasswordException implements MusclesBuilderExceptions {
  @override
  String get message => "Week password";
}

class UserTokenExpiredException implements MusclesBuilderExceptions {
  @override
  String get message => "User token expires, please contact your provider";
}

class NetworkRequestFailedException implements MusclesBuilderExceptions {
  @override
  String get message => "Network request failed, please check your internet";
}