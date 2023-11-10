import 'package:flutter/material.dart';
import 'package:tienda_app/UI/listar_Productos.dart';
import 'package:tienda_app/UI/menu.dart';
import 'package:tienda_app/routes/routes.dart';

Map<String, Widget Function(BuildContext)> get appRoutes => {
      Routes.menu: (_) => MenuTodo(),
       Routes.listar: (_) => ListarProductos(),
    };