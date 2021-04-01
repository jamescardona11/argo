import 'package:argo_example/components/side_menu.dart';
import 'package:argo_example/screens/email/email_screen.dart';
import 'package:flutter/material.dart';
import 'components/list_of_emails.dart';
import 'package:argo/argo.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveLayoutWidget(
        mobile: ListOfEmails(),
        tablet: Row(
          children: [
            Expanded(
              flex: 6,
              child: ListOfEmails(),
            ),
            Expanded(
              flex: 9,
              child: EmailScreen(),
            ),
          ],
        ),
        desktop: Builder(
          builder: (context) {
            final isBigSize = context.widthPx >= 1340;

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: isBigSize ? 2 : 4,
                  child: SideMenu(),
                ),
                Expanded(
                  flex: isBigSize ? 3 : 5,
                  child: ListOfEmails(),
                ),
                Expanded(
                  flex: isBigSize ? 8 : 10,
                  child: EmailScreen(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
