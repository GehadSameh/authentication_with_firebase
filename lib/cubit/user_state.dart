 class UserState {}

final class UserInitial extends UserState {}
final class SignUpSucessState extends UserState {}
class SignUpfailureState extends UserState {
  final String errorMessage;

  SignUpfailureState({required this.errorMessage});
}
class SignUpLoadingState extends UserState {}
