import 'package:argo/argo.dart';
import 'package:argo_example/components/side_menu.dart';
import 'package:argo_example/config/assets_manager.dart';
import 'package:argo_example/config/constants.dart';
import 'package:argo_example/models/email.dart';
import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';

import 'email_card.dart';

class ListOfEmails extends StatefulWidget {
  const ListOfEmails({
    Key? key,
  }) : super(key: key);

  @override
  _ListOfEmailsState createState() => _ListOfEmailsState();
}

class _ListOfEmailsState extends State<ListOfEmails> {
  final scaffoldState = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldState,
      drawer: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 250),
        child: SideMenu(),
      ),
      body: Container(
        padding: EdgeInsets.all(kDefaultPadding),
        color: kBgDarkColor,
        child: Column(
          children: [
            Row(
              children: [
                ResponsiveVisibility.screen(
                  conditionScreen: ConditionScreen(
                    mobile: true,
                    tablet: true,
                    desktop: false,
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.menu),
                        onPressed: () {
                          scaffoldState.currentState!.openDrawer();
                        },
                      ),
                      const SizedBox(width: 5),
                    ],
                  ),
                ),
                Expanded(
                  child: TextField(
                    onChanged: (value) {},
                    decoration: InputDecoration(
                      hintText: "Search",
                      fillColor: kBgLightColor,
                      filled: true,
                      suffixIcon: WebsafeSvg.asset(
                        AssetsManager.searchIcon,
                        width: 24,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: kDefaultPadding),
            Row(
              children: [
                WebsafeSvg.asset(
                  AssetsManager.angleDownIcon,
                  width: 16,
                  color: Colors.black,
                ),
                SizedBox(width: 5),
                Text(
                  "Sort by date",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                Spacer(),
                MaterialButton(
                  minWidth: 20,
                  onPressed: () {},
                  child: WebsafeSvg.asset(
                    AssetsManager.sortIcon,
                    width: 16,
                  ),
                ),
              ],
            ),
            SizedBox(height: kDefaultPadding),
            Expanded(
              child: ListView.builder(
                itemCount: emails.length,
                itemBuilder: (context, index) => EmailCard(
                  isActive: index == 0,
                  email: emails[index],
                  press: () {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
