import 'package:flutter_kotlin_1/src/styles/colors.dart';
import 'package:flutter_kotlin_1/src/widgets/products_customer.dart';
import 'package:flutter_kotlin_1/src/widgets/profile_customer.dart';
import 'package:flutter_kotlin_1/src/widgets/shopping_bag.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

abstract class CustomerScaffold {
  static CupertinoTabScaffold get cupertinoTabScaffold {
    return CupertinoTabScaffold(
      tabBar: _cupertinoTabBar,
      tabBuilder: (context, index) {
        return _pageSelection(index);
      },
    );
  }

  static get _cupertinoTabBar {
    return CupertinoTabBar(
      backgroundColor: AppColors.darkblue,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.create), label: ('Products')),
        BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.shoppingBag), label: ('Orders')),
        BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person), label: ('Profile')),
      ],
    );
  }

  static Widget _pageSelection(int index) {
    if (index == 0) {
      return ProductsCustomer();
    }

    if (index == 1) {
      return ShoppingBag();
    }

    return ProfileCustomer();
  }
}
