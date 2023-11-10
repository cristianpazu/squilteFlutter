


import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tienda_app/Provider/stateProducto.dart';
import 'package:tienda_app/conexion/conexion.dart';
import 'package:tienda_app/model/productos.dart';


final databaseProvider = Provider((ref) => ConexionDatabase.instance);


final allProduct = FutureProvider<List<Productos>>((ref) async{

final productosAll = await ConexionDatabase.instance.getAll();
print('object');
print(productosAll.length);
return productosAll;
});

final allProducts = StateNotifierProvider<TiendaNotifier, ProductosState>((ref) => TiendaNotifier(ref));

class TiendaNotifier extends StateNotifier<ProductosState>{
  TiendaNotifier(this.ref)
  : _databaseProvider = ref.watch(databaseProvider),
        super(ProductosState.inicial());
    final Ref ref;
  final ConexionDatabase _databaseProvider;


    allProdu() async{
  
    try{
state = state.copyWith(status: ProductsStatus.cargando);  
      
  //  await Future.delayed(const Duration(seconds: 2));

      List<Productos> productosAll = await _databaseProvider.getAll();
       
          state = state.copyWith(
        status: ProductsStatus.productosCargados,
        listaProductos: productosAll,
      );
      
    }catch(e){
 
      throw Exception();
    }
  }

  eliminarProductos(id)async{
    try {
      state = state.copyWith(status: ProductsStatus.eliminando);  
await  _databaseProvider.delete(id);
  state = state.copyWith(
        status: ProductsStatus.elimnadoCorrectamente,
      );
    } catch (e) {
      rethrow;
    }


  }

}
