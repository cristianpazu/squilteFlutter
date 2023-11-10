import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tienda_app/routes/router.dart';
import 'package:tienda_app/routes/routes.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
void main() {
   

  runApp( const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
   
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.menu,
      routes: appRoutes
      // registro(false),
    );
  }
}
