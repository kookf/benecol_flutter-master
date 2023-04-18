import 'package:benecol_flutter/screens/login/sign_up/widgets/sign_up_form.dart';
import 'package:benecol_flutter/screens/login/sign_up/widgets/sign_up_form_controller.dart';
import 'package:benecol_flutter/screens/login/sign_up/widgets/sign_up_header.dart';
import 'package:benecol_flutter/widgets/bottom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignUpBody extends StatelessWidget {
  SignUpBody({ 
    Key? key,
  }) : super(key: key);

  final SignUpFormController signUpFormController = SignUpFormController();

  @override
  Widget build(BuildContext context) {
    AppLocalizations T = AppLocalizations.of(context)!;
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  SignUpHeader(),
                  SignUpForm(controller: signUpFormController)
                ],
              ),
            ),
          ),
        ),
        BottomButton(
          buttonText: T.signupSubmitBtn,
          press: () async {
            signUpFormController.submit();
          }
        )
      ],
    );
  }
}
