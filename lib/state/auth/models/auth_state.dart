import 'package:flutter/foundation.dart' show immutable;
import 'package:instagram_clone/state/auth/models/auth_result.dart';
import 'package:instagram_clone/state/posts/typedefs/user_id.dart';

@immutable
class AuthState {
  const AuthState({
    required this.result,
    required this.isLoading,
    required this.userId,
  });

  final AuthResult? result;
  final bool isLoading;
  final UserId? userId;

  //Logged out state
  //This method sets up the 3 properties accordingly to an unknown state
  const AuthState.unknown()
      : result = null,
        isLoading = false,
        userId = null;

  //Loading state
  AuthState copiedWithIsLoading(bool isLoading) => AuthState(
        result: result,
        isLoading: isLoading,
        userId: userId,
      );

  @override
  bool operator ==(covariant AuthState other) =>
      identical(this, other) ||
      (result == other.result &&
          isLoading == other.isLoading &&
          userId == other.userId);

  @override
  int get hashCode => Object.hash(
        result,
        isLoading,
        userId,
      );
}
