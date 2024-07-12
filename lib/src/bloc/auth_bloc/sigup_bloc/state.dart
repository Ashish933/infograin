
import 'package:flutter/cupertino.dart';

@immutable
sealed class SignUpState {}

final class SignUpInitial extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpSuccess extends SignUpState{

}

class SignUpFailure extends SignUpState{
  String? message ;
  SignUpFailure(this.message);
}





