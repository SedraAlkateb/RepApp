import 'package:domina_app/data/network/sqllite_factory.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:sqflite/sqflite.dart';
class AppSqlApi {
  DatabaseHelper databaseHelper;
  AppSqlApi(this.databaseHelper);
  Future<String> asyncData(
      List<BrandModel> brands,
      List<PharmacyModel> pharmacies,
      List<PlaceModel> places,
      List<SpecModel> specs,
      List<DoctorModel>doctors,
      List<DoctorModel>hospitals
      ) async {
    try {
      Database? mydb = await databaseHelper.database;
      await mydb.transaction((txn) async {
        Batch batch = txn.batch();
        for(var place in places){
          batch.insert('place',place.toMap());
        }
        for(var doctor in doctors){
          batch.insert('doctor',doctor.toMap());
        }
        for(var hospital in hospitals){
          batch.insert('hospital',hospital.toMap());
        }
        for(var brand in brands){
          batch.insert('brand',brand.toMap());
        }
        for(var pharmacy in pharmacies){
          batch.insert('pharmacy',pharmacy.toMap());
        }


        for(var spec in specs){
          batch.insert('specialization',spec.toMap());

        }

        await batch.commit(noResult: true);
      });
      return "";
    } catch (error) {
      return error.toString();
    }
  }

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

  insertLogin(LoginModel loginModel) async {
    Database? mydb =await databaseHelper.database;
    Batch batch =mydb.batch();
    batch.insert('rep',loginModel.toMap());
    await batch.commit(noResult: true);
  }
  Future<List<BrandModel>> getBrands() async {
    final db = await databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('brand');

    return List.generate(maps.length, (i) {
      return BrandModel.fromMap(maps[i]);
    });
  }
  Future<List<PharmacyModel>> getPharmacy() async {
    final db = await databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('pharmacy');
    return List.generate(maps.length, (i) {
      return PharmacyModel.fromMap(maps[i]);
    });

  }
  Future<List<PlaceModel>> getPlace() async {
    final db = await databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('place');
    return List.generate(maps.length, (i) {
      return PlaceModel.fromMap(maps[i]);
    });

  }
  Future<List<SpecModel>> getSpec() async {
    final db = await databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('specialization');

      return List.generate(maps.length, (i) {
      return SpecModel.fromMap(maps[i]);
    });

  }
  Future<void> clearDatabase() async {
    final db = await databaseHelper.database;
    final tables = ['brand',"doctor","hospital", 'pharmacy', 'place', 'specialization'];
    Batch batch = db.batch();
    //    batch.execute('DROP TABLE IF EXISTS rep');
    for (var table in tables) {
      batch.delete(table);
    }
    await batch.commit(noResult: true);
  }
  Future<LoginModel?> getRep() async {
    final db = await databaseHelper.database;
    Batch batch = db.batch();
    batch.rawQuery('SELECT token, repId, planId, name, percentage, isLogin FROM rep LIMIT 1');
    List<dynamic> results = await batch.commit();
    if (results.isNotEmpty && results[0].isNotEmpty) {
      Map<String, dynamic> firstRow = results[0][0];
      return LoginModel.fromMap(firstRow);
    } else {
      return null;
    }
  }
  Future<List<BrandModel>> getBrandsWithFlag() async {
    final db = await databaseHelper.database;
    List<Map<String, dynamic>> brands = await db.query(
      'brand',
      where: 'falg = ?',
      whereArgs: [1],
    );
    return List.generate(brands.length, (i) {
      return BrandModel.fromMap(brands[i]);
    });
  }

  Future<List<PharmacyModel>> getPharmaciesByPlaceId( int placeId) async {
    final db = await databaseHelper.database;
    List<Map<String, dynamic>> result = await db.query(
      'pharmacy',
      where: 'placeId = ?',
      whereArgs: [placeId],
    );
    List<PharmacyModel> pharmacies = result.map((map) => PharmacyModel.fromMap(map)).toList();
    return pharmacies;
  }
  Future<List<DoctorModel>> getDoctorByPlaceId(int placeId) async {
    final db = await databaseHelper.database;
    List<Map<String, dynamic>> result = await db.query(
      'doctor',
      where: 'placeId = ?',
      whereArgs: [placeId],
    );
    List<DoctorModel> doctors = result.map((map) => DoctorModel.fromMap(map)).toList();
    return doctors;
  }
  Future<List<DoctorModel>> getHospitalByPlaceId( int placeId) async {
    final db = await databaseHelper.database;
    List<Map<String, dynamic>> result = await db.query(
      'hospital',
      where: 'placeId = ?',
      whereArgs: [placeId],
    );
    List<DoctorModel> hospitals = result.map((map) => DoctorModel.fromMap(map)).toList();
    return hospitals;
  }

  insertdoctor(List<DoctorModel> doctors) async {
    Database? mydb =await databaseHelper.database;
    Batch batch =mydb.batch();
    for(var doctor in doctors){
      batch.insert('doctor',doctor.toMap());
    }
    await batch.commit(noResult: true);
  }

  Future<List<DoctorModel>> getDotors() async {
    final db = await databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('doctor');

    // Convert List<Map<String, dynamic>> to List<Brand>
    return List.generate(maps.length, (i) {
      return DoctorModel.fromMap(maps[i]);
    });
  }


  inserthospital(List<DoctorModel> doctors) async {
    Database? mydb =await databaseHelper.database;
    Batch batch =mydb.batch();
    for(var doctor in doctors){
      batch.insert('hospital',doctor.toMap());
    }
    await batch.commit(noResult: true);
  }

  Future<List<DoctorModel>> getHospital() async {
    final db = await databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('hospital');

    // Convert List<Map<String, dynamic>> to List<Brand>
    return List.generate(maps.length, (i) {
      return DoctorModel.fromMap(maps[i]);
    });
  }

  Future<List<VisitPharmacyModel>> getVisitPharmacy() async {
    final db = await databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('visit_pharmacy');
    return List.generate(maps.length, (i) {
      return VisitPharmacyModel.fromMap(maps[i]);
    });
  }
  insertVisitPharmacy(VisitPharmacyModel visitPharmacyModel) async {
    Database? mydb =await databaseHelper.database;
    Batch batch =mydb.batch();
    batch.insert('visit_pharmacy',visitPharmacyModel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    await batch.commit(noResult: true);
  }
  
  //////////////////////////////////
  Future<List<VisitDoctorModel>> getVisitDoctor() async {
    final db = await databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('visit_doctor');
    return List.generate(maps.length, (i) {
      return VisitDoctorModel.fromMap(maps[i]);
    });
  }
  insertVisitDoctor(VisitDoctorModel visitDoctorModel) async {
    Database? mydb =await databaseHelper.database;
    Batch batch =mydb.batch();
    batch.insert('visit_doctor',visitDoctorModel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    await batch.commit(noResult: true);
  }
}