// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'freezed_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$DailyReservationObject {
  int get tripId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get phone => throw _privateConstructorUsedError;
  int get transfer_position_id => throw _privateConstructorUsedError;
  int get seet => throw _privateConstructorUsedError;
  String get fcm_token => throw _privateConstructorUsedError;

  /// Create a copy of DailyReservationObject
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DailyReservationObjectCopyWith<DailyReservationObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DailyReservationObjectCopyWith<$Res> {
  factory $DailyReservationObjectCopyWith(DailyReservationObject value,
          $Res Function(DailyReservationObject) then) =
      _$DailyReservationObjectCopyWithImpl<$Res, DailyReservationObject>;
  @useResult
  $Res call(
      {int tripId,
      String name,
      int phone,
      int transfer_position_id,
      int seet,
      String fcm_token});
}

/// @nodoc
class _$DailyReservationObjectCopyWithImpl<$Res,
        $Val extends DailyReservationObject>
    implements $DailyReservationObjectCopyWith<$Res> {
  _$DailyReservationObjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DailyReservationObject
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tripId = null,
    Object? name = null,
    Object? phone = null,
    Object? transfer_position_id = null,
    Object? seet = null,
    Object? fcm_token = null,
  }) {
    return _then(_value.copyWith(
      tripId: null == tripId
          ? _value.tripId
          : tripId // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as int,
      transfer_position_id: null == transfer_position_id
          ? _value.transfer_position_id
          : transfer_position_id // ignore: cast_nullable_to_non_nullable
              as int,
      seet: null == seet
          ? _value.seet
          : seet // ignore: cast_nullable_to_non_nullable
              as int,
      fcm_token: null == fcm_token
          ? _value.fcm_token
          : fcm_token // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DailyReservationObjectImplCopyWith<$Res>
    implements $DailyReservationObjectCopyWith<$Res> {
  factory _$$DailyReservationObjectImplCopyWith(
          _$DailyReservationObjectImpl value,
          $Res Function(_$DailyReservationObjectImpl) then) =
      __$$DailyReservationObjectImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int tripId,
      String name,
      int phone,
      int transfer_position_id,
      int seet,
      String fcm_token});
}

/// @nodoc
class __$$DailyReservationObjectImplCopyWithImpl<$Res>
    extends _$DailyReservationObjectCopyWithImpl<$Res,
        _$DailyReservationObjectImpl>
    implements _$$DailyReservationObjectImplCopyWith<$Res> {
  __$$DailyReservationObjectImplCopyWithImpl(
      _$DailyReservationObjectImpl _value,
      $Res Function(_$DailyReservationObjectImpl) _then)
      : super(_value, _then);

  /// Create a copy of DailyReservationObject
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tripId = null,
    Object? name = null,
    Object? phone = null,
    Object? transfer_position_id = null,
    Object? seet = null,
    Object? fcm_token = null,
  }) {
    return _then(_$DailyReservationObjectImpl(
      null == tripId
          ? _value.tripId
          : tripId // ignore: cast_nullable_to_non_nullable
              as int,
      null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as int,
      null == transfer_position_id
          ? _value.transfer_position_id
          : transfer_position_id // ignore: cast_nullable_to_non_nullable
              as int,
      null == seet
          ? _value.seet
          : seet // ignore: cast_nullable_to_non_nullable
              as int,
      null == fcm_token
          ? _value.fcm_token
          : fcm_token // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$DailyReservationObjectImpl implements _DailyReservationObject {
  _$DailyReservationObjectImpl(this.tripId, this.name, this.phone,
      this.transfer_position_id, this.seet, this.fcm_token);

  @override
  final int tripId;
  @override
  final String name;
  @override
  final int phone;
  @override
  final int transfer_position_id;
  @override
  final int seet;
  @override
  final String fcm_token;

  @override
  String toString() {
    return 'DailyReservationObject(tripId: $tripId, name: $name, phone: $phone, transfer_position_id: $transfer_position_id, seet: $seet, fcm_token: $fcm_token)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DailyReservationObjectImpl &&
            (identical(other.tripId, tripId) || other.tripId == tripId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.transfer_position_id, transfer_position_id) ||
                other.transfer_position_id == transfer_position_id) &&
            (identical(other.seet, seet) || other.seet == seet) &&
            (identical(other.fcm_token, fcm_token) ||
                other.fcm_token == fcm_token));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, tripId, name, phone, transfer_position_id, seet, fcm_token);

  /// Create a copy of DailyReservationObject
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DailyReservationObjectImplCopyWith<_$DailyReservationObjectImpl>
      get copyWith => __$$DailyReservationObjectImplCopyWithImpl<
          _$DailyReservationObjectImpl>(this, _$identity);
}

