import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/data/network/sqlite_factory.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:sqflite/sqflite.dart';

abstract class AppSqlApiAbs {
  Future<String> asyncData(
      List<BrandModel> brands,
      List<PharmacyModel> pharmacies,
      List<PlaceModel> places,
      List<SpecDModel> specs,
      List<DoctorModel> doctors,
      List<HospitalModel> hospitals,
      List<HospitalSpModel> hospitalSps,
      List<BrandSpModel> brandSps,
      List<PlanBrandModel> planBrands,
      VisitHospitalBase visitHospital,
      VisitDoctorBase visitDoctor);

  /////////////////////////////////////////////////////////////////////////////////
  insertBrands(List<BrandModel> brands);
  insertHospitalSp(List<HospitalSpModel> hospitalSps);
  insertPharmacy(List<PharmacyModel> pharmacies);
  insertPlace(List<PlaceModel> places);
  insertSpec(List<SpecDModel> specs);
  insertLogin(LoginModel loginModel);
  inserthospital(List<HospitalModel> hospitals);
  insertdoctor(List<DoctorModel> doctors);

  //////////////////////////////////Visit/////////////insert
  Future<void> insertVisitHospital(
      VisitHospitalModel visitHospitalModel, int hos, int spec);
  Future<void> insertVisitBrandHospital(
      VisitHospitalModel visitHospitalModel,
      List<VisitBrandPharmacyModel> visitBrandPharmacyModels,
      int hos,
      int spec);
  Future<void> insertVisitBrandDoctor(
    VisitDoctorModel visitDoctorModel,
    List<VisitBrandPharmacyModel> visitBrandPharmacyModels,
  );
  Future<void> insertVisitBrandPharmacy(VisitPharmacyModel visitPharmacyModel,
      List<VisitBrandPharmacyModel> visitBrandPharmacyModels);
  insertVisitDoctor(VisitDoctorModel visitDoctorModel);
  insertVisitPharmacy(VisitPharmacyModel visitPharmacyModel);

  ///////////////////////////get
  Future<List<SpecDModel>> getSpec();
  Future<List<PlaceModel>> getPlace();
  Future<List<PharmacyModel>> getPharmacy();
  Future<List<BrandModel>> getBrands();
  Future<List<HospitalModel>> getHospitalByPlaceId(int placeId);
  Future<List<DoctorModel>> getDoctorByPlaceId(int placeId);
  Future<List<PharmacyModel>> getPharmaciesByPlaceId(int placeId);
  Future<List<DoctorModel>> getDoctorBySpec(int spId);
  Future<List<HospitalModel>> getHospitalBySpec(int spId);
  Future<List<HospitalModel>> getHospital();
  Future<List<DoctorModel>> getDotors();
  Future<List<BrandModel>> getBrandsWithFlag();
  Future<LoginModel?> getRep();
  ///////////////////////get visit////////////////////////////
  Future<List<VisitDoctorAndDoctor>> getVisitDoctor();
  Future<List<VisitPharmacyAndPharmacy>> getVisitPharmacy();
  Future<List<VisitHospitalAndHospital>> getVisitHospital();
////////////////////////////////////////////////////////
  Future<List<PharmacyBrandModel>> getBrandsHospitalByVisitId(int visitId);
  Future<List<PharmacyBrandModel>> getBrandsDoctorByVisitId(int visitId);
  Future<List<PharmacyBrandModel>> getBrandsPharmacyByVisitId(int visitId);
  getPharmaciesVisit();
  ///////////update
  Future<void> updateVisitHospitalFields({
    required int id,
    String? kaswn,
    String? science,
    String? target,
  });
  Future<void> updateVisitDoctorFields({
    required int id,
    String? kaswn,
    String? science,
    String? target,
  });
  Future<void> updateVisitPharmacy({
    required int visitId,
    String? newNote,
  });
  Future<void> editIsLogin(int repId, int isLogin);
  ///////////////////////////////////clear
  Future<void> clearDatabase();
  Future<void> clearDatabaseAll();
  Future<List<SpecHospitalSp>> specializationByHospitalId(int hospitalId);
/////////////////////////////////////////////////////////////////////////////////////////////////////////get insert
  Future<List<VisitDoctorModel>> visitDoctorAs();
  Future<List<VisitBrandPharmacyModel>> visitBrandDoctorAs();
  Future<List<VisitHospitalModel>> visitHospitalAs();
  Future<List<HospitalSpModel>> visitHospitalSpAs();
  Future<List<VisitBrandPharmacyModel>> visitBrandHospitalAs();
  Future<List<VisitPharmacyModel>> visitPharmacyAs();
  Future<List<VisitBrandPharmacyModel>> visitBrandPharmacyAs();
  Future<List<PlanBrandModel>> planBrandsAs();
}

class AppSqlApi extends AppSqlApiAbs {
  DatabaseHelper databaseHelper;
  AppSqlApi(this.databaseHelper);
  Future<void> initializeDatabase() async {
    await databaseFactory.debugSetLogLevel(sqfliteLogLevelVerbose);
  }

