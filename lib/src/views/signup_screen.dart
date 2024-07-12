import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slice_ledger/src/models/signup_response.dart';
import 'package:slice_ledger/src/services/signup_request.dart';
import 'package:slice_ledger/src/utils/colors.dart';
import 'package:slice_ledger/src/utils/custom_button.dart';
import 'package:slice_ledger/src/utils/custom_textform_field.dart';

import '../bloc/auth_bloc/sigup_bloc/bloc.dart';
import '../bloc/auth_bloc/sigup_bloc/event.dart';
import '../bloc/auth_bloc/sigup_bloc/state.dart';
import '../models/country_response.dart';
import '../models/request/signup_request_model.dart';
import '../utils/AppMassage.dart';

import '../utils/my_dilaogbox.dart';
import '../utils/utilityHelper.dart';
import '../utils/validation_file.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  List<Country> fetchCountries = [];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ApiService apiService = ApiService();
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
  TextEditingController();
  String? _selectedCountry;

  _onSignUpApiCalling() {
    if (_formKey.currentState!.validate()) {
      SignUpRequestModel request = SignUpRequestModel(
          firstName: _firstNameController.text,
          lastName: _lastNameController.text,
          email: _emailController.text,
          phoneNumber: _phoneController.text,
          password: _passwordController.text,
          countryId: 1);

      BlocProvider.of<SignUpBloc>(context)
          .add(SignUpButtonPressed(request: request));
    } else {
      UtilityHelper.toastMessage(AppMessage.fillAllFields);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldMessengerKey,
      backgroundColor: AppColors.backGroundColor,
      body: BlocBuilder<SignUpBloc, SignUpState>(
          builder: (context,state) {
            if (state is SignUpLoading) {
              MyDialogBox.progressDialogue();
            }
            if (state is SignUpSuccess) {
              _scaffoldMessengerKey.currentState?.showSnackBar(
                SnackBar(content: Text(state.toString())),
              );
              MyDialogBox.close();
            } else if (state is SignUpFailure) {
              _scaffoldMessengerKey.currentState?.showSnackBar(
                SnackBar(content: Text(state.message??"")),
              );
              MyDialogBox.close();
            }
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 120,
                    ),
                    const Text(
                      "SignUp",
                      style: TextStyle(
                        fontFamily: "Signika-Bold",
                        fontSize: 25,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: [
                                Expanded(
                                  child: CustomTextFormField(
                                    controller: _firstNameController,
                                    labelText: 'First Name',
                                    validator: FormValidation.validateName,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: CustomTextFormField(
                                    controller: _lastNameController,
                                    labelText: 'Last Name',
                                    validator: FormValidation.validateName,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            CustomTextFormField(
                              controller: _emailController,
                              validator: FormValidation.emailValidation,
                              labelText: 'email',
                            ),
                            const SizedBox(height: 20),
                            CustomTextFormField(
                              controller: _phoneController,
                              labelText: "Phone Number",
                              validator: FormValidation.mobileNoValidation,
                            ),
                            const SizedBox(height: 20),
                            CustomTextFormField(
                                controller: _passwordController,
                                labelText: "Password",
                                validator: validatePassword
                            ),
                            const SizedBox(height: 20),
                            CustomTextFormField(
                                controller: _confirmPasswordController,
                                labelText: "Confirm Password",
                                validator: validatePassword
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              height: 45,
                              width: 325,
                              child: DropdownButtonFormField<String>(
                                value: _selectedCountry,
                                decoration: InputDecoration(
                                  labelText: 'Country',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                items: ['USA', 'Canada', 'UK', 'Australia']
                                    .map((country) =>
                                    DropdownMenuItem(
                                      value: country,
                                      child: Text(country,
                                        style: const TextStyle(fontSize: 12),),
                                    ))
                                    .toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedCountry = value!;
                                  });
                                },
                                validator: (value) {
                                  if (value == null) {
                                    return 'Please select a country';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(height: 20),
                            CustomButton.button(
                              "SIGN UP",
                              callBack: () {
                                print("pressed");
                                if (_formKey.currentState!.validate()) {
                                  _onSignUpApiCalling();
                                  // Process data
                                  _scaffoldMessengerKey.currentState?.showSnackBar(
                                    const SnackBar(
                                        content: Text('Processing Data')),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
      ),

    );
  }

  String? validatePassword(String? val) {
    var _value = val ?? '';
    final _passwordRegExp = RegExp(AppRegex.passwordRegex);
    if (_value.isEmpty) {
      return AppRegex.requiredText;
    } else if (!_passwordRegExp.hasMatch(_value)) {
      return AppRegex.passwordMustContain;
    } else if (_passwordController.text != _confirmPasswordController.text) {
      return "Password does not match";
    }
    return null;
  }


  void signUp() async {
    final signUpModel = SignUpModel(
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        email: _emailController.text,
        phoneNumber: _phoneController.text,
        password: _passwordController.text,
        countryId: 1
      // countryId: int.parse(_selectedCountry.toString()),
    );
    try {
      await apiService.signUp(signUpModel);
      _scaffoldMessengerKey.currentState?.showSnackBar(
        SnackBar(content: Text('Sign up successful!')),
      );
    } catch (e) {
      print('Sign up failed: $e');
      _scaffoldMessengerKey.currentState?.showSnackBar(
        SnackBar(content: Text('Sign up failed: $e')),
      );
    }

    // apiService.signUp(signUpModel);
  }
}
