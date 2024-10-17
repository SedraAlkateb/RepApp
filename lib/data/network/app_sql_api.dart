import 'package:domina_app/data/network/sqlite_factory.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:sqflite/sqflite.dart';
abstract class AppSqlApiAbs{
  Future<String> asyncData(List<BrandModel> brands, List<PharmacyModel> pharmacies, List<PlaceModel> places, List<SpecModel> specs, List<DoctorModel> doctors, List<HospitalModel> hospitals, List<HospitalSpModel> hospitalSps, List<BrandSpModel> brandSps, List<PlanBrandModel> planBrands);
  insertBrands(List<BrandModel> brands);
  insertHospitalSp(List<HospitalSpModel> hospitalSps);
  insertPharmacy(List<PharmacyModel> pharmacies);
  insertPlace(List<PlaceModel> places);
  insertSpec(List<SpecModel> specs);
  insertLogin(LoginModel loginModel);
  inserthospital(List<HospitalModel> hospitals);
  insertdoctor(List<DoctorModel> doctors);
  //////////////////////////////////Visit/////////////insert
  Future<void> insertVisitHospital(VisitHospitalModel visitHospitalModel, int hos, int spec);
  Future<void> insertVisitBrandHospital(VisitHospitalModel visitHospitalModel, List<VisitBrandPharmacyModel> visitBrandPharmacyModels, int hos, int spec);
  Future<void> insertVisitBrandDoctor(VisitDoctorModel visitDoctorModel, List<VisitBrandPharmacyModel> visitBrandPharmacyModels,);
  Future<void> insertVisitBrandPharmacy(VisitPharmacyModel visitPharmacyModel, List<VisitBrandPharmacyModel> visitBrandPharmacyModels);
  insertVisitDoctor(VisitDoctorModel visitDoctorModel);
  insertVisitPharmacy(VisitPharmacyModel visitPharmacyModel);
  ///////////////////////////get
  Future<List<SpecModel>> getSpec();
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


