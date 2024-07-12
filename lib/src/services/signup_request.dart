import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:slice_ledger/src/models/signup_response.dart';


class ApiService {
  final String apiUrl = 'https://bharattoken.org/sliceLedger/admin/api/auth/signUp';
  final String countryUrl = 'https://bharattoken.org/sliceLedger/admin/api/auth/country';
  final encrypt.Key key = encrypt.Key.fromUtf8('xlhF31NeOlibJcoOW9tvZg7TkHcAZI3a');
  final encrypt.IV iv = encrypt.IV.fromUtf8('qwertyuiopasdfgh');
  final encrypt.AES aes = encrypt.AES(
    encrypt.Key.fromUtf8('xlhF31NeOlibJcoOW9tvZg7TkHcAZI3a'),
    mode: encrypt.AESMode.cbc,
  );

  Future<void> signUp(SignUpModel signUpModel) async {
    final encrypter = encrypt.Encrypter(aes);

    // Encrypt the password
    final encryptedPassword = encrypter.encrypt(signUpModel.password, iv: iv).base64;

    // Prepare the data
    final data = signUpModel.toJson();
    data['password'] = encryptedPassword;

    // Make the POST request
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final decryptedResponse = decryptResponse(responseData);
      print('Decrypted response: $decryptedResponse');
    } else {
      throw Exception('Failed to sign up');
    }
  }

  Future<void> country() async {
    final response = await http.post(
      Uri.parse(countryUrl),
    );
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final decryptedResponse = decryptResponse(responseData);
      print('Decrypted response: $decryptedResponse');
    } else {
      throw Exception('Failed to sign up');
    }
  }


  decryptResponse(encryptedData) {
    final encrypter = encrypt.Encrypter(aes);
    final decrypted = encrypter.decrypt64(encryptedData, iv: iv);
    return decrypted;

  }
}
