import 'package:flutter/material.dart';
import 'package:slice_ledger/src/bloc_provider.dart';
import 'package:slice_ledger/src/utils/fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slice_ledger/src/views/splash_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: MyMultiBlocProvider.providerList,
      child:  MaterialApp(
        navigatorKey: navigatorKey,
        scaffoldMessengerKey: scaffoldMessengerKey,
        debugShowCheckedModeBanner: false,
        home: const Splash(),


      ),
    );
  }
}

