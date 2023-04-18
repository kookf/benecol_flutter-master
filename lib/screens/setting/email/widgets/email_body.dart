import 'package:benecol_flutter/screens/setting/email/widgets/email_form.dart';
import 'package:flutter/material.dart';

class EmailBody extends StatelessWidget {
  const EmailBody({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 2),
      child: EmailForm(),
    );
  }
}
