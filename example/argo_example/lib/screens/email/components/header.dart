import 'package:argo/argo.dart';
import 'package:argo_example/config/assets_manager.dart';
import 'package:argo_example/config/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
            icon: SvgPicture.asset(
              AssetsManager.trashIcon,
              width: 22,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: SvgPicture.asset(
              AssetsManager.replyIcon,
              width: 22,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: SvgPicture.asset(
              AssetsManager.replyAllIcon,
              width: 22,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: SvgPicture.asset(
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
              icon: SvgPicture.asset(
                AssetsManager.printerIcon,
                width: 22,
              ),
              onPressed: () {},
            ),
          ),
          IconButton(
            icon: SvgPicture.asset(
              AssetsManager.markupIcon,
              width: 22,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: SvgPicture.asset(
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
