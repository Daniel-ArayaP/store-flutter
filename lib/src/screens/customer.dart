import 'dart:async';

import 'package:flutter_kotlin_1/src/blocs/auth_bloc.dart';
import 'package:flutter_kotlin_1/src/styles/tabbar.dart';
import 'package:flutter_kotlin_1/src/widgets/customer_scaffold.dart';
import 'package:flutter_kotlin_1/src/widgets/navbar.dart';
import 'package:flutter_kotlin_1/src/widgets/orders.dart';
import 'package:flutter_kotlin_1/src/widgets/products_customer.dart';
import 'package:flutter_kotlin_1/src/widgets/products.dart';
import 'package:flutter_kotlin_1/src/widgets/profile.dart';
import 'package:flutter_kotlin_1/src/widgets/profile_customer.dart';
import 'package:flutter_kotlin_1/src/widgets/shopping_bag.dart';
import 'package:flutter_kotlin_1/src/widgets/vendor_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:io';

import 'package:provider/provider.dart';

class Customer extends StatefulWidget {

  final String marketId;

  Customer({@required this.marketId});
  

  @override
  _CustomerState createState() => _CustomerState();

  static TabBar get customerTabBar {
    return TabBar(
      unselectedLabelColor: TabBarStyles.unselectedLabelColor ,
      labelColor: TabBarStyles.labelColor ,
      indicatorColor: TabBarStyles.indicatorColor ,
      tabs: <Widget>[
        Tab(icon: Icon(Icons.list)),
        Tab(icon: Icon(FontAwesomeIcons.shoppingBag)),
        Tab(icon: Icon(Icons.person)),
      ],
    );
  }
}

class _CustomerState extends State<Customer> {
  late StreamSubscription _userSubscription;

  @override
  void initState() {
    Future.delayed(Duration.zero, (){ 
        var authBloc = Provider.of<AuthBloc>(context,listen: false);
        _userSubscription = authBloc.user.listen((user) { 
          if (user == null) Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
        });
    });
   
    super.initState();
  }

  @override
  void dispose() {
    _userSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    if (Platform.isIOS) {
      return CupertinoPageScaffold(  
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled){
            return <Widget> [
              AppNavbar.cupertinoNavBar(title: 'Customer Name',context: context),
            ];
          }, 
          body: CustomerScaffold.cupertinoTabScaffold,
      ),
      );
    } else {
      return DefaultTabController(  
        length: 3,
        child: Scaffold(  
          body: NestedScrollView(  
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled){
              return <Widget> [
                AppNavbar.materialNavBar(title: 'Customer Name', tabBar: Customer.customerTabBar)
              ];
            },
            body: TabBarView(children: <Widget>[
              ProductsCustomer(),
              ShoppingBag(),
              ProfileCustomer(),
            ],)
          )
        ),
      );
    }
  }
}