abstract class _DailyReservationObject implements DailyReservationObject {
  factory _DailyReservationObject(
      final int tripId,
      final String name,
      final int phone,
      final int transfer_position_id,
      final int seet,
      final String fcm_token) = _$DailyReservationObjectImpl;

  @override
  int get tripId;
  @override
  String get name;
  @override
  int get phone;
  @override
  int get transfer_position_id;
  @override
  int get seet;
  @override
  String get fcm_token;

  /// Create a copy of DailyReservationObject
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DailyReservationObjectImplCopyWith<_$DailyReservationObjectImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$InsertRecipesObject {
  String get repId => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get docId => throw _privateConstructorUsedError;
  String get spName => throw _privateConstructorUsedError;
  BrandRes get brand_1 => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;
  String get total => throw _privateConstructorUsedError;
  String? get create_date => throw _privateConstructorUsedError;
  String? get print_date => throw _privateConstructorUsedError;
  String get flagImage1 => throw _privateConstructorUsedError;
  String get flagImage2 => throw _privateConstructorUsedError;
  String? get note1 => throw _privateConstructorUsedError;
  String? get note2 => throw _privateConstructorUsedError;
  String? get note_emp => throw _privateConstructorUsedError;
  File? get image1 => throw _privateConstructorUsedError;
  File? get image2 => throw _privateConstructorUsedError;
  BrandRes? get brand_2 => throw _privateConstructorUsedError;
  BrandRes? get brand_3 => throw _privateConstructorUsedError;
  BrandRes? get brand_4 => throw _privateConstructorUsedError;

  /// Create a copy of InsertRecipesObject
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InsertRecipesObjectCopyWith<InsertRecipesObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InsertRecipesObjectCopyWith<$Res> {
  factory $InsertRecipesObjectCopyWith(
          InsertRecipesObject value, $Res Function(InsertRecipesObject) then) =
      _$InsertRecipesObjectCopyWithImpl<$Res, InsertRecipesObject>;
  @useResult
  $Res call(
      {String repId,
      String type,
      String docId,
      String spName,
      BrandRes brand_1,
      String address,
      String phone,
      String total,
      String? create_date,
      String? print_date,
      String flagImage1,
      String flagImage2,
      String? note1,
      String? note2,
      String? note_emp,
      File? image1,
      File? image2,
      BrandRes? brand_2,
      BrandRes? brand_3,
      BrandRes? brand_4});
}

/// @nodoc
class _$InsertRecipesObjectCopyWithImpl<$Res, $Val extends InsertRecipesObject>
    implements $InsertRecipesObjectCopyWith<$Res> {
  _$InsertRecipesObjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of InsertRecipesObject
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? repId = null,
    Object? type = null,
    Object? docId = null,
    Object? spName = null,
    Object? brand_1 = null,
    Object? address = null,
    Object? phone = null,
    Object? total = null,
    Object? create_date = freezed,
    Object? print_date = freezed,
    Object? flagImage1 = null,
    Object? flagImage2 = null,
    Object? note1 = freezed,
    Object? note2 = freezed,
    Object? note_emp = freezed,
    Object? image1 = freezed,
    Object? image2 = freezed,
    Object? brand_2 = freezed,
    Object? brand_3 = freezed,
    Object? brand_4 = freezed,
  }) {
    return _then(_value.copyWith(
      repId: null == repId
          ? _value.repId
          : repId // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      docId: null == docId
          ? _value.docId
          : docId // ignore: cast_nullable_to_non_nullable
              as String,
      spName: null == spName
          ? _value.spName
          : spName // ignore: cast_nullable_to_non_nullable
              as String,
      brand_1: null == brand_1
          ? _value.brand_1
          : brand_1 // ignore: cast_nullable_to_non_nullable
              as BrandRes,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as String,
      create_date: freezed == create_date
          ? _value.create_date
          : create_date // ignore: cast_nullable_to_non_nullable
              as String?,
      print_date: freezed == print_date
          ? _value.print_date
          : print_date // ignore: cast_nullable_to_non_nullable
              as String?,
      flagImage1: null == flagImage1
          ? _value.flagImage1
          : flagImage1 // ignore: cast_nullable_to_non_nullable
              as String,
      flagImage2: null == flagImage2
          ? _value.flagImage2
          : flagImage2 // ignore: cast_nullable_to_non_nullable
              as String,
      note1: freezed == note1
          ? _value.note1
          : note1 // ignore: cast_nullable_to_non_nullable
              as String?,
      note2: freezed == note2
          ? _value.note2
          : note2 // ignore: cast_nullable_to_non_nullable
              as String?,
      note_emp: freezed == note_emp
          ? _value.note_emp
          : note_emp // ignore: cast_nullable_to_non_nullable
              as String?,
      image1: freezed == image1
          ? _value.image1
          : image1 // ignore: cast_nullable_to_non_nullable
              as File?,
      image2: freezed == image2
          ? _value.image2
          : image2 // ignore: cast_nullable_to_non_nullable
              as File?,
      brand_2: freezed == brand_2
          ? _value.brand_2
          : brand_2 // ignore: cast_nullable_to_non_nullable
              as BrandRes?,
      brand_3: freezed == brand_3
          ? _value.brand_3
          : brand_3 // ignore: cast_nullable_to_non_nullable
              as BrandRes?,
      brand_4: freezed == brand_4
          ? _value.brand_4
          : brand_4 // ignore: cast_nullable_to_non_nullable
              as BrandRes?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InsertRecipesObjectImplCopyWith<$Res>
    implements $InsertRecipesObjectCopyWith<$Res> {
  factory _$$InsertRecipesObjectImplCopyWith(_$InsertRecipesObjectImpl value,
          $Res Function(_$InsertRecipesObjectImpl) then) =
      __$$InsertRecipesObjectImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String repId,
      String type,
      String docId,
      String spName,
      BrandRes brand_1,
      String address,
      String phone,
      String total,
      String? create_date,
      String? print_date,
      String flagImage1,
      String flagImage2,
      String? note1,
      String? note2,
      String? note_emp,
      File? image1,
      File? image2,
      BrandRes? brand_2,
      BrandRes? brand_3,
      BrandRes? brand_4});
}

/// @nodoc
class __$$InsertRecipesObjectImplCopyWithImpl<$Res>
    extends _$InsertRecipesObjectCopyWithImpl<$Res, _$InsertRecipesObjectImpl>
    implements _$$InsertRecipesObjectImplCopyWith<$Res> {
  __$$InsertRecipesObjectImplCopyWithImpl(_$InsertRecipesObjectImpl _value,
      $Res Function(_$InsertRecipesObjectImpl) _then)
      : super(_value, _then);

  /// Create a copy of InsertRecipesObject
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? repId = null,
    Object? type = null,
    Object? docId = null,
    Object? spName = null,
    Object? brand_1 = null,
    Object? address = null,
    Object? phone = null,
    Object? total = null,
    Object? create_date = freezed,
    Object? print_date = freezed,
    Object? flagImage1 = null,
    Object? flagImage2 = null,
    Object? note1 = freezed,
    Object? note2 = freezed,
    Object? note_emp = freezed,
    Object? image1 = freezed,
    Object? image2 = freezed,
    Object? brand_2 = freezed,
    Object? brand_3 = freezed,
    Object? brand_4 = freezed,
  }) {
    return _then(_$InsertRecipesObjectImpl(
      null == repId
          ? _value.repId
          : repId // ignore: cast_nullable_to_non_nullable
              as String,
      null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      null == docId
          ? _value.docId
          : docId // ignore: cast_nullable_to_non_nullable
              as String,
      null == spName
          ? _value.spName
          : spName // ignore: cast_nullable_to_non_nullable
              as String,
      null == brand_1
          ? _value.brand_1
          : brand_1 // ignore: cast_nullable_to_non_nullable
              as BrandRes,
      null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as String,
      freezed == create_date
          ? _value.create_date
          : create_date // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == print_date
          ? _value.print_date
          : print_date // ignore: cast_nullable_to_non_nullable
              as String?,
      null == flagImage1
          ? _value.flagImage1
          : flagImage1 // ignore: cast_nullable_to_non_nullable
              as String,
      null == flagImage2
          ? _value.flagImage2
          : flagImage2 // ignore: cast_nullable_to_non_nullable
              as String,
      freezed == note1
          ? _value.note1
          : note1 // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == note2
          ? _value.note2
          : note2 // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == note_emp
          ? _value.note_emp
          : note_emp // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == image1
          ? _value.image1
          : image1 // ignore: cast_nullable_to_non_nullable
              as File?,
      freezed == image2
          ? _value.image2
          : image2 // ignore: cast_nullable_to_non_nullable
              as File?,
      freezed == brand_2
          ? _value.brand_2
          : brand_2 // ignore: cast_nullable_to_non_nullable
              as BrandRes?,
      freezed == brand_3
          ? _value.brand_3
          : brand_3 // ignore: cast_nullable_to_non_nullable
              as BrandRes?,
      freezed == brand_4
          ? _value.brand_4
          : brand_4 // ignore: cast_nullable_to_non_nullable
              as BrandRes?,
    ));
  }
}

