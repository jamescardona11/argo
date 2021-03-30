import 'package:argo_example/components/side_menu.dart';
import 'package:argo_example/screens/email/email_screen.dart';
import 'package:flutter/material.dart';
import 'components/list_of_emails.dart';
import 'package:argo/argo.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: context.widthPx > 1340 ? 2 : 4,
            child: SideMenu(),
          ),
          Expanded(
            flex: context.widthPx > 1340 ? 3 : 5,
            child: ListOfEmails(),
          ),
          Expanded(
            flex: context.widthPx > 1340 ? 8 : 10,
            child: EmailScreen(),
          ),
        ],
      ),
    );
  }
}
