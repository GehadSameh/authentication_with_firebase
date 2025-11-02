 class UserState {}

final class UserInitial extends UserState {}
final class SignUpSucessState extends UserState {}
final class PickedImageState extends UserState{}
final class UploadImageState extends UserState{
  final String imageUrl;

  UploadImageState({required this.imageUrl});

}

class SignUpfailureState extends UserState {
  final String errorMessage;

  SignUpfailureState({required this.errorMessage});
}
class SignUpLoadingState extends UserState {}
