class SignupResponseModel {
  int status;
  bool success;
  String message;
  Result result;

  SignupResponseModel({
    required this.status,
    required this.success,
    required this.message,
    required this.result,
  });

}

class Result {
  int id;
  String firstName;
  String lastName;
  String countryCode;
  String phoneNumber;
  String email;
  dynamic status;
  String profilePic;
  String deviceToken;
  String deviceType;
  String country;
  String currency;
  String accessToken;
  String tokenType;
  String bankAcount;
  List<dynamic> loginActivity;
  String kyc;
  String wallet;

  Result({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.countryCode,
    required this.phoneNumber,
    required this.email,
    required this.status,
    required this.profilePic,
    required this.deviceToken,
    required this.deviceType,
    required this.country,
    required this.currency,
    required this.accessToken,
    required this.tokenType,
    required this.bankAcount,
    required this.loginActivity,
    required this.kyc,
    required this.wallet,
  });

}
