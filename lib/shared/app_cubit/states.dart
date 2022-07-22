abstract class AppStates{}

class AppInitialState extends AppStates{
}

class AppChangeStateMode extends AppStates{

}

class GetUSerLoadingState extends AppStates{}
class GetUSerSuccessState extends AppStates{}
class GetUSerErrorState extends AppStates{
  final String error;

  GetUSerErrorState(this.error);
}
class USerSignOutSuccessState extends AppStates{}

class NewPatientAddedSuccessState extends AppStates{}
class NewPatientCreatedSuccessState extends AppStates{}
class NewPatientCreatedErrorState extends AppStates{
  final String error;

  NewPatientCreatedErrorState(this.error);
}
class GetPatientsState extends AppStates{}
class GenderStateChanged extends AppStates{}
class NewXrayAddedSuccessState extends AppStates{}
class NewXrayAddedErrorState extends AppStates{
  final String error;

  NewXrayAddedErrorState(this.error);
}
class PatientImagePickedSuccessState extends AppStates{}
class PatientImagePickedErrorState extends AppStates{}
class StartPatientImageUploadState extends AppStates{}
class PatientImageClearedState extends AppStates{}
class PatientImageUploadSuccessState extends AppStates{}
class PatientImageUploadErrorState extends AppStates{
  final String error;

  PatientImageUploadErrorState(this.error);
}
class UserProfileImageUploadSuccessState extends AppStates{}
class UserProfileImageUploadErrorState extends AppStates{
  final String error;

  UserProfileImageUploadErrorState(this.error);
}
class XrayImageUploadSuccessState extends AppStates{}
class XrayImageUploadErrorState extends AppStates{
  final String error;

  XrayImageUploadErrorState(this.error);
}
class SearchNameChangeState extends AppStates{}
class ChangeImportantSuccessState extends AppStates{}
class ChangeImportantErrorState extends AppStates{
  final String error;

  ChangeImportantErrorState(this.error);
}
