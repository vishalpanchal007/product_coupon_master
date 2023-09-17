import 'package:path/path.dart';
import 'package:product_coupon_master/product.dart';
import 'package:sqflite/sqflite.dart';

class Product_Helper {
  Product_Helper._();
  static final Product_Helper product_helper = Product_Helper._();

  Database? db;
  String dbName = "product.db";
  String productTable = "products";
  String colIDAuto = "idAuto";
  String colID = "id";
  String colPrice = "price";
  String colProcuctName = "productName";
  String colCount = "count";
  String colImage = "image";
  String colStock = "stock";
  String colisAdd = "isAdd";

  Future<void> initDB() async {
    var directoryPath = await getDatabasesPath();
    String path = join(directoryPath, dbName);

    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        String query =
            "CREATE TABLE IF NOT EXISTS $productTable($colIDAuto INTEGER PRIMARY KEY AUTOINCREMENT,$colID INTEGER, $colProcuctName TEXT , $colPrice INTEGER , $colCount INTEGER , $colImage TEXT ,$colStock INTEGER , $colisAdd TEXT)";
        await db.execute(query);
      },
    );
  }

  Future<int?> insertRecord({required Product data}) async {
    await initDB();

    String query =
        "INSERT INTO $productTable($colID , $colProcuctName , $colPrice , $colCount , $colImage , $colStock , $colisAdd) VALUES(?,?,?,?,?,?,?)";
    List demo = [
      data.id,
      data.productName,
      data.price,
      data.count,
      data.image,
      data.stock,
      data.isAdd
    ];
    int? id = await db?.rawInsert(query, demo);

    return id;
  }

  Future<List<Product>> fetchRecord() async {
    await initDB();

    String query = "SELECT * FROM $productTable";

    List<Map<String, dynamic>> data = await db!.rawQuery(query);

    List<Product> allProductData =
    data.map((e) => Product.fromMap(data: e)).toList();

    return allProductData;
  }

  Future<int> updateRecord({required Product data, required int id}) async {
    await initDB();

    String query = "UPDATE $productTable SET  $colisAdd=? WHERE $colIDAuto=?";
    List args = [data.isAdd, id];

    return db!.rawUpdate(query, args);
  }

  Future<int> deleteRecode({required int id}) async {
    await initDB();
    String query = "DELETE FROM $productTable WHERE $colIDAuto=?";
    List args = [id];

    return db!.rawDelete(query, args);

  }
}