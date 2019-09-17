import 'package:flutter/material.dart';
import 'package:shop_app_admin/providers/app_states.dart';
import 'package:shop_app_admin/providers/products_provider.dart';
import 'package:shop_app_admin/screens/admin.dart';
import 'package:shop_app_admin/screens/dashboard.dart';
import 'package:provider/provider.dart';

void main(){
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider.value(value: AppState()),
      ChangeNotifierProvider.value(value: ProductProvider()),

    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Dashboard(),
    ),
  ));
}