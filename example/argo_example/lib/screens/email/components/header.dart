import 'package:argo/argo.dart';
import 'package:argo_example/config/assets_manager.dart';
import 'package:argo_example/config/constants.dart';
import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: kDefaultPadding,
        horizontal: kDefaultPadding / 2,
      ),
      child: Row(
        children: [
          if (ResponsiveWrapper.isMobile(context)) BackButton(),
          IconButton(
            icon: WebsafeSvg.asset(
              AssetsManager.trashIcon,
              width: 22,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: WebsafeSvg.asset(
              AssetsManager.replyIcon,
              width: 22,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: WebsafeSvg.asset(
              AssetsManager.replyAllIcon,
              width: 22,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: WebsafeSvg.asset(
              AssetsManager.transferIcon,
              width: 22,
            ),
            onPressed: () {},
          ),
          ResponsiveVisibility.screen(
            conditionScreen: ConditionScreen(
              mobile: false,
              tablet: false,
              desktop: true,
            ),
            child: IconButton(
              icon: WebsafeSvg.asset(
                AssetsManager.printerIcon,
                width: 22,
              ),
              onPressed: () {},
            ),
          ),
          IconButton(
            icon: WebsafeSvg.asset(
              AssetsManager.markupIcon,
              width: 22,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: WebsafeSvg.asset(
              AssetsManager.moreVerticalIcon,
              width: 22,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
