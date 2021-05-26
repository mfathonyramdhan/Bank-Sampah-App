import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:kiloin/ui/screens/wrapper.dart';

import '../../../models/auth.dart';
import '../../../models/response_handler.dart';
import '../../../services/auth_services.dart';
import '../../../services/social_services.dart';
import '../../../shared/color.dart';
import '../../../shared/font.dart';
import '../../../shared/size.dart';
import '../../../ui/screens/auth/login_screen.dart';
import '../../../utils/firebase_exception_util.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/custom_material_button.dart';
import '../../widgets/custom_social_button.dart';

class RegisterScreen extends StatefulWidget {
  static String routeName = "/register_screen";

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();

  bool isLogining = false;
  bool isGooglePressed = false;
  bool isFacebookPressed = false;

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
                  top: 70,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    /// WIDGET: APP LOGO
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: 70,
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
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(4),
                                topRight: Radius.circular(4),
                              ),
                              child: CustomTextField(
                                controller: emailController,
                                hintText: "Email Address",
                                keyboardType: TextInputType.emailAddress,
                                borderRadius: 0,
                              ),
                            ),
                            SizedBox(
                              height: 1,
                            ),

                            /// WIDGET: CUSTOM TEXT FIELD
                            CustomTextField(
                              controller: phoneController,
                              hintText: "Nomor HP",
                              keyboardType: TextInputType.phone,
                              borderRadius: 0,
                            ),
                            SizedBox(
                              height: 1,
                            ),

                            /// WIDGET: CUSTOM TEXT FIELD
                            CustomTextField(
                              obscureText: true,
                              controller: passwordController,
                              hintText: "Password",
                              keyboardType: TextInputType.text,
                              borderRadius: 0,
                            ),
                            SizedBox(
                              height: 1,
                            ),

                            /// WIDGET: CUSTOM TEXT FIELD
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(4),
                                bottomRight: Radius.circular(4),
                              ),
                              child: CustomTextField(
                                obscureText: true,
                                controller: rePasswordController,
                                hintText: "Re-Password",
                                keyboardType: TextInputType.text,
                                borderRadius: 0,
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
                              text: "SIGN UP",
                              textColor: whitePure,
                              color: lightGreen,
                              onPressed: () {
                                setState(() {
                                  isLogining = true;
                                });
                                onSubmitPressed(
                                  context, 
                                  email: emailController.text,
                                  phone: phoneController.text,
                                  password: passwordController.text,
                                  rePassword: rePasswordController.text,
                                );
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),

                            /// WIDGET: FORGOT PASSWORD LINK
                            Text(
                              "OR",
                              style: boldCalibriFont.copyWith(
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),

                            /// WIDGET: SOCIAL BUTTON
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomSocialButton(
                                  image: "assets/image/logo_facebook.png",
                                  color: whitePure,
                                  onPressed: () {},
                                ),
                                if (isGooglePressed) SizedBox(
                                  width: 96,
                                  child: Center(
                                    child: SizedBox(
                                      width: 28,
                                      height: 28,
                                      child: CircularProgressIndicator(
                                        color: whitePure,
                                      ),
                                    ),
                                  ),
                                ) else CustomSocialButton(
                                  image: "assets/image/logo_google.png",
                                  color: whitePure,
                                  onPressed: () {
                                    setState(() {
                                      isGooglePressed = true;
                                    });
                                    onGooglePressed(context);
                                  },
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 24,
                            ),

                            /// WIDGET: LOGIN ACTION
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Already Have Account ? ",
                                  style: regularCalibriFont.copyWith(
                                    fontSize: 14,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushReplacementNamed(
                                      context,
                                      LoginScreen.routeName,
                                    );
                                  },
                                  child: Text(
                                    "Login",
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
    required String phone, 
    required String password,
    required String rePassword,
  }) async {
    if (!(email.trim() != "" && password.trim() != "")) {
      setState(() {
        isLogining = false;
      });

      Flushbar(
        duration: Duration(seconds: 4),
        flushbarPosition: FlushbarPosition.TOP,
        backgroundColor: redDanger,
        message: "Semua Field Harus Diisikan",
      ).show(context);
    } else if (!(password == rePassword)) {
      setState(() {
        isLogining = false;
      });

      Flushbar(
        duration: Duration(seconds: 4),
        flushbarPosition: FlushbarPosition.TOP,
        backgroundColor: redDanger,
        message: "Konfirmasi Password Harus Sama",
      ).show(context);
    } else {
      ResponseHandler result = await AuthServices.register(
        Auth(
          email: email, 
          phone: phone, 
          password: password,
        ),
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

  Future<void> onGooglePressed(BuildContext context) async {
    ResponseHandler response = await SocialServices.signInGoogle();

    if (response.success == true) {
      Navigator.pushReplacementNamed(
        context, 
        Wrapper.routeName,
      );
    } else {
      setState(() {
        isGooglePressed = false;
      });

      Flushbar(
        duration: Duration(seconds: 4),
        flushbarPosition: FlushbarPosition.TOP,
        backgroundColor: redDanger,
        message: response.message,
      ).show(context);
    }
  }
}
