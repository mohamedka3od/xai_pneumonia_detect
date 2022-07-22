import '../../../models/login_model.dart';

abstract class LoginStates {}

class LoginInitialState extends LoginStates {}
class LoginLoadingState extends LoginStates {}
class LoginSuccessState extends LoginStates {
   final String uId;
   LoginSuccessState(this.uId);

}
class LoginErrorState extends LoginStates {
  final String error;
  LoginErrorState(this.error);
}
class LoginChangePasswordVisibilityState extends LoginStates {}
class GoogleLoginLoadingState extends LoginStates {}
class GoogleLoginSuccessState extends LoginStates {
  final String uId;
  GoogleLoginSuccessState(this.uId);

}
class GoogleLoginErrorState extends LoginStates {
  final String error;
  GoogleLoginErrorState(this.error);
}