import 'package:equatable/equatable.dart';
import 'package:tienda_app/model/productos.dart';

enum ProductsStatus {
 inicial,
 productosCargados,
  eliminando,
  editar,
  productoEditado,
  productoRegsitrados,
  cargando,
  elimnadoCorrectamente,
  actalizado

}

class ProductosState extends Equatable{
  final ProductsStatus status;
  final List<Productos> listaProductos;
  final Productos producto;
   const ProductosState({required this.status, required this.listaProductos, required this.producto});

 @override
  List<Object> get props => [status];
  factory ProductosState.inicial() {
    return ProductosState(
        status: ProductsStatus.inicial, 
        listaProductos: const [],
        producto: Productos(),
        
        
        );
  }

  ProductosState copyWith({
    ProductsStatus? status,
    Productos? producto,
    List<Productos>? listaProductos,

  }) {
    return ProductosState(
      status: status ?? this.status,
      producto: producto ?? this.producto,
      listaProductos: listaProductos ?? this.listaProductos,
      
    );
  }
}