  insertBrands(List<BrandModel> brands) async {
    Database? mydb = await databaseHelper.database;
    Batch batch = mydb.batch();
    for (var brand in brands) {
      batch.insert('brand', brand.toMap());
    }
    await batch.commit(noResult: true);
  }

  Future<String> asyncData(
      List<BrandModel> brands,
      List<PharmacyModel> pharmacies,
      List<PlaceModel> places,
      List<SpecDModel> specs,
      List<DoctorModel> doctors,
      List<HospitalModel> hospitals,
      List<HospitalSpModel> hospitalSps,
      List<BrandSpModel> brandSps,
      List<PlanBrandModel> planBrands,
      VisitHospitalBase visitHospital,
      VisitDoctorBase visitDoctor
      ) async {
    try {
      Database? mydb = await databaseHelper.database;
      await mydb.transaction((txn) async {
        Batch batch = txn.batch();
        await txn.execute("PRAGMA foreign_keys = OFF");
        for (var place in places) {
          batch.insert('place', place.toMap());
        }
        for (var doctor in doctors) {
          batch.insert('doctor', doctor.toMap());
        }
        for (var hospital in hospitals) {
          batch.insert('hospital', hospital.toMap());
        }
        for (var brand in brands) {
          batch.insert('brand', brand.toMap());
        }
        for (var pharmacy in pharmacies) {
          batch.insert('pharmacy', pharmacy.toMap());
        }
        for (var spec in specs) {
          batch.insert('specialization', spec.toMap());
        }
        for (var hospitalSp in hospitalSps) {
          batch.insert('hospitalSp', hospitalSp.toMap());
        }
        for (var brandSp in brandSps) {
          batch.insert('brandSp', brandSp.toMap());
        }
        for (var planBrand in planBrands) {
          batch.insert('planBrand', planBrand.toMap());
        }
        for (var visitHos in visitHospital.data) {
          batch.insert('visit_hospital', visitHos.toMap());
        }
        for (var visitDoc in visitDoctor.data) {
          batch.insert('visit_doctor', visitDoc.toMap());
        }
        await batch.commit(noResult: true);
        await txn.execute("PRAGMA foreign_keys = ON");
        for (var visitHosBrand in visitHospital.brand) {
          txn.insert('visit_brand_hospital', visitHosBrand.toMap());
        }
        for (var visitDocBrand in visitDoctor.brand) {
          txn.insert('visit_brand_doctor', visitDocBrand.toMap());
        }
        final List<Map<String, dynamic>> maps = await txn.rawQuery('''
        SELECT 
          specialization.id AS specialization_id, 
          specialization.title AS specialization_title, 
          COALESCE(SUM(CAST(doctor.visits AS INTEGER)), 0) AS sumDoctor
        FROM 
          specialization
        LEFT JOIN 
          doctor ON doctor.spId = specialization.id
        GROUP BY 
          specialization.title, specialization.id
      ''');
        final List<Map<String, dynamic>> maps1 = await txn.rawQuery('''
  SELECT 
      specialization.id AS specialization_id, 
      specialization.title AS specialization_title, 
        COALESCE(SUM(
        CASE 
          WHEN hospital.title LIKE '%شعب%' THEN 
            (CAST(hospitalSp.totalDocs AS INTEGER) * CAST(hospitalSp.visit AS INTEGER)) / 2
          ELSE 
            CAST(hospitalSp.totalDocs AS INTEGER) * CAST(hospitalSp.visit AS INTEGER)
        END
      ), 0) AS sumBrandHospital,
          CAST(hospitalSp.totalDocs AS INTEGER) * CAST(hospitalSp.visit AS INTEGER) AS sumHospital
  FROM 
      specialization
  LEFT JOIN 
      hospitalSp ON hospitalSp.spId = specialization.id
 LEFT JOIN 
      hospital ON hospital.id = hospitalSp.hospitalId
  GROUP BY 
      specialization.title, specialization.id
''');
        for (int i = 0; i < maps.length; i++) {
          int specializationId = maps[i]['specialization_id'] as int;
          int sumDoctor = (maps[i]['sumDoctor'] ?? 0) as int;
          int sumBrandHospital = (maps1[i]['sumBrandHospital'] ?? 0) as int;
          int sumHospital = (maps1[i]['sumHospital'] ?? 0) as int;
          await txn.update(
            'specialization',
            {
              'sumDoctor': sumDoctor,
              'sumBrandHospital': sumBrandHospital,
              'sumHospital': sumHospital,
            },
            where: 'id = ?',
            whereArgs: [specializationId],
          );
        }
      });
      return "";
    } catch (error) {
      return error.toString();
      //throw error;
    }
  }

  insertHospitalSp(List<HospitalSpModel> hospitalSps) async {
    Database? mydb = await databaseHelper.database;
    Batch batch = mydb.batch();
    for (var hospitalSps in hospitalSps) {
      batch.insert('hospitalSp', hospitalSps.toMap());
    }
    await batch.commit(noResult: true);
  }

