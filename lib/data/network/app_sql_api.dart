import 'package:domina_app/data/network/sqllite_factory.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:sqflite/sqflite.dart';

class AppSqlApi {
  DatabaseHelper databaseHelper;
  AppSqlApi(this.databaseHelper);
  insertBrands(List<BrandModel> brands) async {
    Database? mydb =await databaseHelper.database;
    Batch batch =mydb.batch();
    for(var brand in brands){
      batch.insert('brand',brand.toMap());
    }
    await batch.commit(noResult: true);
  }
  insertPharmacy(List<PharmacyModel> pharmacies) async {
    Database? mydb =await databaseHelper.database;
    Batch batch =mydb.batch();
    for(var pharmacy in pharmacies){
      batch.insert('pharmacy',pharmacy.toMap());
    }
    await batch.commit(noResult: true);
  }
  insertPlace(List<PlaceModel> places) async {
    Database? mydb =await databaseHelper.database;
    Batch batch =mydb.batch();
    for(var place in places){
      batch.insert('place',place.toMap());
    }
    await batch.commit(noResult: true);
  }
  insertSpec(List<SpecModel> specs) async {
    Database? mydb =await databaseHelper.database;
    Batch batch =mydb.batch();
    for(var spec in specs){
      batch.insert('specialization',spec.toMap());
    }
    await batch.commit(noResult: true);
  }


  Future<List<BrandModel>> getBrands() async {
    final db = await databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('brand');

    // Convert List<Map<String, dynamic>> to List<Brand>
    return List.generate(maps.length, (i) {
      return BrandModel.fromMap(maps[i]);
    });
  }
  Future<List<PharmacyModel>> getPharmacy() async {
    final db = await databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('pharmacy');

    // Convert List<Map<String, dynamic>> to List<Brand>
    return List.generate(maps.length, (i) {
      return PharmacyModel.fromMap(maps[i]);
    });
  }
  Future<List<PlaceModel>> getPlace() async {
    final db = await databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('place');

    // Convert List<Map<String, dynamic>> to List<Brand>
    return List.generate(maps.length, (i) {
      return PlaceModel.fromMap(maps[i]);
    });
  }
  Future<List<SpecModel>> getSpec() async {
    final db = await databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('specialization');

    // Convert List<Map<String, dynamic>> to List<Brand>
    return List.generate(maps.length, (i) {
      return SpecModel.fromMap(maps[i]);
    });
  }
  Future<void> clearDatabase() async {
    final db = await databaseHelper.database;
    final tables = ['brand', 'pharmacy', 'place', 'specialization'];
    Batch batch = db.batch();
    for (var table in tables) {
      batch.delete(table);
    }
    await batch.commit(noResult: true);
  }

}