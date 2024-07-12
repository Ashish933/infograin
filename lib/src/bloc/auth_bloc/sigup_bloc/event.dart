
import 'package:flutter/cupertino.dart';

import '../../../models/request/signup_request_model.dart';

@immutable
sealed class SignUpEvent {}

class SignUpButtonPressed extends SignUpEvent {
  final SignUpRequestModel request;
  SignUpButtonPressed({required this.request});
}