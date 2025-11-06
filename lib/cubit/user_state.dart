
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
final class  SignoutState extends UserState{}
final class SignOutfailureState extends UserState {
  final String errorMessage;

  SignOutfailureState({required this.errorMessage});
}
final class LoadingState extends UserState{}