  Future<List<PharmacyBrandModel>> getBrandsHospitalByVisitId(int visitId);
  Future<List<PharmacyBrandModel>> getBrandsDoctorByVisitId(int visitId);
  Future<List<PharmacyBrandModel>> getBrandsPharmacyByVisitId(int visitId);
  getPharmaciesVisit();
  ///////////update
  Future<void> updateVisitHospitalFields({required int id, String? kaswn, String? science,});
  Future<void> updateVisitDoctorFields({required int id, String? kaswn, String? science,});
  Future<void> updateVisitPharmacy({required int visitId, String? newNote,});
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
      List<SpecModel> specs,
      List<DoctorModel> doctors,
      List<HospitalModel> hospitals,
      List<HospitalSpModel> hospitalSps,
      List<BrandSpModel> brandSps,
      List<PlanBrandModel> planBrands,
      ) async {
    try {
      Database? mydb = await databaseHelper.database;
      await mydb.transaction((txn) async {
        Batch batch = txn.batch();
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
        await batch.commit(noResult: true);
      });
      return "";
    } catch (error) {
      return error.toString();
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

  insertSpec(List<SpecModel> specs) async {
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
    final tables = [
      // يجب أن تحذف البيانات من الجداول التابعة أولًا
      'hospitalSp',
      'brandSp',
      'doctor',
      'pharmacy',
      'specialization',
      'hospital',
      'place',
      'brand',
      'planBrand '
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
    Batch batch = db.batch();
    batch.rawQuery(
        'SELECT token, repId, activePlanId,otherPlanId, otherstatus , name, percentage, isLogin FROM rep LIMIT 1');
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

  Future<List<DoctorModel>> getDoctorByPlaceId(int placeId) async {
    final db = await databaseHelper.database;
    List<Map<String, dynamic>> result = await db.query(
      'doctor',
      where: 'placeId = ? AND visits != ?',
      whereArgs: [placeId, '0'],
    );
    List<DoctorModel> doctors =
        result.map((map) => DoctorModel.fromMap(map)).toList();
    return doctors;
  }

  Future<List<HospitalModel>> getHospitalByPlaceId(int placeId) async {
    final db = await databaseHelper.database;
    List<Map<String, dynamic>> result = await db.query(
      'hospital',
      where: 'placeId = ?',
      whereArgs: [placeId],
    );
    List<HospitalModel> hospitals =
        result.map((map) => HospitalModel.fromMap(map)).toList();
    return hospitals;
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
        return [];  // إعادة قائمة فارغة في حالة عدم وجود مستشفيات.
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
        return [];  // إعادة قائمة فارغة في حالة عدم وجود مستشفيات.
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
      SpecModel specModel = SpecModel.fromMap1(maps[i]);
      VisitHospitalAndHospital visitHospitalAndHospital =
          VisitHospitalAndHospital(
              hospitalModel, visitHospitalModel, specModel);
      return visitHospitalAndHospital;
    });
  }


  insertVisitDoctor(VisitDoctorModel visitDoctorModel) async {
    Database? mydb = await databaseHelper.database;

    // جلب جميع الزيارات الخاصة بالطبيب خلال الثلاثة أيام الماضية
    final List<Map<String, dynamic>> visits = await mydb.rawQuery(
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

    // إذا كانت القائمة فارغة، أضف الزيارة وقم بتنقيص عدد الزيارات
    if (visits.isEmpty) {
      await mydb.transaction((txn) async {
        // تقليل عدد الزيارات بمقدار 1
        await txn.rawUpdate(
          '''
        UPDATE doctor 
        SET visits = visits - 1 
        WHERE id = ?
        ''',
          [visitDoctorModel.doctorId],
        );

        // إدراج الزيارة الجديدة
        await txn.insert(
          'visit_doctor',
          visitDoctorModel.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      });
    } else {
      throw FormatException('لا يمكن إضافة زيارة جديدة. تم زيارة الطبيب خلال الثلاثة أيام الماضية.');
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
        // جلب جميع الزيارات الخاصة بالطبيب خلال الثلاثة أيام الماضية
        final List<Map<String, dynamic>> visits = await txn.rawQuery(
          '''
        SELECT * FROM visit_doctor 
        WHERE doctorId = ? 
        AND data >= date(?, '-5 days') 
        AND data < ?
        ''',
          [
            visitDoctorModel.doctorId,
            visitDoctorModel.data,  // تاريخ الزيارة الجديدة
            visitDoctorModel.data   // تاريخ الزيارة الجديدة (كنهاية للفترة)
          ],
        );

        // إذا لم تكن هناك زيارات خلال الثلاثة أيام الماضية
        if (visits.isEmpty) {
          // تقليل عدد الزيارات بمقدار 1
          await txn.rawUpdate(
            '''
          UPDATE doctor 
          SET visits = visits - 1 
          WHERE id = ?
          ''',
            [visitDoctorModel.doctorId],
          );

          // إدراج الزيارة الجديدة
          int visitId = await txn.insert(
            'visit_doctor',
            visitDoctorModel.toMap(),
            conflictAlgorithm: ConflictAlgorithm.replace,
          );

          // إدراج الزيارات للأدوية المرتبطة بالطبيب
          for (var visitBrand in visitBrandPharmacyModels) {
            visitBrand.visitId = visitId;
            await txn.insert(
              'visit_brand_doctor',
              visitBrand.toJson(),
              conflictAlgorithm: ConflictAlgorithm.replace,
            );
          }
        } else {
          // إذا كانت هناك زيارة سابقة، ارمي خطأ
          throw FormatException('لا يمكن إضافة زيارة جديدة. تم زيارة الطبيب خلال الثلاثة أيام الماضية.');
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
      SELECT id, visit FROM hospitalSp 
      WHERE hospitalId = ? AND spId = ? 
      ''', [hos, spec]);

        if (result.isEmpty) {
          throw Exception('No hospitalSp found for the given hospitalId and spId.');
        }

        int hospitalSpId = result.first['id'];
        int currentVisits = result.first['visit'];
        visitHospitalModel.hospitalSpId = hospitalSpId;

        final List<Map<String, dynamic>> visits = await txn.rawQuery('''
      SELECT * FROM visit_hospital 
      WHERE hospitalSpId = ? 
      AND data >= date(?, '-2 days') 
      AND data < ?
      ''', [
          hospitalSpId,
          visitHospitalModel.data,
          visitHospitalModel.data
        ]);

        // إذا لم تكن هناك زيارات خلال الثلاثة أيام الماضية، قم بإدراج الزيارة الجديدة
        if (visits.isEmpty) {
          // تنقيص عدد الزيارات بمقدار 1
          if (currentVisits > 0) {
            await txn.rawUpdate('''
          UPDATE hospitalSp 
          SET visit = visit - 1 
          WHERE id = ?
          ''', [hospitalSpId]);
          }

          int visitId = await txn.insert(
            'visit_hospital',
            visitHospitalModel.toMap(),
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
          throw FormatException('لا يمكن إضافة زيارة جديدة. تم زيارة المشفى خلال الثلاثة أيام الماضية.');
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
        // جلب hospitalSp حسب hospitalId و spId
        final List<Map<String, dynamic>> result = await txn.rawQuery('''
      SELECT id, visit FROM hospitalSp 
      WHERE hospitalId = ? AND spId = ?
      ''', [hos, spec]);

        if (result.isEmpty) {
          throw Exception('No hospitalSp found for the given hospitalId and spId.');
        }
        int hospitalSpId = result.first['id'];
        int currentVisits = result.first['visit'];
        visitHospitalModel.hospitalSpId = hospitalSpId;

        // جلب جميع الزيارات الخاصة بالمشفى خلال الثلاثة أيام الماضية
        final List<Map<String, dynamic>> visits = await txn.rawQuery('''
      SELECT * FROM visit_hospital 
      WHERE hospitalSpId = ? 
      AND data >= date(?, '-2 days') 
      AND data < ?
      ''', [
          hospitalSpId,
          visitHospitalModel.data,
          visitHospitalModel.data
        ]);

        // إذا لم تكن هناك زيارات خلال الثلاثة أيام الماضية، قم بإدراج الزيارة الجديدة
        if (visits.isEmpty) {
          // تنقيص عدد الزيارات بمقدار 1 إذا كانت أكبر من 0
          if (currentVisits > 0) {
            await txn.rawUpdate('''
          UPDATE hospitalSp 
          SET visit = visit - 1 
          WHERE id = ?
          ''', [hospitalSpId]);
          }

          await txn.insert(
            'visit_hospital',
            visitHospitalModel.toMap(),
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        } else {
          // إذا كانت هناك زيارة سابقة، ارمي خطأ
          throw FormatException('لا يمكن إضافة زيارة جديدة. تم زيارة المشفى خلال الثلاثة أيام الماضية.');
        }
      } catch (e) {
        print('Error inserting visit: $e');
        rethrow;
      }
    });
  }


  Future<List<PharmacyBrandModel>> getBrandsPharmacyByVisitId(int visitId) async {
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
  Future<List<PharmacyBrandModel>> getBrandsHospitalByVisitId(int visitId) async {
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
  Future<List<SpecHospitalSp>> specializationByHospitalId(int hospitalId) async {
    Database? mydb = await databaseHelper.database;

    final List<Map<String, dynamic>> maps = await mydb.rawQuery('''
    SELECT hospitalSp.*, 
           specialization.id as specialization_id,
           specialization.title as specialization_title
    FROM specialization
    JOIN hospitalSp ON hospitalSp.spId = specialization.id
    WHERE hospitalSp.hospitalId = ?
    AND hospitalSp.visit > 0
  ''', [hospitalId]);
    return List.generate(maps.length, (i) {
      SpecModel specModel = SpecModel.fromMap1(maps[i]);
      HospitalSpModel hospitalSpModel = HospitalSpModel.fromMap(maps[i]);
      return SpecHospitalSp(specModel, hospitalSpModel);
    });
  }
  Future<void> updateVisitPharmacy({required int visitId, String? newNote,}) async {
    Database? mydb =
        await databaseHelper.database;
    if (newNote != null) {
      await mydb.update(
        'visit_pharmacy',
        {'note': newNote},
        where: 'id = ?',
        whereArgs: [
          visitId
        ],
      );
    }
  }
  Future<void> updateVisitDoctorFields({required int id, String? kaswn, String? science,}) async {
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
  Future<void> updateVisitHospitalFields({required int id, String? kaswn, String? science,}) async {
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
        'visit_hospital',
        updates,
        where: 'id = ?',
        whereArgs: [id],
      );
    }
  }
  getPharmaciesVisit()async{
    final db = await databaseHelper.database;
    await db.transaction((txn) async {
      final List<Map<String, dynamic>> maps = await txn.query('visit_hospital');
      return List.generate(maps.length, (i) {
        return SpecModel.fromMap(maps[i]);
      });
    });

  }



  @override
  Future<List<PlanBrandModel>> planBrandsAs() async{
    final db = await databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('planBrand');
    return List.generate(maps.length, (i) {
      return PlanBrandModel.fromMap(maps[i]);
    });
  }

  @override
  Future<List<VisitBrandPharmacyModel>> visitBrandDoctorAs()async{
    final db = await databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('visit_brand_doctor');
    return List.generate(maps.length, (i) {
      return VisitBrandPharmacyModel.fromJson(maps[i]);
    });
  }

  @override
  Future<List<VisitBrandPharmacyModel>> visitBrandHospitalAs() async{
    final db = await databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('visit_brand_hospital');
    return List.generate(maps.length, (i) {
      return VisitBrandPharmacyModel.fromJson(maps[i]);
    });
  }

  @override
  Future<List<VisitBrandPharmacyModel>> visitBrandPharmacyAs()  async{
    final db = await databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('visit_brand_pharmacy');
    return List.generate(maps.length, (i) {
      return VisitBrandPharmacyModel.fromJson(maps[i]);
    });
  }

  @override
  Future<List<VisitDoctorModel>> visitDoctorAs()async{
    final db = await databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('visit_doctor');
    return List.generate(maps.length, (i) {
      return VisitDoctorModel.fromMap(maps[i]);
    });
  }

  @override
  Future<List<VisitHospitalModel>> visitHospitalAs() async{
    final db = await databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('visit_hospital');
    return List.generate(maps.length, (i) {
      return VisitHospitalModel.fromMap(maps[i]);
    });
  }

  @override
  Future<List<HospitalSpModel>> visitHospitalSpAs() async{
    final db = await databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('hospitalSp');
    return List.generate(maps.length, (i) {
      return HospitalSpModel.fromMap(maps[i]);
    });
  }

  @override
  Future<List<VisitPharmacyModel>> visitPharmacyAs() async{
    final db = await databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('visit_pharmacy');
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
      specialization.title as titleSp 
    FROM hospital
    JOIN hospitalSp ON hospitalSp.hospitalId = hospital.id
    JOIN specialization ON hospitalSp.spId = specialization.id
  ''');

    return List.generate(maps.length, (i) {
      return HospitalSpAllModel.fromMap(maps[i]);
    });
  }


  Future<List<PlanBrandSqlModel>> planBrandByRepPlanId(int repPlanId) async {
    Database? mydb = await databaseHelper.database;

    final List<Map<String, dynamic>> maps = await mydb.rawQuery('''
 SELECT 
  planBrand.id,
  planBrand.repPlanId,
  planBrand.brandType,
  planBrand.amount,
  brand.title AS brandTitle,
  brand.phTitle,
  brand.sampleCoast,
  specialization.title AS specializationTitle
FROM 
  planBrand
JOIN  
  brand ON planBrand.brandId = brand.id
JOIN 
  specialization ON planBrand.spId = specialization.id
WHERE 
  planBrand.repPlanId = ?;

  ''', [repPlanId]);
    return List.generate(maps.length, (i) {
      return PlanBrandSqlModel.fromMap(maps[i]);
    });
  }
  updateRep(int repId, int otherPlanId, int activePlanId, int otherstatus) async {
    Database? mydb = await databaseHelper.database;
     await mydb.update(
      'rep',
      {
        'otherPlanId': otherPlanId,
        'activePlanId': activePlanId,
        'otherStatus': otherstatus,
      },
      where: 'repId = ?',
      whereArgs: [repId],
    );
  }
  updateAmounts(List<PlanBrandSqlModel> planBrands) async {
    Database? mydb = await databaseHelper.database;

    var batch = mydb.batch();
    for (int i = 0; i < planBrands.length; i++) {
      batch.update(
        'planBrand',
        {'amount': planBrands[i].amount},  // القيمة الجديدة لكل صف
        where: 'id = ?',
        whereArgs: [planBrands[i].id],
      );
    }
    await batch.commit(noResult: true);
  }

}
