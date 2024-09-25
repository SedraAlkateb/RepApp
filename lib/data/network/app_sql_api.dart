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
      List<HospitalModel>hospitals,
      List<HospitalSpModel>hospitalSps,
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
        for(var pharmacy in pharmacies) {
          batch.insert('pharmacy', pharmacy.toMap());
        }
        for(var spec in specs){
          batch.insert('specialization',
              spec.toMap());
        }
        for(var hospitalSp in hospitalSps){
          batch.insert('hospitalSp',hospitalSp.toMap());
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
  insertHospitalSp(List<HospitalSpModel> hospitalSps) async {
    Database? mydb =await databaseHelper.database;
    Batch batch =mydb.batch();
    for(var hospitalSps in hospitalSps){
      batch.insert('hospitalSp',hospitalSps.toMap());
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
  Future<void> editIsLogin(int repId, int isLogin) async {
    final mydb = await databaseHelper.database;
    await mydb.update(
      'rep',
      {'isLogin': isLogin},
      where: 'repId = ?',
      whereArgs: [repId],
    );
  }

  Future<void> clearDatabase() async {
    final db = await databaseHelper.database;
    final tables =['brand',"doctor","hospital", 'pharmacy',
      'place', 'specialization','hospitalSp'
      ,'visit_doctor','visit_hospital'
      ,'visit_pharmacy','visit_brand_pharmacy'
      ,'visit_brand_doctor','visit_brand_hospital'
    ];
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
  Future<List<HospitalModel>> getHospitalByPlaceId( int placeId) async {
    final db = await databaseHelper.database;
    List<Map<String, dynamic>> result = await db.query(
      'hospital',
      where: 'placeId = ?',
      whereArgs: [placeId],
    );
    List<HospitalModel> hospitals = result.map((map) => HospitalModel.fromMap(map)).toList();
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
  inserthospital(List<HospitalModel> hospitals) async {
    Database? mydb =await databaseHelper.database;
    Batch batch =mydb.batch();
    for(var hospital in hospitals){
      batch.insert('hospital',hospital.toMap());
    }
    await batch.commit(noResult: true);
  }
  Future<List<HospitalModel>> getHospital() async {
    final db = await databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('hospital');

    // Convert List<Map<String, dynamic>> to List<Brand>
    return List.generate(maps.length, (i) {
      return HospitalModel.fromMap(maps[i]);
    });
  }
  Future<List<VisitPharmacyAndPharmacy>> getVisitPharmacy() async {
    final db = await databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.rawQuery(
        '''
    SELECT 
      visit_pharmacy.id as visit_pharmacy_id, 
      visit_pharmacy.data as visit_pharmacy_data, 
      visit_pharmacy.note as visit_pharmacy_note, 
      visit_pharmacy.pharmacyId as visit_pharmacy_pharmacyId,
      pharmacy.id as pharmacy_id, 
      pharmacy.title as pharmacy_title, 
      pharmacy.address as pharmacy_address,
      pharmacy.placeId as pharmacy_placeId
    FROM visit_pharmacy
    JOIN pharmacy ON visit_pharmacy.pharmacyId = pharmacy.id
    '''
    );
    return List.generate(maps.length, (i) {
      VisitPharmacyModel visitPharmacyModel=VisitPharmacyModel.fromMap1(maps[i]);
      PharmacyModel pharmacyModel=PharmacyModel.fromMap1(maps[i]);
      VisitPharmacyAndPharmacy visitPharmacyAndPharmacy=VisitPharmacyAndPharmacy(pharmacyModel, visitPharmacyModel);
      return visitPharmacyAndPharmacy;
    });
  }

  insertVisitPharmacy(VisitPharmacyModel visitPharmacyModel) async {
    Database? mydb =await databaseHelper.database;
    Batch batch =mydb.batch();
    batch.insert('visit_pharmacy',visitPharmacyModel.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    await batch.commit(noResult: true);
  }
  //////////////////////////////////
  Future<List<VisitDoctorAndDoctor>> getVisitDoctor() async {
    final db = await databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.rawQuery(
        '''
    SELECT 
      visit_doctor.id as visit_doctor_id, 
      visit_doctor.data as visit_doctor_data, 
      visit_doctor.kaswn as visit_doctor_kaswn, 
      visit_doctor.science as visit_doctor_science, 
      visit_doctor.additaion as visit_doctor_additaion,
      visit_doctor.doctorId as visit_doctor_doctorId,
      doctor.id as doctor_id, 
      doctor.title as doctor_title, 
      doctor.address as doctor_address,
      doctor.placeId as doctor_placeId,
      doctor.placeTitle as doctor_placeTitle,
      doctor.visits as doctor_visits,
      doctor.spId as doctor_spId,
      doctor.spTitle as doctor_spTitle
    FROM visit_doctor
    JOIN doctor ON visit_doctor.doctorId = doctor.id
    '''
    );
    return List.generate(maps.length, (i) {
      VisitDoctorModel visitDoctorModel=VisitDoctorModel.fromMap1(maps[i]);
      DoctorModel doctorModel=DoctorModel.fromMap1(maps[i]);
      VisitDoctorAndDoctor visitDoctorAndDoctor=VisitDoctorAndDoctor(doctorModel, visitDoctorModel);
      return visitDoctorAndDoctor;
    });
  }

  Future<List<VisitHospitalAndHospital>> getVisitHospital() async {
    final db = await databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.rawQuery(
        '''
    SELECT 
      visit_hospital.id as visit_hospital_id, 
      visit_hospital.data as visit_hospital_data, 
      visit_hospital.kaswn as visit_hospital_kaswn, 
      visit_hospital.science as visit_hospital_science, 
      visit_hospital.additaion as visit_hospital_additaion,
      visit_hospital.hospitalSpId as visit_hospital_hospitalSpId,
      
      hospital.id as hospital_id, 
      hospital.title as hospital_title, 
      hospital.address as hospital_address,
      hospital.placeId as hospital_placeId,
      hospital.placeTitle as hospital_placeTitle,
      
      specialization.id as specialization_id,
      specialization.title as specialization_title
      
    FROM visit_hospital
    JOIN hospitalSp ON visit_hospital.hospitalSpId = hospitalSp.id
    JOIN hospital ON hospitalSp.hospitalId = hospital.id
    JOIN specialization ON hospitalSp.spId = specialization.id

    '''
    );
    return List.generate(maps.length, (i) {
      VisitHospitalModel visitHospitalModel = VisitHospitalModel.fromMap1(maps[i]);
      HospitalModel hospitalModel = HospitalModel.fromMap1(maps[i]);
      SpecModel specModel=SpecModel.fromMap1(maps[i]);
      VisitHospitalAndHospital visitHospitalAndHospital = VisitHospitalAndHospital(hospitalModel, visitHospitalModel,specModel);
      return visitHospitalAndHospital;
    });
  }

  insertVisitDoctor(VisitDoctorModel visitDoctorModel) async {
    Database? mydb =await databaseHelper.database;
    Batch batch =mydb.batch();
    batch.insert('visit_doctor',visitDoctorModel.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    await batch.commit(noResult: true);
  }

  Future<void> insertVisitBrandPharmacy(
      VisitPharmacyModel visitPharmacyModel,
      List<VisitBrandPharmacyModel> visitBrandPharmacyModels)
  async {
    final mydb = await databaseHelper.database;
    await mydb.transaction((txn) async {
      try {
        int visitId = await txn.insert(
          'visit_pharmacy',
          visitPharmacyModel.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
        for (var visitBrand in visitBrandPharmacyModels) {
          visitBrand.visitId = visitId;
          await txn.insert(
            'visit_brand_pharmacy',
            visitBrand.toJson(),
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        }
      } catch (e) {
        print('Error inserting visit and brands: $e');
        rethrow;
      }
    });
  }
  Future<void> insertVisitBrandDoctor
      (VisitDoctorModel visitDoctorModel, List<VisitBrandPharmacyModel> visitBrandPharmacyModels)
  async {
    final mydb = await databaseHelper.database;
    await mydb.transaction((txn) async {
      try {
        int visitId = await txn.insert(
          'visit_doctor',
          visitDoctorModel.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
        for (var visitBrand in visitBrandPharmacyModels) {
          visitBrand.visitId = visitId;
          await txn.insert(
            'visit_brand_doctor',
            visitBrand.toJson(),
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        }
      } catch (e) {
        print('Error inserting visit and brands: $e');
        rethrow;
      }
    });
  }
  Future<void> insertVisitBrandHospital(
      VisitHospitalModel visitHospitalModel,
      List<VisitBrandPharmacyModel> visitBrandPharmacyModels,
      int hos,
      int spec
      ) async {
    final mydb = await databaseHelper.database;

    await mydb.transaction((txn) async {
      try {
        final List<Map<String, dynamic>> result = await txn.rawQuery(
            '''
        SELECT id FROM hospitalSp 
        WHERE hospitalId = ? AND spId = ?
        ''',
            [hos, spec]
        );
        if (result.isEmpty) {
          throw Exception('No hospitalSp found for the given hospitalId and spId.');
        }
        int hospitalSpId = result.first['id'];
        visitHospitalModel.hospitalSpId = hospitalSpId;
        int visitId = await txn.insert(
          'visit_hospital',
          visitHospitalModel.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
        for (var visitBrand in visitBrandPharmacyModels) {
          visitBrand.visitId = visitId;
          await txn.insert(
            'visit_brand_hospital',
            visitBrand.toJson(),
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        }
      } catch (e) {
        print('Error inserting visit and brands: $e');
        rethrow;
      }
    });
  }

  insertVisitHospital(VisitHospitalModel visitHospitalModel,
      int hos,
      int spec
      ) async {


    Database? mydb =await databaseHelper.database;
    await mydb.transaction((txn) async {
      try {
        final List<Map<String, dynamic>> result = await txn.rawQuery(
            '''
        SELECT id FROM hospitalSp 
        WHERE hospitalId = ? AND spId = ?
        ''',
            [hos, spec]
        );
        if (result.isEmpty) {
          throw Exception('No hospitalSp found for the given hospitalId and spId.');
        }
        int hospitalSpId = result.first['id'];
        visitHospitalModel.hospitalSpId = hospitalSpId;
        int visitId = await txn.insert(
          'visit_hospital',
          visitHospitalModel.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      } catch (e) {
        print('Error inserting visit and brands: $e');
        rethrow;
      }
    });

  }
  Future<List<PharmacyBrandModel>> getBrandsPharmacyByVisitId(int visitId) async {
    Database? mydb =await databaseHelper.database;
    final List<Map<String, dynamic>> maps = await mydb.rawQuery('''
      SELECT 
      brand.id as id, 
      brand.title as title, 
      brand.phTitle as phTitle,  
      visit_brand_pharmacy.amount as amount
      FROM visit_brand_pharmacy
      JOIN brand  ON visit_brand_pharmacy.brandId = brand.id
      WHERE visit_brand_pharmacy.visitId = ?
    ''', [visitId]);
    return List.generate(maps.length, (i) {
      return PharmacyBrandModel.fromMap(maps[i]);
    });
  }
  Future<List<PharmacyBrandModel>> getBrandsDoctorByVisitId(int visitId) async {
    Database? mydb =await databaseHelper.database;
    final List<Map<String, dynamic>> maps = await mydb.rawQuery('''
      SELECT 
      brand.id as id, 
      brand.title as title, 
      brand.phTitle as phTitle,  
      visit_brand_Doctor.amount as amount
      FROM visit_brand_Doctor
      JOIN brand  ON visit_brand_Doctor.brandId = brand.id
      WHERE visit_brand_Doctor.visitId = ?
    ''', [visitId]);
    return List.generate(maps.length, (i) {
      return PharmacyBrandModel.fromMap(maps[i]);
    });
  }
  Future<List<PharmacyBrandModel>> getBrandsHospitalByVisitId(int visitId) async {
    Database? mydb =await databaseHelper.database;
    final List<Map<String, dynamic>> maps = await mydb.rawQuery('''
      SELECT 
      brand.id as id, 
      brand.title as title, 
      brand.phTitle as phTitle,  
      visit_brand_hospital.amount as amount
      FROM visit_brand_Hospital
      JOIN brand  ON visit_brand_hospital.brandId = brand.id
      WHERE visit_brand_Hospital.visitId = ?
    ''', [visitId]);
    return List.generate(maps.length, (i) {
      return PharmacyBrandModel.fromMap(maps[i]);
    });
  }
  Future<List<SpecModel>> specializationByHospitalId(int hospitalId) async {
    Database? mydb =await databaseHelper.database;
    final List<Map<String, dynamic>> maps = await mydb.rawQuery('''
      SELECT specialization.*
      FROM specialization
      JOIN hospitalSp  ON hospitalSp.spId = specialization.id
      WHERE hospitalSp.hospitalId = ?
    ''',
        [hospitalId]);
    return List.generate(maps.length, (i) {
      return SpecModel.fromMap(maps[i]);
    });
  }

}