
import 'package:benecol_flutter/screens/profile/profile_edit/widgets/profile_edit_form.dart';
import 'package:benecol_flutter/screens/profile/profile_edit/widgets/profile_edit_form_controller.dart';
import 'package:benecol_flutter/widgets/bottom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileEditBody extends StatelessWidget {
  ProfileEditBody({ Key? key }) : super(key: key);

  final ProfileEditFormController profileEditFormController = ProfileEditFormController();

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
                  ProfileEditForm(controller: profileEditFormController)
                ],
              ),
            ),
          ),
        ),
        BottomButton(
          buttonText: T.profileEditSubmitBtnText,
          press: () async {
            profileEditFormController.submit(context);
          }
        )
      ],
    );
  }
}