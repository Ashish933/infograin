import 'package:flutter/material.dart';
import 'package:slice_ledger/src/utils/colors.dart';
import 'package:slice_ledger/src/utils/custom_button.dart';
import 'package:slice_ledger/src/utils/custom_textform_field.dart';


class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController _otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      appBar: AppBar(
        title: Text("Verification"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextFormField(
                controller: _otpController,
                labelText: "Enter OTP",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a OTP';
                  }
                  if (value.length < 6) {
                    return 'OTP must be at least 6 characters long';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Icon(
                    Icons.warning_amber_outlined
                  ),
                  Text("Naver Show your OTP/Code with anyone else")
                ],
              ),
              const SizedBox(height: 20),
              CustomButton.button("Submit",
                callBack: () {
                  print("pressed");
                  /*if (_formKey.currentState!.validate()) {
                    // Process data
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                  }*/
                },

              ),



            ],
          ),
        ),
      ));
  }
}
