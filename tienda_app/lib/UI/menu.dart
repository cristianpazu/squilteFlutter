import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tienda_app/Provider/provider.dart';
import 'package:tienda_app/UI/listar_Productos.dart';
import 'package:tienda_app/routes/routes.dart';
import 'package:tienda_app/utils/navegacion_ruta.dart';

class MenuTodo  extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
      ),
      body: Column(children: [
        Container(
            height: 200,
            width: 200,
            child: Card(
              elevation: 49.0,
              child: InkWell(
                child: Center(
                  child: Text('Lista de productos'),
                ),
                onTap: () {
            
               NavegacionRutas().redireccionarNombreRuta(
                              context, Routes.listar);
                },
              ),
            ))
      ]),
    );
  }

}