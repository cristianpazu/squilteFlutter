import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tienda_app/Provider/provider.dart';
import 'package:tienda_app/Provider/stateProducto.dart';
import 'package:tienda_app/UI/registro.dart';
import 'package:tienda_app/UI/search.dart';
import 'package:tienda_app/hook/carga.dart';
import 'package:tienda_app/model/productos.dart';
import 'package:tienda_app/routes/routes.dart';
import 'package:tienda_app/utils/navegacion_ruta.dart';

import '../conexion/conexion.dart';

class ListarProductos extends HookConsumerWidget {
  const ListarProductos({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context, WidgetRef ref) {
     var size = MediaQuery.of(context).size;
    final all = ref.watch(allProducts);
    final todos = ref.watch(datos(all.listaProductos));
    final _buscarDatos = ref.watch(buscarDatos.notifier);


    useCargarDatos(() {
      ref.watch(allProducts.notifier).allProdu();
    });
   
  useDispose(() {
      ref.read(buscarDatos).toString();
    }); 
  
  if (all.status == ProductsStatus.elimnadoCorrectamente) {
      useCargarDatos(() {
        ref.watch(allProducts.notifier).allProdu();
      });
    }
    _eliminar(String id) {
print(ProductsStatus);
      ref.read(allProducts.notifier).eliminarProductos(id);
    }
   

    print('>>>>>>>>>>>>>>>>>>>>>>>');
    print(todos);
    return Scaffold(
      appBar: AppBar(
        title: Text('tienda'),
      ),
      body: Column(
        children: [
          Container(
            child: SearcgForm(
              buscar: _buscarDatos,
            ),
          ),
          Container(
            height: size.height * 0.77,
      
            child: ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 10,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: const Color.fromARGB(255, 200, 238, 238),
                    ),
                    //width:50,
                    //height: 80,
                    child: Column(
                      children: [
                        Text('nombre: ${todos[index].nombre}'),
                        Text('precio: ${todos[index].precio}'),
                        IconButton(
                            onPressed: () {

                              showDialog(
                                context: context,
                                builder: (context) {
                                  
                              
                               return AlertDialog(
                                  title: Text('Desea eliminar el producto?'),
                                  actions: [
                                        TextButton(child: Text('NO'),
                              onPressed: () {
                               
                              Navigator.pop(context);
                              },),
                              TextButton(child: Text('SI'),
                              onPressed: () {
                                _eliminar(todos[index].id ?? '');
                               /* ConexionDatabase.instance
                                  .delete(todos[index].id ?? '');
                              ref.read(allProduct); */
                               NavegacionRutas().redireccionarNombreRutaLimpiar(context, Routes.menu);
                              },),
                           
                                  ],
                              
                                );
                                  },
                              );
                           /*   ConexionDatabase.instance
                                  .delete(todos[index].id ?? '');
                              ref.read(allProduct);
                              Navigator.pop(context); */
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ))
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => registro(false)));
        },
      ),
    );
    /*FutureBuilder<List<Productos>>(

        future: ConexionDatabase.instance.getAll(),
        builder: (context, snapshot) {
          return all.when(
              data: (listaProductos) {
                return Column(
                  children: [
                    Center(
                      child: Container(
                        width: double.infinity,
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.amber),
                        child: Text('datasss'),
                      ),
                    ),
                    Expanded(
                        child: ListView.builder(
                      itemCount: listaProductos.length,
                      //snapshot.data?.length,
                      itemBuilder: (context, index) {
                        final items = listaProductos;

                        // final items = snapshot.data?[index] ?? [];
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.cyanAccent,
                          ),
                          width: 50,
                          height: 80,
                          child: Column(
                            children: [
                              Text('nombre: ${items[index].nombre}'),
                              Text('precio: ${items[index].precio}'),
                              IconButton(
                                  onPressed: () {
                                    ConexionDatabase.instance
                                        .delete(items[index].id ?? '');
                                  },
                                  icon: Icon(Icons.delete))
                            ],
                          ),
                        );
                      },
                    ))
                  ],
                );
              },
              error: (_, __) {
                return const Text("NO");
              },
              loading: () => const Center(
                      child: CircularProgressIndicator(
                    backgroundColor: Color.fromARGB(233, 7, 161, 89),
                    valueColor: AlwaysStoppedAnimation(
                        Color.fromARGB(233, 7, 112, 161)),
                    strokeWidth: 10,
                  )
                  )
                  );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => registro(false)));
        },
      ),
    );*/
  }
}

final buscarDatos = StateProvider<String>((ref) => '');
final datos =
    StateProvider.family<List<Productos>, List<Productos>>((ref, lista) {
  final buscar = ref.watch(buscarDatos);
  return lista
      .where((element) =>
          element.nombre!.toLowerCase().contains(buscar.toLowerCase()) ||
          ('${element.nombre} ${element.precio}')
              .toLowerCase()
              .contains(buscar.toLowerCase()) ||
          element.precio!.toString().contains(buscar.toLowerCase()))
      .toList();
});
