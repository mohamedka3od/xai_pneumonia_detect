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
class NewPatientAddedSuccessState extends AppStates{}
