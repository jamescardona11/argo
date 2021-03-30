import 'package:argo_example/config/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';

import '../../../config/constants.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Row(
        children: [
          IconButton(
            icon: WebsafeSvg.asset(
              AssetsManager.trashIcon,
              width: 24,
            ),
            onPressed: () {},
          ),
          SizedBox(width: kDefaultPadding / 2),
          IconButton(
            icon: WebsafeSvg.asset(
              AssetsManager.replyIcon,
              width: 24,
            ),
            onPressed: () {},
          ),
          SizedBox(width: kDefaultPadding / 2),
          IconButton(
            icon: WebsafeSvg.asset(
              AssetsManager.replyAllIcon,
              width: 24,
            ),
            onPressed: () {},
          ),
          SizedBox(width: kDefaultPadding / 2),
          IconButton(
            icon: WebsafeSvg.asset(
              AssetsManager.transferIcon,
              width: 24,
            ),
            onPressed: () {},
          ),
          Spacer(),
          IconButton(
            icon: WebsafeSvg.asset(
              AssetsManager.printerIcon,
              width: 24,
            ),
            onPressed: () {},
          ),
          SizedBox(width: kDefaultPadding / 2),
          IconButton(
            icon: WebsafeSvg.asset(
              AssetsManager.markupIcon,
              width: 24,
            ),
            onPressed: () {},
          ),
          SizedBox(width: kDefaultPadding / 2),
          IconButton(
            icon: WebsafeSvg.asset(
              AssetsManager.moreVerticalIcon,
              width: 24,
            ),
            onPressed: () {},
          ),
          SizedBox(width: kDefaultPadding / 2),
        ],
      ),
    );
  }
}