/// @nodoc

class _$InsertRecipesObjectImpl implements _InsertRecipesObject {
  _$InsertRecipesObjectImpl(
      this.repId,
      this.type,
      this.docId,
      this.spName,
      this.brand_1,
      this.address,
      this.phone,
      this.total,
      this.create_date,
      this.print_date,
      this.flagImage1,
      this.flagImage2,
      this.note1,
      this.note2,
      this.note_emp,
      this.image1,
      this.image2,
      this.brand_2,
      this.brand_3,
      this.brand_4);

  @override
  final String repId;
  @override
  final String type;
  @override
  final String docId;
  @override
  final String spName;
  @override
  final BrandRes brand_1;
  @override
  final String address;
  @override
  final String phone;
  @override
  final String total;
  @override
  final String? create_date;
  @override
  final String? print_date;
  @override
  final String flagImage1;
  @override
  final String flagImage2;
  @override
  final String? note1;
  @override
  final String? note2;
  @override
  final String? note_emp;
  @override
  final File? image1;
  @override
  final File? image2;
  @override
  final BrandRes? brand_2;
  @override
  final BrandRes? brand_3;
  @override
  final BrandRes? brand_4;

  @override
  String toString() {
    return 'InsertRecipesObject(repId: $repId, type: $type, docId: $docId, spName: $spName, brand_1: $brand_1, address: $address, phone: $phone, total: $total, create_date: $create_date, print_date: $print_date, flagImage1: $flagImage1, flagImage2: $flagImage2, note1: $note1, note2: $note2, note_emp: $note_emp, image1: $image1, image2: $image2, brand_2: $brand_2, brand_3: $brand_3, brand_4: $brand_4)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InsertRecipesObjectImpl &&
            (identical(other.repId, repId) || other.repId == repId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.docId, docId) || other.docId == docId) &&
            (identical(other.spName, spName) || other.spName == spName) &&
            (identical(other.brand_1, brand_1) || other.brand_1 == brand_1) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.create_date, create_date) ||
                other.create_date == create_date) &&
            (identical(other.print_date, print_date) ||
                other.print_date == print_date) &&
            (identical(other.flagImage1, flagImage1) ||
                other.flagImage1 == flagImage1) &&
            (identical(other.flagImage2, flagImage2) ||
                other.flagImage2 == flagImage2) &&
            (identical(other.note1, note1) || other.note1 == note1) &&
            (identical(other.note2, note2) || other.note2 == note2) &&
            (identical(other.note_emp, note_emp) ||
                other.note_emp == note_emp) &&
            (identical(other.image1, image1) || other.image1 == image1) &&
            (identical(other.image2, image2) || other.image2 == image2) &&
            (identical(other.brand_2, brand_2) || other.brand_2 == brand_2) &&
            (identical(other.brand_3, brand_3) || other.brand_3 == brand_3) &&
            (identical(other.brand_4, brand_4) || other.brand_4 == brand_4));
  }

  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        repId,
        type,
        docId,
        spName,
        brand_1,
        address,
        phone,
        total,
        create_date,
        print_date,
        flagImage1,
        flagImage2,
        note1,
        note2,
        note_emp,
        image1,
        image2,
        brand_2,
        brand_3,
        brand_4
      ]);

  /// Create a copy of InsertRecipesObject
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InsertRecipesObjectImplCopyWith<_$InsertRecipesObjectImpl> get copyWith =>
      __$$InsertRecipesObjectImplCopyWithImpl<_$InsertRecipesObjectImpl>(
          this, _$identity);
}

