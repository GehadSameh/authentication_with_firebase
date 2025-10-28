 class UserState {}

final class UserInitial extends UserState {}
final class SignUpSucessState extends UserState {}
final class PickedImageState extends UserState{}
class SignUpfailureState extends UserState {
  final String errorMessage;

  SignUpfailureState({required this.errorMessage});
}
class SignUpLoadingState extends UserState {}
