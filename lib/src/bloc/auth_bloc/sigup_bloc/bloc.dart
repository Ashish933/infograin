import 'dart:convert';

import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slice_ledger/src/bloc/auth_bloc/sigup_bloc/state.dart';

import '../../../services/apiservices/api_helper.dart';
import '../../../services/apiservices/api_path.dart';
import '../../../utils/fonts.dart';
import '../../../utils/my_dilaogbox.dart';
import '../../../utils/utilityHelper.dart';
import 'event.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final encrypt.Key key = encrypt.Key.fromUtf8('xlhF31NeOlibJcoOW9tvZg7TkHcAZI3a');
  final encrypt.IV iv = encrypt.IV.fromUtf8('qwertyuiopasdfgh');
  final encrypt.AES aes = encrypt.AES(
    encrypt.Key.fromUtf8('xlhF31NeOlibJcoOW9tvZg7TkHcAZI3a'),
    mode: encrypt.AESMode.cbc,
  );
  SignUpBloc() : super(SignUpInitial()) {
    on<SignUpButtonPressed>((event, emit) {
      print("object");
      _onSignUpEvent(event, emit);
    });
  }
  void _onSignUpEvent(SignUpButtonPressed event,
      Emitter<SignUpState> emit) async{

  final encrypter = encrypt.Encrypter(aes);

    // Encrypt the password
    final encryptedPassword = encrypter.encrypt(event.request.password, iv: iv).base64;

    // Prepare the data
  final data = event.request.toJson();
    data['password'] = encryptedPassword;

    // Make the POST request
  final result = await ApiHelper.postWideoutEncodeToken(
      path: ApiPath.signUp, parameters: event.request.toJson());

    if (result.statusCode == 200) {
      final responseData = jsonDecode(result.body);
      UtilityHelper.toastMessage(data[message]);

      final decryptedResponse = decryptResponse(responseData);
      print('Decrypted response: $decryptedResponse');
    } else {
      UtilityHelper.toastMessage((Exception));

      throw Exception('Failed to sign up');
    }

  }


  decryptResponse(encryptedData) {
    final encrypter = encrypt.Encrypter(aes);
    final decrypted = encrypter.decrypt64(encryptedData, iv: iv);
    return decrypted;

  }

}