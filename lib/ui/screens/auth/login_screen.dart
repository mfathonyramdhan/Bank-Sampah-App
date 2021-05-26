import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:kiloin/ui/screens/wrapper.dart';

import '../../../models/auth.dart';
import '../../../models/response_handler.dart';
import '../../../services/auth_services.dart';
import '../../../shared/color.dart';
import '../../../shared/font.dart';
import '../../../shared/size.dart';
import '../../../ui/screens/auth/register_screen.dart';
import '../../../utils/firebase_exception_util.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/custom_material_button.dart';

class LoginScreen extends StatefulWidget {
  static String routeName = "/login_screen";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isLogining = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: lightGreen,
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Container(
                width: deviceWidth(context),
                color: whitePure,
                padding: EdgeInsets.only(
                  top: 90,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    /// WIDGET: APP LOGO
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: 90,
                      ),
                      child: Image(
                        width: 125,
                        height: 105,
                        fit: BoxFit.cover,
                        image: AssetImage("assets/image/splash.png"),
                      ),
                    ),

                    /// SECTION: LOGIN FORM
                    Container(
                      width: deviceWidth(context),
                      decoration: BoxDecoration(
                        color: darkGreen,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(32),
                          topRight: Radius.circular(32),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: defaultMargin,
                          vertical: 36,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            /// WIDGET: CUSTOM TEXT FIELD
                            CustomTextField(
                              controller: emailController,
                              hintText: "Email Address",
                              keyboardType: TextInputType.emailAddress,
                              prefixIcon: Theme(
                                data: Theme.of(context).copyWith(
                                  primaryColor: grayPure,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    right: 16,
                                    left: 20,
                                    top: 12,
                                    bottom: 12,
                                  ),
                                  child: Icon(
                                    Icons.account_circle,
                                    size: 28,
                                    color: grayPure,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),

                            /// WIDGET: CUSTOM TEXT FIELD
                            CustomTextField(
                              obscureText: true,
                              controller: passwordController,
                              hintText: "Password",
                              keyboardType: TextInputType.text,
                              prefixIcon: Theme(
                                data: Theme.of(context).copyWith(
                                  primaryColor: grayPure,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    right: 16,
                                    left: 20,
                                    top: 12,
                                    bottom: 12,
                                  ),
                                  child: Icon(
                                    Icons.lock,
                                    size: 28,
                                    color: grayPure,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 24,
                            ),

                            /// WIDGET: CUSTOM MATERIAL BUTTON
                            if (isLogining) SizedBox(
                              width: 28,
                              height: 28,
                              child: CircularProgressIndicator(
                                color: whitePure,
                              ),
                            ) else CustomMaterialButton(
                              text: "SIGN IN",
                              textColor: whitePure,
                              color: lightGreen,
                              onPressed: () {
                                setState(() {
                                  isLogining = true;
                                });
                                onSubmitPressed(
                                  context, 
                                  email: emailController.text, 
                                  password: passwordController.text,
                                );
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),

                            /// WIDGET: FORGOT PASSWORD LINK
                            GestureDetector(
                              onTap: () {},
                              child: Text(
                                "Forgot Password ?",
                                style: boldCalibriFont.copyWith(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 24,
                            ),

                            /// WIDGET: HORIZONTAL DIVIDER
                            Container(
                              width: deviceWidth(context),
                              height: 1,
                              color: grayPure.withOpacity(0.5),
                            ),
                            SizedBox(
                              height: 24,
                            ),

                            /// WIDGET: REGISTER ACTION
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don't Have Account ? ",
                                  style: regularCalibriFont.copyWith(
                                    fontSize: 14,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushReplacementNamed(
                                      context,
                                      RegisterScreen.routeName,
                                    );
                                  },
                                  child: Text(
                                    "Register",
                                    style: regularCalibriFont.copyWith(
                                      fontSize: 14,
                                      color: lightGreen,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> onSubmitPressed(
    BuildContext context, {
    required String email, 
    required String password,
  }) async {
    if (!(email.trim() != "" && password.trim() != "")) {
      setState(() {
        isLogining = false;
      });

      Flushbar(
        duration: Duration(seconds: 4),
        flushbarPosition: FlushbarPosition.TOP,
        backgroundColor: redDanger,
        message: "Semua Field Harus Diisi",
      ).show(context);
    } else {
      ResponseHandler result = await AuthServices.login(
        Auth(email: email, password: password),
      );

      if (result.user == null) {
        setState(() {
          isLogining = false;
        });

        Flushbar(
          duration: Duration(seconds: 4),
          flushbarPosition: FlushbarPosition.TOP,
          backgroundColor: redDanger,
          message: generateAuthMessage(result.message),
        ).show(context);
      } else {
        Navigator.pushReplacementNamed(
          context, 
          Wrapper.routeName,
        );
      }
    }
  }
}