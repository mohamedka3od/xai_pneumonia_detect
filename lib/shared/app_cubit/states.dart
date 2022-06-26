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

