import 'dart:io';

abstract class UserTabStates {}

class UserTabInitialState extends UserTabStates {}

class UserTabLoadingState extends UserTabStates {}

class UserImageUpdatedState extends UserTabStates {
  final File image;
  UserImageUpdatedState({required this.image});
}

class UserTabErrorState extends UserTabStates {
  final String errorMessage;
  UserTabErrorState({required this.errorMessage});
}
class UserDataLoadedState extends UserTabStates {}