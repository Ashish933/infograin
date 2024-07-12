
import 'package:flutter/material.dart';
import 'package:slice_ledger/src/utils/colors.dart';

class Verified extends StatefulWidget {
  const Verified({super.key});

  @override
  State<Verified> createState() => _VerifiedState();
}

class _VerifiedState extends State<Verified> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              Icons.verified_outlined
            ),
            Text("Successful", style: TextStyle(
              fontFamily: "Signika-Bold",
              fontSize: 25,
              color: AppColors.primaryColor,
            ),)
          ],
        ),
      ),
    );
  }
}
