
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignUpHeader extends StatelessWidget {
  const SignUpHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppLocalizations T = AppLocalizations.of(context)!;
    return Container(
      padding: EdgeInsets.only(top: 20),
      child: Text(
        T.signupHeader,
        style: TextStyle(
          letterSpacing: 0.9,
          color: Colors.white,
          fontWeight: FontWeight.w400,
        )
      ),
    );
  }
}