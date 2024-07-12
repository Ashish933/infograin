import 'package:flutter/material.dart';
import 'package:slice_ledger/src/utils/colors.dart';
import 'package:slice_ledger/src/views/signup_screen.dart';

import '../../session/session.dart';


class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    init();
    super.initState();
  }

  init() {
    Future.delayed(
      const Duration(seconds: 5),
          () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>
              // Session.isLogin() ? OrderListScreen():
              SignupScreen(),
            ));
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: const AssetImage(
                "assets/logo/logo.png",
              ),
              height: height / 8,
              width: width / 3,
            ),
             const Text.rich(
                TextSpan(
                    text: 'Slice',
                    style: TextStyle(fontSize: 50,fontFamily: "Signika-Bold",
                        color: AppColors.primaryColor),
                    children: <InlineSpan>[
                      TextSpan(
                        text: 'Ledger',
                        style: TextStyle(
                             fontFamily:"Signika-Bold",
                            fontSize: 50,color: AppColors.secondaryColor),
                      )
                    ]
                )
            ),

          ],
        ),
      ),
    );
  }
}
