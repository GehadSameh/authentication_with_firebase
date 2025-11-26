
class UserState {}

final class UserInitial extends UserState {}
final class SignUpSucessState extends UserState {}
final class PickedImageState extends UserState{}
final class UploadImageState extends UserState{
  

}

class SignUpfailureState extends UserState {
  final String errorMessage;

  SignUpfailureState({required this.errorMessage});
}
class SignUpLoadingState extends UserState {}
final class SignInSuccessState extends UserState{}
final class SignInLoadingState extends UserState{}
final class SignInfailureState extends UserState {
  final String errorMessage;

  SignInfailureState({required this.errorMessage});
}
final class SignOutLoadingState extends UserState{}
final class  SignoutState extends UserState{}
final class SignOutfailureState extends UserState {
  final String errorMessage;

  SignOutfailureState({required this.errorMessage});
}
final class LoadingImageState extends UserState{}
final class SuccessImageState extends UserState{}
class UserEmailVerificationLoadingState extends UserState {}
class UserEmailVerificationSuccessState extends UserState {}
class UserEmailVerificationFailureState extends UserState {
  final String message;
  UserEmailVerificationFailureState(this.message);
}class ResetPasswordSuccessState extends UserState {}
class ResetPasswordLoadingState extends UserState {}
class ResetPasswordfailureState extends UserState {
  final String errorMessage;

  ResetPasswordfailureState({required this.errorMessage});
}
