
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/auth_bloc/sigup_bloc/bloc.dart';

class MyMultiBlocProvider {
  static List<BlocProvider> providerList = [
    // Add this bloc for SignUp
    BlocProvider<SignUpBloc>(
      create: (context) => SignUpBloc(),
    ),



  ];
}
