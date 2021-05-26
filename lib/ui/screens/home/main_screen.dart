import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/user_bloc.dart';
import '../../../services/auth_services.dart';
import '../../screens/auth/login_screen.dart';
import '../../../shared/color.dart';

class MainScreen extends StatelessWidget {
  static String routeName = "/main_screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: lightGreen,
          ),
          SafeArea(
            child: Stack(
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BlocBuilder<UserBloc, UserState>(
                        builder: (_, state) {
                          if (state is UserLoaded) {
                            return Text(state.user.email ?? "-");
                          } else {
                            return Text("Tunggu...");
                          }
                        },
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      MaterialButton(
                        child: Text("Logout"),
                        color: grayPure,
                        onPressed: () async {
                          await AuthServices.logOut().then((_) {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              LoginScreen.routeName,
                              (route) => false,
                            );
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
