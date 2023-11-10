class Productos{
 
 String? id;
 String? nombre;
 String? precio;


 Productos({ this.id,  this.nombre,  this.precio});

  factory Productos.fromJson(Map<String, dynamic> json) => Productos(
  id: json["id"],
  nombre: json["nombre"],
  precio: json["precio"]

  );

  Map<String, dynamic> toJson() =>{
    "id": id,
    "nombre": nombre,
    "precio": precio,
  };







}