abstract class _InsertRecipesObject implements InsertRecipesObject {
  factory _InsertRecipesObject(
      final String repId,
      final String type,
      final String docId,
      final String spName,
      final BrandRes brand_1,
      final String address,
      final String phone,
      final String total,
      final String? create_date,
      final String? print_date,
      final String flagImage1,
      final String flagImage2,
      final String? note1,
      final String? note2,
      final String? note_emp,
      final File? image1,
      final File? image2,
      final BrandRes? brand_2,
      final BrandRes? brand_3,
      final BrandRes? brand_4) = _$InsertRecipesObjectImpl;

  @override
  String get repId;
  @override
  String get type;
  @override
  String get docId;
  @override
  String get spName;
  @override
  BrandRes get brand_1;
  @override
  String get address;
  @override
  String get phone;
  @override
  String get total;
  @override
  String? get create_date;
  @override
  String? get print_date;
  @override
  String get flagImage1;
  @override
  String get flagImage2;
  @override
  String? get note1;
  @override
  String? get note2;
  @override
  String? get note_emp;
  @override
  File? get image1;
  @override
  File? get image2;
  @override
  BrandRes? get brand_2;
  @override
  BrandRes? get brand_3;
  @override
  BrandRes? get brand_4;

  /// Create a copy of InsertRecipesObject
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InsertRecipesObjectImplCopyWith<_$InsertRecipesObjectImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
