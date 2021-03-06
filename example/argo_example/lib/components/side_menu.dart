import 'package:argo/argo.dart';
import 'package:argo_example/config/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../config/constants.dart';
import '../extensions.dart';
import 'side_menu_item.dart';
import 'tags.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: PlatformInfo.isWeb ? kDefaultPadding : 0),
      height: context.heightPx,
      color: kBgLightColor,
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    AssetsManager.outlook,
                    width: 46,
                  ),
                  ResponsiveVisibility.screen(
                    conditionScreen: ConditionScreen(
                      mobile: true,
                      tablet: true,
                      desktop: false,
                    ),
                    child: Expanded(
                      child: Row(
                        children: [
                          Spacer(),
                          CloseButton(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: kDefaultPadding),
              FlatButton.icon(
                minWidth: double.infinity,
                padding: EdgeInsets.symmetric(
                  vertical: kDefaultPadding,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: kPrimaryColor,
                onPressed: () {},
                icon: SvgPicture.asset(AssetsManager.editIcon, width: 16),
                label: Text(
                  "New message",
                  style: TextStyle(color: Colors.white),
                ),
              ).addNeumorphism(
                topShadowColor: Colors.white,
                bottomShadowColor: Color(0xFF234395).withOpacity(0.2),
              ),
              SizedBox(height: kDefaultPadding),
              FlatButton.icon(
                minWidth: double.infinity,
                padding: EdgeInsets.symmetric(
                  vertical: kDefaultPadding,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: kBgDarkColor,
                onPressed: () {},
                icon: SvgPicture.asset(AssetsManager.downloadIcon, width: 16),
                label: Text(
                  "Get messages",
                  style: TextStyle(color: kTextColor),
                ),
              ).addNeumorphism(),
              SizedBox(height: kDefaultPadding * 2),
              // Menu Items
              SideMenuItem(
                press: () {},
                title: "Inbox",
                iconSrc: AssetsManager.inboxIcon,
                isActive: true,
                itemCount: 3,
              ),
              SideMenuItem(
                press: () {},
                title: "Sent",
                iconSrc: AssetsManager.sendIcon,
                isActive: false,
              ),
              SideMenuItem(
                press: () {},
                title: "Drafts",
                iconSrc: AssetsManager.fileIcon,
                isActive: false,
              ),
              SideMenuItem(
                press: () {},
                title: "Deleted",
                iconSrc: AssetsManager.trashIcon,
                isActive: false,
                showBorder: false,
              ),

              SizedBox(height: kDefaultPadding),
              // Tags
              Tags(),
            ],
          ),
        ),
      ),
    );
  }
}
