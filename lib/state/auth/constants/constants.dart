import 'package:flutter/foundation.dart' show immutable;

@immutable
class Constants {
  static const accountExistsWithDifferentCredential =
      'account-exists-with-different-credential';
  static const googleCom = 'google.com';
  static const emailScope = 'email';

  /*
   The Constants class is a utility class that only contains a set of constant properties.
   To prevent the class from being instantiated, a private constructor const Constants._();
   is defined within the class. This means that no object of the class can be created from outside the class.

   In other words, by making the constructor private, you prevent users of the class from
   accidentally creating an instance of the Constants class, which would be pointless since
   all its properties are constants and can be accessed directly without creating an instance.
   */
  const Constants._();
}