  insertPharmacy(List<PharmacyModel> pharmacies) async {
    Database? mydb = await databaseHelper.database;
    Batch batch = mydb.batch();
    for (var pharmacy in pharmacies) {
      batch.insert('pharmacy', pharmacy.toMap());
    }
    await batch.commit(noResult: true);
  }

  insertPlace(List<PlaceModel> places) async {
    Database? mydb = await databaseHelper.database;
    Batch batch = mydb.batch();
    for (var place in places) {
      batch.insert('place', place.toMap());
    }
    await batch.commit(noResult: true);
  }

  insertSpec(List<SpecDModel> specs) async {
    Database? mydb = await databaseHelper.database;
    Batch batch = mydb.batch();
    for (var spec in specs) {
      batch.insert('specialization', spec.toMap());
    }
    await batch.commit(noResult: true);
  }

  insertLogin(LoginModel loginModel) async {
    Database? mydb = await databaseHelper.database;
    Batch batch = mydb.batch();
    batch.insert('rep', loginModel.toMap());
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

  Future<List<SpecDModel>> getSpec() async {
    final db = await databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('specialization');
    return List.generate(maps.length, (i) {
      return SpecDModel.fromJson(maps[i]);
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

  Future<void> editIsPlan(int repId, int flag) async {
    final mydb = await databaseHelper.database;
    await mydb.update(
      'rep',
      {'flag': flag},
      where: 'repId = ?',
      whereArgs: [repId],
    );
  }

  //////////TODO
  Future<void> clearDatabase() async {
    final db = await databaseHelper.database;
    final tables = [
      'visit_brand_pharmacy',
      'visit_brand_doctor',
      'visit_brand_hospital',
      'visit_doctor',
      'visit_hospital',
      'visit_pharmacy',
      'brandSp',
      'planBrand',
      'hospitalSp',
      'doctor',
      'pharmacy',
      'specialization',
      'hospital',
      'place',
      'brand',
    ];

    Batch batch = db.batch();
    await db.execute('PRAGMA foreign_keys = OFF;');

    for (var table in tables) {
      batch.delete(table);
    }
    await batch.commit(noResult: true);
    await db.execute('PRAGMA foreign_keys = ON;');
  }

  Future<void> clearDatabaseAll() async {
    final db = await databaseHelper.database;
    final tables = [
      'visit_brand_pharmacy',
      'visit_brand_doctor',
      'visit_brand_hospital',
      'visit_doctor',
      'visit_hospital',
      'visit_pharmacy',
      'brandSp',
      'planBrand',
      'hospitalSp',
      'doctor',
      'pharmacy',
      'specialization',
      'hospital',
      'place',
      'brand',
      'rep',
    ];
    Batch batch = db.batch();
    for (var table in tables) {
      batch.delete(table);
    }
    await batch.commit(noResult: true);
  }

  Future<LoginModel?> getRep() async {
    final db = await databaseHelper.database;
    List<Map<String, dynamic>> results =
        await db.rawQuery('SELECT * FROM rep LIMIT 1');

    if (results.isNotEmpty) {
      return LoginModel.fromMap(results[0]);
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

  Future<List<PharmacyModel>> getPharmaciesByPlaceId(int placeId) async {
    final db = await databaseHelper.database;
    List<Map<String, dynamic>> result = await db.query(
      'pharmacy',
      where: 'placeId = ?',
      whereArgs: [placeId],
    );
    List<PharmacyModel> pharmacies =
        result.map((map) => PharmacyModel.fromMap(map)).toList();
    return pharmacies;
  }

  Future<List<HospitalModel>> getHospitalByPlaceId(int placeId) async {
    final db = await databaseHelper.database;
    List<Map<String, dynamic>> result = await db.rawQuery('''
    SELECT hospital.*, 
           SUM(CASE WHEN visit_hospital.hospitalSpId IS NOT NULL THEN 1 ELSE 0 END) as total_visits
    FROM hospital
    LEFT JOIN hospitalSp ON hospital.id = hospitalSp.hospitalId
    LEFT JOIN visit_hospital ON hospitalSp.id = visit_hospital.hospitalSpId
    WHERE hospital.placeId = ?
    GROUP BY hospital.id
    HAVING total_visits < SUM(hospitalSp.visit)
  ''', [placeId]);
    List<HospitalModel> hospitals =
        result.map((map) => HospitalModel.fromMap(map)).toList();
    return hospitals;
  }

  Future<List<DoctorModel>> getDoctorByPlaceId(int placeId) async {
    final db = await databaseHelper.database;

    List<Map<String, dynamic>> result = await db.rawQuery('''
    SELECT doctor.*, 
           COUNT(visit_doctor.doctorId) as visited
    FROM doctor
    LEFT JOIN visit_doctor ON doctor.id = visit_doctor.doctorId
    WHERE doctor.placeId = ?
    GROUP BY doctor.id
    HAVING visited < doctor.visits
  ''', [placeId]);

    List<DoctorModel> doctors =
        result.map((map) => DoctorModel.fromMap(map)).toList();
    return doctors;
  }

  insertdoctor(List<DoctorModel> doctors) async {
    Database? mydb = await databaseHelper.database;
    Batch batch = mydb.batch();
    for (var doctor in doctors) {
      batch.insert('doctor', doctor.toMap());
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
    Database? mydb = await databaseHelper.database;
    Batch batch = mydb.batch();
    for (var hospital in hospitals) {
      batch.insert('hospital', hospital.toMap());
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

  Future<List<HospitalModel>> getHospitalBySpec(int spId) async {
    final db = await databaseHelper.database;
    try {
      final List<Map<String, dynamic>> maps = await db.rawQuery('''
      SELECT hospital.*
      FROM hospitalSp
      JOIN hospital ON hospitalSp.hospitalId = hospital.id
      WHERE spId = ?
    ''', [spId]);
      if (maps.isNotEmpty) {
        return List.generate(maps.length, (i) {
          return HospitalModel.fromMap(maps[i]);
        });
      } else {
        return [];
      }
    } catch (e) {
      throw Exception("حدث خطأ أثناء جلب المستشفيات: $e");
    }
  }

  Future<List<DoctorModel>> getDoctorBySpec(int spId) async {
    final db = await databaseHelper.database;
    try {
      final List<Map<String, dynamic>> maps = await db.rawQuery('''
      SELECT doctor.*
      FROM doctor
      WHERE spId = ?
    ''', [spId]);
      if (maps.isNotEmpty) {
        return List.generate(maps.length, (i) {
          return DoctorModel.fromMap(maps[i]);
        });
      } else {
        return [];
      }
    } catch (e) {
      throw Exception("حدث خطأ أثناء جلب المستشفيات: $e");
    }
  }

  Future<List<VisitPharmacyAndPharmacy>> getVisitPharmacy() async {
    final db = await databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.rawQuery('''
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
    ''');
    return List.generate(maps.length, (i) {
      VisitPharmacyModel visitPharmacyModel =
          VisitPharmacyModel.fromMap1(maps[i]);
      PharmacyModel pharmacyModel = PharmacyModel.fromMap1(maps[i]);
      VisitPharmacyAndPharmacy visitPharmacyAndPharmacy =
          VisitPharmacyAndPharmacy(pharmacyModel, visitPharmacyModel);
      return visitPharmacyAndPharmacy;
    });
  }

  insertVisitPharmacy(VisitPharmacyModel visitPharmacyModel) async {
    Database? mydb = await databaseHelper.database;
    Batch batch = mydb.batch();
    batch.insert(
      'visit_pharmacy',
      visitPharmacyModel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    await batch.commit(noResult: true);
  }

  //////////////////////////////////
  Future<List<VisitDoctorAndDoctor>> getVisitDoctor() async {
    final db = await databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.rawQuery('''
    SELECT 
      visit_doctor.id as visit_doctor_id, 
      visit_doctor.data as visit_doctor_data, 
      visit_doctor.kaswn as visit_doctor_kaswn, 
      visit_doctor.science as visit_doctor_science, 
      visit_doctor.additaion as visit_doctor_additaion,
       visit_doctor.target  as visit_doctor_target,
      visit_doctor.doctorId as visit_doctor_doctorId,
       visit_doctor.flag,
      doctor.id as doctor_id, 
      doctor.title as doctor_title, 
      doctor.address as doctor_address,
      doctor.placeId as doctor_placeId,
      doctor.placeTitle as doctor_placeTitle,
      doctor.visits as doctor_visits,
      doctor.spId as doctor_spId,
      doctor.spTitle as doctor_spTitle,
      doctor.workHours as workHours
    FROM visit_doctor
    JOIN doctor ON visit_doctor.doctorId = doctor.id
    ''');
    return List.generate(maps.length, (i) {
      VisitDoctorModel visitDoctorModel = VisitDoctorModel.fromMap1(maps[i]);
      DoctorModel doctorModel = DoctorModel.fromMap1(maps[i]);
      VisitDoctorAndDoctor visitDoctorAndDoctor =
          VisitDoctorAndDoctor(doctorModel, visitDoctorModel);
      return visitDoctorAndDoctor;
    });
  }

  Future<List<VisitHospitalAndHospital>> getVisitHospital() async {
    final db = await databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.rawQuery('''
    SELECT 
      visit_hospital.id as visit_hospital_id, 
      visit_hospital.data as visit_hospital_data, 
      visit_hospital.kaswn as visit_hospital_kaswn, 
      visit_hospital.science as visit_hospital_science, 
      visit_hospital.additaion as visit_hospital_additaion,
      visit_hospital.target ,
      visit_hospital.flag, 
      visit_hospital.hospitalSpId as visit_hospital_hospitalSpId,
      
      hospital.id as hospital_id, 
      hospital.title as hospital_title, 
      hospital.address as hospital_address,
      hospital.placeId as hospital_placeId,
      hospital.placeTitle as hospital_placeTitle,
      hospital.note,
      specialization.id as specialization_id,
      specialization.title as specialization_title
      
    FROM visit_hospital
    JOIN hospitalSp ON visit_hospital.hospitalSpId = hospitalSp.id
    JOIN hospital ON hospitalSp.hospitalId = hospital.id
    JOIN specialization ON hospitalSp.spId = specialization.id

    ''');
    return List.generate(maps.length, (i) {
      VisitHospitalModel visitHospitalModel =
          VisitHospitalModel.fromMap1(maps[i]);
      HospitalModel hospitalModel = HospitalModel.fromMap1(maps[i]);
      SpecDModel specModel = SpecDModel.fromMap2(maps[i]);
      VisitHospitalAndHospital visitHospitalAndHospital =
          VisitHospitalAndHospital(
              hospitalModel, visitHospitalModel, specModel);
      return visitHospitalAndHospital;
    });
  }

  insertVisitDoctor(VisitDoctorModel visitDoctorModel) async {
    Database? mydb = await databaseHelper.database;

    final List<Map<String, dynamic>> visits = await mydb.rawQuery(
      '''
    SELECT * FROM visit_doctor
    WHERE doctorId = ?
    AND data >= date(?, '-5 days')
    AND data < ?
    ''',
      [visitDoctorModel.doctorId, visitDoctorModel.data, visitDoctorModel.data],
    );

    // إذا كانت القائمة فارغة، أضف الزيارة وقم بتنقيص عدد الزيارات
    if (visits.isEmpty) {
      await mydb.transaction((txn) async {
        await txn.insert(
          'visit_doctor',
          visitDoctorModel.toMap1(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      });
    } else {
      throw FormatException(
          'لا يمكن إضافة زيارة جديدة. تم زيارة الطبيب خلال الخمسة أيام الماضية.');
    }
  }

  Future<void> insertVisitBrandPharmacy(VisitPharmacyModel visitPharmacyModel,
      List<VisitBrandPharmacyModel> visitBrandPharmacyModels) async {
    final mydb = await databaseHelper.database;
    await mydb.transaction((txn) async {
      try {
        int visitId = await txn.insert(
          'visit_pharmacy',
          visitPharmacyModel.toMap(),
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
  Future<void> insertVisitBrandDoctor(
    VisitDoctorModel visitDoctorModel,
    List<VisitBrandPharmacyModel> visitBrandPharmacyModels,
  ) async {
    final mydb = await databaseHelper.database;

    await mydb.transaction((txn) async {
      try {
        final List<Map<String, dynamic>> visits = await txn.rawQuery(
          '''
        SELECT * FROM visit_doctor 
        WHERE doctorId = ? 
        AND data >= date(?, '-5 days') 
        AND data < ?
        ''',
          [
            visitDoctorModel.doctorId,
            visitDoctorModel.data,
            visitDoctorModel.data
          ],
        );
        if (visits.isEmpty) {
          int visitId = await txn.insert(
            'visit_doctor',
            visitDoctorModel.toMap1(),
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
        } else {
          throw FormatException(
              'لا يمكن إضافة زيارة جديدة. تم زيارة الطبيب خلال الخمسة أيام الماضية.');
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
      int spec) async {
    final mydb = await databaseHelper.database;
    await mydb.transaction((txn) async {
      try {
        // جلب hospitalSp حسب hospitalId و spId
        final List<Map<String, dynamic>> result = await txn.rawQuery('''
      SELECT id FROM hospitalSp 
      WHERE hospitalId = ? AND spId = ? 
      ''', [hos, spec]);
        if (result.isEmpty) {
          throw Exception(
              'No hospitalSp found for the given hospitalId and spId.');
        }
        int hospitalSpId = result.first['id'];
        visitHospitalModel.hospitalSpId = hospitalSpId;

        final List<Map<String, dynamic>> visits = await txn.rawQuery('''
      SELECT * FROM visit_hospital 
      WHERE hospitalSpId = ? 
      AND data >= date(?, '-2 days') 
      AND data < ?
      ''', [hospitalSpId, visitHospitalModel.data, visitHospitalModel.data]);

        if (visits.isEmpty) {
          int visitId = await txn.insert(
            'visit_hospital',
            visitHospitalModel.toMap1(),
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
        } else {
          // إذا كانت هناك زيارة سابقة، ارمي خطأ
          throw FormatException(
              'لا يمكن إضافة زيارة جديدة. تم زيارة المشفى خلال اليومين  الماضيين.');
        }
      } catch (e) {
        print('Error inserting visit and brands: $e');
        rethrow;
      }
    });
  }

  Future<void> insertVisitHospital(
      VisitHospitalModel visitHospitalModel, int hos, int spec) async {
    Database? mydb = await databaseHelper.database;
    await mydb.transaction((txn) async {
      try {
        final List<Map<String, dynamic>> result = await txn.rawQuery('''
      SELECT id FROM hospitalSp 
      WHERE hospitalId = ? AND spId = ?
      ''', [hos, spec]);
        if (result.isEmpty) {
          throw Exception(
              'No hospitalSp found for the given hospitalId and spId.');
        }
        int hospitalSpId = result.first['id'];
        visitHospitalModel.hospitalSpId = hospitalSpId;

        // جلب جميع الزيارات الخاصة بالمشفى خلال الثلاثة أيام الماضية
        final List<Map<String, dynamic>> visits = await txn.rawQuery('''
      SELECT * FROM visit_hospital 
      WHERE hospitalSpId = ? 
      AND data >= date(?, '-2 days') 
      AND data < ?
      ''', [hospitalSpId, visitHospitalModel.data, visitHospitalModel.data]);

        // إذا لم تكن هناك زيارات خلال الثلاثة أيام الماضية، قم بإدراج الزيارة الجديدة
        if (visits.isEmpty) {
          await txn.insert(
            'visit_hospital',
            visitHospitalModel.toMap1(),
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        } else {
          // إذا كانت هناك زيارة سابقة، ارمي خطأ
          throw FormatException(
              'لا يمكن إضافة زيارة جديدة. تم زيارة المشفى خلال اليومين  الماضيين.');
        }
      } catch (e) {
        print('Error inserting visit: $e');
        rethrow;
      }
    });
  }

  Future<List<PharmacyBrandModel>> getBrandsPharmacyByVisitId(
      int visitId) async {
    Database? mydb = await databaseHelper.database;
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
    Database? mydb = await databaseHelper.database;
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

  Future<List<PharmacyBrandModel>> getBrandsHospitalByVisitId(
      int visitId) async {
    Database? mydb = await databaseHelper.database;
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

  Future<List<SpecHospitalSp>> specializationByHospitalId(
      int hospitalId) async {
    Database? mydb = await databaseHelper.database;

    final List<Map<String, dynamic>> maps = await mydb.rawQuery('''
    SELECT hospitalSp.*, 
           specialization.id AS specialization_id,
           specialization.title AS specialization_title,
           COUNT(visit_hospital.id) AS visited
    FROM specialization
    JOIN hospitalSp ON hospitalSp.spId = specialization.id
    LEFT JOIN visit_hospital ON visit_hospital.hospitalSpId = hospitalSp.id
    WHERE hospitalSp.hospitalId = ?
    GROUP BY specialization.id, hospitalSp.id
    HAVING visited < hospitalSp.visit
  ''', [hospitalId]);
    return List.generate(maps.length, (i) {
      SpecDModel specModel = SpecDModel.fromMap2(maps[i]);
      HospitalSpModel hospitalSpModel = HospitalSpModel.fromMap(maps[i]);
      return SpecHospitalSp(specModel, hospitalSpModel);
    });
  }

  Future<void> updateVisitPharmacy({
    required int visitId,
    String? newNote,
  }) async {
    Database? mydb = await databaseHelper.database;
    if (newNote != null) {
      await mydb.update(
        'visit_pharmacy',
        {'note': newNote},
        where: 'id = ?',
        whereArgs: [visitId],
      );
    }
  }

  Future<void> updateVisitDoctorFields({
    required int id,
    String? kaswn,
    String? science,
    String? target,
  }) async {
    Database? mydb = await databaseHelper.database;
    Map<String, dynamic> updates = {};
    if (kaswn != null) {
      updates['kaswn'] = kaswn;
    }
    if (science != null) {
      updates['science'] = science;
    }
    if (updates.isNotEmpty) {
      await mydb.update(
        'visit_doctor',
        updates,
        where: 'id = ?',
        whereArgs: [id],
      );
    }
  }

  Future<void> updateVisitHospitalFields({
    required int id,
    String? kaswn,
    String? science,
    String? target,
  }) async {
    Database? mydb = await databaseHelper.database;
    Map<String, dynamic> updates = {};
    if (kaswn != null) {
      updates['kaswn'] = kaswn;
    }
    if (science != null) {
      updates['science'] = science;
    }
    if (target != null) {
      updates['target'] = target;
    }
    if (updates.isNotEmpty) {
      await mydb.update(
        'visit_hospital',
        updates,
        where: 'id = ?',
        whereArgs: [id],
      );
    }
  }

  getPharmaciesVisit() async {
    final db = await databaseHelper.database;
    await db.transaction((txn) async {
      final List<Map<String, dynamic>> maps = await txn.query('visit_hospital');
      return List.generate(maps.length, (i) {
        return SpecDModel.fromMap2(maps[i]);
      });
    });
  }

  @override
  Future<List<PlanBrandModel>> planBrandsAs() async {
    final db = await databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'planBrand',
      where: 'flag = ?', // Add the WHERE clause
      whereArgs: [0],
    );
    return List.generate(maps.length, (i) {
      return PlanBrandModel.fromMap(maps[i]);
    });
  }

  @override
  Future<List<VisitBrandPharmacyModel>> visitBrandDoctorAs() async {
    final db = await databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'visit_brand_doctor',
      where: 'flag = ?', // Add the WHERE clause
      whereArgs: [0],
    );

    return List.generate(maps.length, (i) {
      return VisitBrandPharmacyModel.fromJson1(maps[i]);
    });
  }

  @override
  Future<List<VisitBrandPharmacyModel>> visitBrandHospitalAs() async {
    final db = await databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'visit_brand_hospital',
      where: 'flag = ?', // Add the WHERE clause
      whereArgs: [0],
    );
    return List.generate(maps.length, (i) {
      return VisitBrandPharmacyModel.fromJson1(maps[i]);
    });
  }

  @override
  Future<List<VisitBrandPharmacyModel>> visitBrandPharmacyAs() async {
    final db = await databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'visit_brand_pharmacy',
      where: 'flag = ?', // Add the WHERE clause
      whereArgs: [0], // Pass the value for flag (0 in this case)
    );
    return List.generate(maps.length, (i) {
      return VisitBrandPharmacyModel.fromJson1(maps[i]);
    });
  }

  @override
  Future<List<VisitDoctorModel>> visitDoctorAs() async {
    final db = await databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'visit_doctor',
      where: 'flag = ?',
      whereArgs: [0],
    );
    return List.generate(maps.length, (i) {
      return VisitDoctorModel.fromMap(maps[i]);
    });
  }

  @override
  Future<List<VisitHospitalModel>> visitHospitalAs() async {
    final db = await databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'visit_hospital',
      where: 'flag = ?', // Add the WHERE clause
      whereArgs: [0], // Pass the value for flag (0 in this case)
    );
    return List.generate(maps.length, (i) {
      return VisitHospitalModel.fromMap(maps[i]);
    });
  }

  @override
  Future<List<HospitalSpModel>> visitHospitalSpAs() async {
    final db = await databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'hospitalSp',
      where: 'flag = ?', // Add the WHERE clause
      whereArgs: [0], // Pass the value for flag (0 in this case)
    );
    return List.generate(maps.length, (i) {
      return HospitalSpModel.fromMap(maps[i]);
    });
  }

  @override
  Future<List<VisitPharmacyModel>> visitPharmacyAs() async {
    final db = await databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'visit_pharmacy',
      where: 'flag = ?', // Add the WHERE clause
      whereArgs: [0], // Pass the value for flag (0 in this case)
    );
    return List.generate(maps.length, (i) {
      return VisitPharmacyModel.fromMap(maps[i]);
    });
  }

  Future<List<HospitalSpAllModel>> getAllHospitalSpecialization() async {
    Database? mydb = await databaseHelper.database;
    final List<Map<String, dynamic>> maps = await mydb.rawQuery('''
    SELECT 
      hospital.id,
      hospital.title,
      hospital.address,
      hospital.placeTitle,
      hospital.note,
      hospitalSp.rate,
      hospitalSp.totalDocs,
      hospitalSp.visit,
      hospitalSp.flag,
      specialization.title as titleSp 
    FROM hospital
    JOIN hospitalSp ON hospitalSp.hospitalId = hospital.id
    JOIN specialization ON hospitalSp.spId = specialization.id
  ''');
    return List.generate(maps.length, (i) {
      return HospitalSpAllModel.fromMap(maps[i]);
    });
  }

  Future<List<BrandSpPlanModel>> planBrandByRepPlanId(int repPlanId) async {
    Database? mydb = await databaseHelper.database;
    final List<Map<String, dynamic>> maps = await mydb.rawQuery('''
  SELECT  
    planBrand.id AS plan_id,
    planBrand.repPlanId,
    planBrand.brandType,
    planBrand.amount,
    brand.id AS brand_id,
    brand.title AS brand_title,
    brand.phTitle AS brand_phTitle,
    brand.sampleCoast AS brand_sampleCost,
    specialization.id AS specialization_id,
    specialization.title AS specialization_title,
    specialization.sumDoctor AS sumDoctor,
    specialization.sumHospital AS sumHospital
    specialization.sumBrandHospital AS sumBrandHospital
  FROM 
    planBrand
  JOIN  
    brand ON planBrand.brandId = brand.id
  JOIN 
    specialization ON planBrand.spId = specialization.id
  WHERE 
    planBrand.repPlanId = ?
    AND planBrand.amount != 0
  ORDER BY 
    brandType ASC;
''', [repPlanId]);

    Map<int, BrandSpPlanModel> brandMap = {};

    for (var row in maps) {
      int brandId = row['brand_id'] as int;
      if (!brandMap.containsKey(brandId)) {
        BrandModel brandModel = BrandModel(
            brandId,
            row['brand_title'] as String,
            row['brand_phTitle'] as String,
            0,
            row['brand_sampleCost']);
        brandMap[brandId] = BrandSpPlanModel(
          brandModel,
          [],
        );
      }
      brandMap[brandId]!.spPlan.add(
            SpPlan(
                row['plan_id'],
                int.parse(row['amount']),
                row['specialization_title'] as String,
                row['brandType'],
                row['specialization_id'],
                row['sumDoctor'],
                row['sumHospital'],
                row['sumBrandHospital']),
          );
    }
    return brandMap.values.toList();
  }

  ////////////
  Future<List<OtherBrandSpPlanModel>> otherPlanBrandByRepPlanId(
      int repPlanId) async {
    Database? mydb = await databaseHelper.database;
    final List<Map<String, dynamic>> maps = await mydb.rawQuery('''
    SELECT  
      planBrand.id AS plan_id,
      planBrand.repPlanId,
      planBrand.brandType,
      planBrand.amount,
      brand.id AS brand_id,
      brand.title AS brand_title,
      brand.phTitle AS brand_phTitle,
      brand.sampleCoast AS brand_sampleCost,
      specialization.id AS specialization_id,
      specialization.title AS specialization_title,
      specialization.sumDoctor AS sumDoctor,
      specialization.sumHospital AS sumHospital,
      specialization.sumBrandHospital AS sumBrandHospital
    FROM 
      planBrand
    JOIN  
      brand ON planBrand.brandId = brand.id
    JOIN 
      specialization ON planBrand.spId = specialization.id
    WHERE 
      planBrand.repPlanId = ?;
  ''', [repPlanId]);
    Map<int, OtherBrandSpPlanModel> SpMap = {};
    for (var row in maps) {
      int specializationId = row['specialization_id'] as int;
      if (!SpMap.containsKey(specializationId)&&!(row['sumDoctor']==0&&row['sumBrandHospital']==0)) {
        SpecDModel spPlan = SpecDModel(
            specializationId,
            row['specialization_title'],
            row['sumDoctor'],
            row['sumHospital'],
          row['sumBrandHospital']
        );
        SpMap[specializationId] = OtherBrandSpPlanModel(
            spPlan,
            [],
            (spPlan.sumDoctor + spPlan.sumBrandHospital) * UserInfo.samplesCount,
            (((spPlan.sumDoctor + spPlan.sumBrandHospital) * UserInfo.samplesCount) +
                    ((spPlan.sumDoctor + spPlan.sumBrandHospital) / 4))
                .toInt());
      }
     ! (row['sumDoctor']==0&&row['sumBrandHospital']==0)?
      SpMap[specializationId]!.brands.add(
            OtherBrandModel(
                row['brand_id'],
                row['brand_title'] as String,
                row['brand_phTitle'] as String,
                0,
                row['brand_sampleCost'],
                row['plan_id'],
                int.parse(row['amount']),
                row['brandType']),
          ):null;
    }
    return SpMap.values.toList();
  }

  updateRep(
      int repId,
      int otherPlanId,
      int activePlanId,
      int otherStatus,
      String startDate,
      String endDate,
      String otherStartDate,
      String otherEndDate) async {
    Database? mydb = await databaseHelper.database;
    await mydb.update(
      'rep',
      {
        'otherPlanId': otherPlanId,
        'activePlanId': activePlanId,
        'otherStatus': otherStatus,
        'startDate': startDate,
        'endDate': endDate,
        'otherStartDate': otherStartDate,
        'otherEndDate': otherEndDate,
        'flag': otherStatus == 0 ? 0 : 1
      },
      where: 'repId = ?',
      whereArgs: [repId],
    );
  }

  updateAmounts(List<OtherBrandSpPlanModel> planBrands) async {
    Database? mydb = await databaseHelper.database;
    var batch = mydb.batch();
    for (int i = 0; i < planBrands.length; i++) {
      for (int j = 0; j < planBrands[i].brands.length; j++) {
        batch.update(
          'planBrand',
          {'amount': planBrands[i].brands[j].amount},
          where: 'id = ?',
          whereArgs: [planBrands[i].brands[j].Plan],
        );
      }
    }
    await batch.commit(noResult: true);
  }

  updateOtherStatus(
      int repId, int status, List<OtherBrandSpPlanModel> planBrands) async {
    Database? mydb = await databaseHelper.database;
    var batch = mydb.batch();
    for (int i = 0; i < planBrands.length; i++) {
      for (int j = 0; j < planBrands[i].brands.length; j++) {
        batch.update(
          'planBrand',
          {'amount': planBrands[i].brands[j].amount},
          where: 'id = ?',
          whereArgs: [planBrands[i].brands[j].Plan],
        );
      }
    }
    await mydb.update(
      'rep',
      {
        'flag': 0,
        'otherStatus': status,
      },
      where: 'repId = ?',
      whereArgs: [repId],
    );
    await batch.commit(noResult: true);
  }

  updateSpecifiedFlagsToOne(bool hos, bool doc) async {
    Database? db = await databaseHelper.database;
    await db.transaction((txn) async {
      if (hos) {
        await txn.rawUpdate('UPDATE visit_hospital SET flag = 1');
        await txn.rawUpdate('UPDATE visit_brand_hospital SET flag = 1');
      }
      if (doc) {
        await txn.rawUpdate('UPDATE visit_doctor SET flag = 1');
        await txn.rawUpdate('UPDATE visit_brand_doctor SET flag = 1');
      }
      //   await txn.rawUpdate('UPDATE hospitalSp SET flag = 1');
      //  await txn.rawUpdate('UPDATE visit_pharmacy SET flag = 1');
      //  await txn.rawUpdate('UPDATE visit_brand_pharmacy SET flag = 1');
    });
  }
  Future<List<Map<String, dynamic>>> getAllUsers() async {
    Database? db = await databaseHelper.database;
    return await db.query('users');
  }
}

