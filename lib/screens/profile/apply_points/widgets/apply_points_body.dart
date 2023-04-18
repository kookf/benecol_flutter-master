
import 'package:benecol_flutter/config/config.dart';
import 'package:benecol_flutter/screens/profile/apply_points/widgets/apply_points_form.dart';
import 'package:benecol_flutter/screens/profile/apply_points/widgets/apply_points_form_controller.dart';
import 'package:benecol_flutter/util/utils.dart';
import 'package:benecol_flutter/widgets/bottom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ApplyPointsBody extends StatelessWidget {
  ApplyPointsBody({ Key? key }) : super(key: key);
  late AppLocalizations T;

  var icon = {
  	"title":"assets/icons/icon-1.png",
  };

   ApplyPointsFormController applyPointsFormController = ApplyPointsFormController();



  @override
  Widget build(BuildContext context) {
    T = AppLocalizations.of(context)!;
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  buildApplyPointsHeader(),
                  ApplyPointsForm(controller: applyPointsFormController),

                ],
              ),
            ),
          ),
        ),
        BottomButton(
          // buttonText: '提交',

          buttonText: T.applyPointSubmitTxt,
          press: () async {
            applyPointsFormController.submit(context);
          }
        )
      ],
    );
  }

  Container buildApplyPointsHeader() {
    return Container(

      width: double.infinity,
      height: 64,
      padding: EdgeInsets.only(
        top: 10,
      ),
      decoration: BoxDecoration(

        border: Border(
          bottom: BorderSide(
            width:1, 
            color: getColorFromHex("#dedede")
          )
        )
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 15, right: 10),
            child: Image.asset(
              icon['title']!,
              width: 36,
            ),
          ),
          Text(
            // '登記積分',
            T.applyPointHeader,
            style: TextStyle(
              fontSize: 19,
              color: kPrimaryColor
            )
          ),
        ],
      )
    );
  }
}