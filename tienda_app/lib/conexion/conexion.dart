import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tienda_app/model/productos.dart';

class ConexionDatabase {
  static final ConexionDatabase instance = ConexionDatabase._init();

  static Database? _databse;

  ConexionDatabase._init();

  final String productosItems = 'shore_items';

  Future<Database> get database async {
    if (_databse != null) return _databse!;

    _databse = await _initDB('shore.db');
    return _databse!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _onCreateDB);
  }

  Future _onCreateDB(Database db, int version) async {
    await db.execute('''CREATE TABLE $productosItems(
    id TEXT PRIMARY KEY,
    nombre TEXT,
    precio INTEGER
  )''');
  }

  Future<void> insert(Productos productos) async {
    final db = await instance.database;

    await db.insert(productosItems, productos.toJson());
  }

  Future<List<Productos>> getAll() async {
  
      try {
           final db = await instance.database;

    final List<Map<String, dynamic>> maps = await db.query(productosItems);
    return List.generate(maps.length, (i) {
    
      final productos = Productos(
          id: maps[i]['id'],
          nombre: maps[i]['nombre'],
          precio: maps[i]['precio'].toString());
   print('estoy aqui en conexion ${productos}');
    return productos;
    });
      } catch (e) {
        rethrow;
      }
  
 
  }

//traer un solo producto con el id
  Future<List<Map<String, dynamic>>> getProductWidthId(int id) async {
    final db = await instance.database;

    var response = db.query('shore_items', where: "id=?", whereArgs: [id]);

    return response;
  }

  //delete
 delete(String id)async{
  final db = await instance.database;

  final eliminar = db.delete('shore_items',
  where: "id=?",
  whereArgs: [id]
  );

  return eliminar;

 }

 updateProductos(Productos productos)async{
  final db = await instance.database;

  final response = db.update('shore_items', productos.toJson(),
  where: "id=?",
  whereArgs: [productos.id]
  );

  return response;

 }
}
