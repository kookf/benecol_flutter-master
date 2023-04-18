import 'package:benecol_flutter/config/config.dart';
import 'package:benecol_flutter/screens/login/forget_password/forget_password_screen.dart';
import 'package:benecol_flutter/screens/login/sign_up/sign_up_screen.dart';
import 'package:benecol_flutter/screens/login/widgets/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginBody extends StatelessWidget {
  Object? args;
  LoginBody({ 
    Key? key,
    this.args
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppLocalizations T = AppLocalizations.of(context)!;
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image(
                  image: AssetImage("assets/images/login/logo.png"),
                ),
                LoginForm(
                  args: args
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, ForgetPasswordScreen.routeName);
                    },
                    child: Text(
                      T.loginForgetPassword,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        decoration: TextDecoration.underline,
                      )
                    ),
                  )
                )
              ],
            )
          ),
        ),
        GestureDetector(
          onTap: (){
            Navigator.pushNamed(context, SignUpScreen.routeName);
          },
          child: Container(
            height: 45,
            width: double.infinity,
            decoration: BoxDecoration(
              color:  kSecondaryColor
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  T.loginSignUp,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white
                  )
                ),
              ],
            )
          ),
        )
      ],
    );
  }
}