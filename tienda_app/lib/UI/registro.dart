import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tienda_app/Provider/provider.dart';
import 'package:tienda_app/UI/menu.dart';
import 'package:tienda_app/conexion/conexion.dart';
import 'package:tienda_app/model/productos.dart';
import 'package:tienda_app/routes/routes.dart';
import 'package:tienda_app/utils/navegacion_ruta.dart';
import 'package:uuid/uuid.dart';

class registro extends StatefulHookConsumerWidget {
  final bool edit;
  final Productos? productos;

  registro(this.edit, {this.productos})
      : assert(edit == true || productos == null);

  @override
  _registroState createState() => _registroState();
}

int contador = 0;

class _registroState extends ConsumerState<registro> {
  TextEditingController nameEditingController = TextEditingController();
  TextEditingController precioEditingController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  var uuid = Uuid();

  @override
  void initState() {
    super.initState();
    if (widget.edit == true) {
      nameEditingController.text = widget.productos?.nombre ?? '';
      precioEditingController.text = widget.productos?.precio ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text(widget.edit ? "edit cliente" : "add productos")),
      body: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
            
                    controller: nameEditingController,
                    decoration: const InputDecoration(
                        label: Text('Nombre producto'),
                        hintText: 'Nombre producto',
                        icon: Icon(Icons.person),
                        border: OutlineInputBorder()),
                    onTap: () =>
                        widget.edit ? () => widget.productos!.nombre : "name",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: precioEditingController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        label: Text('precio del producto'),
                        hintText: 'precio del producto',
                        icon: Icon(Icons.money),
                        border: OutlineInputBorder()),
                    onTap: () =>
                        widget.edit ? () => widget.productos!.precio : "precio",
                  ),
                  ElevatedButton(
                    child: const Text('Guardar'),
                    onPressed: () async {
                      if (!_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Processing Data')));
                      } else if (widget.edit == true) {
                        ConexionDatabase.instance.updateProductos(Productos(
                            id: widget.productos!.id,
                            nombre: nameEditingController.text,
                            precio: precioEditingController.text));
                       NavegacionRutas().redireccionarNombreRuta(context, Routes.menu);
                      } else {
                        await ConexionDatabase.instance.insert(Productos(
                          
                          id: uuid.v1().toString(),
                          nombre: nameEditingController.text,
                          precio: precioEditingController.text,
                        ));
                    
                       NavegacionRutas().redireccionarNombreRutaLimpiar(context, Routes.menu);
                      }
                    },
                  )
                ],
              ),
            ),
          )),
    );
  }
}
