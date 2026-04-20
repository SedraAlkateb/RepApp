// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'freezed_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DailyReservationObject {
  int get tripId;
  String get name;
  int get phone;
  int get transfer_position_id;
  int get seet;
  String get fcm_token;

  /// Create a copy of DailyReservationObject
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DailyReservationObjectCopyWith<DailyReservationObject> get copyWith =>
      _$DailyReservationObjectCopyWithImpl<DailyReservationObject>(
          this as DailyReservationObject, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DailyReservationObject &&
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

  @override
  String toString() {
    return 'DailyReservationObject(tripId: $tripId, name: $name, phone: $phone, transfer_position_id: $transfer_position_id, seet: $seet, fcm_token: $fcm_token)';
  }
}

/// @nodoc
abstract mixin class $DailyReservationObjectCopyWith<$Res> {
  factory $DailyReservationObjectCopyWith(DailyReservationObject value,
          $Res Function(DailyReservationObject) _then) =
      _$DailyReservationObjectCopyWithImpl;
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
class _$DailyReservationObjectCopyWithImpl<$Res>
    implements $DailyReservationObjectCopyWith<$Res> {
  _$DailyReservationObjectCopyWithImpl(this._self, this._then);

  final DailyReservationObject _self;
  final $Res Function(DailyReservationObject) _then;

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
    return _then(_self.copyWith(
      tripId: null == tripId
          ? _self.tripId
          : tripId // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _self.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as int,
      transfer_position_id: null == transfer_position_id
          ? _self.transfer_position_id
          : transfer_position_id // ignore: cast_nullable_to_non_nullable
              as int,
      seet: null == seet
          ? _self.seet
          : seet // ignore: cast_nullable_to_non_nullable
              as int,
      fcm_token: null == fcm_token
          ? _self.fcm_token
          : fcm_token // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [DailyReservationObject].
extension DailyReservationObjectPatterns on DailyReservationObject {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_DailyReservationObject value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DailyReservationObject() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_DailyReservationObject value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DailyReservationObject():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_DailyReservationObject value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DailyReservationObject() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(int tripId, String name, int phone,
            int transfer_position_id, int seet, String fcm_token)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DailyReservationObject() when $default != null:
        return $default(_that.tripId, _that.name, _that.phone,
            _that.transfer_position_id, _that.seet, _that.fcm_token);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(int tripId, String name, int phone,
            int transfer_position_id, int seet, String fcm_token)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DailyReservationObject():
        return $default(_that.tripId, _that.name, _that.phone,
            _that.transfer_position_id, _that.seet, _that.fcm_token);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(int tripId, String name, int phone,
            int transfer_position_id, int seet, String fcm_token)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DailyReservationObject() when $default != null:
        return $default(_that.tripId, _that.name, _that.phone,
            _that.transfer_position_id, _that.seet, _that.fcm_token);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _DailyReservationObject implements DailyReservationObject {
  _DailyReservationObject(this.tripId, this.name, this.phone,
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

  /// Create a copy of DailyReservationObject
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DailyReservationObjectCopyWith<_DailyReservationObject> get copyWith =>
      __$DailyReservationObjectCopyWithImpl<_DailyReservationObject>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DailyReservationObject &&
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

  @override
  String toString() {
    return 'DailyReservationObject(tripId: $tripId, name: $name, phone: $phone, transfer_position_id: $transfer_position_id, seet: $seet, fcm_token: $fcm_token)';
  }
}

/// @nodoc
abstract mixin class _$DailyReservationObjectCopyWith<$Res>
    implements $DailyReservationObjectCopyWith<$Res> {
  factory _$DailyReservationObjectCopyWith(_DailyReservationObject value,
          $Res Function(_DailyReservationObject) _then) =
      __$DailyReservationObjectCopyWithImpl;
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
class __$DailyReservationObjectCopyWithImpl<$Res>
    implements _$DailyReservationObjectCopyWith<$Res> {
  __$DailyReservationObjectCopyWithImpl(this._self, this._then);

  final _DailyReservationObject _self;
  final $Res Function(_DailyReservationObject) _then;

  /// Create a copy of DailyReservationObject
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? tripId = null,
    Object? name = null,
    Object? phone = null,
    Object? transfer_position_id = null,
    Object? seet = null,
    Object? fcm_token = null,
  }) {
    return _then(_DailyReservationObject(
      null == tripId
          ? _self.tripId
          : tripId // ignore: cast_nullable_to_non_nullable
              as int,
      null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      null == phone
          ? _self.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as int,
      null == transfer_position_id
          ? _self.transfer_position_id
          : transfer_position_id // ignore: cast_nullable_to_non_nullable
              as int,
      null == seet
          ? _self.seet
          : seet // ignore: cast_nullable_to_non_nullable
              as int,
      null == fcm_token
          ? _self.fcm_token
          : fcm_token // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$InsertRecipesObject {
  String get repId;
  String get type;
  String get docId;
  String get spName;
  BrandRes get brand_1;
  String get address;
  String get phone;
  String get total;
  String? get create_date;
  String? get print_date;
  String get flagImage1;
  String get flagImage2;
  String? get note1;
  String? get note2;
  String? get note_emp;
  File? get image1;
  File? get image2;
  BrandRes? get brand_2;
  BrandRes? get brand_3;
  BrandRes? get brand_4;

  /// Create a copy of InsertRecipesObject
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $InsertRecipesObjectCopyWith<InsertRecipesObject> get copyWith =>
      _$InsertRecipesObjectCopyWithImpl<InsertRecipesObject>(
          this as InsertRecipesObject, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is InsertRecipesObject &&
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

  @override
  String toString() {
    return 'InsertRecipesObject(repId: $repId, type: $type, docId: $docId, spName: $spName, brand_1: $brand_1, address: $address, phone: $phone, total: $total, create_date: $create_date, print_date: $print_date, flagImage1: $flagImage1, flagImage2: $flagImage2, note1: $note1, note2: $note2, note_emp: $note_emp, image1: $image1, image2: $image2, brand_2: $brand_2, brand_3: $brand_3, brand_4: $brand_4)';
  }
}

/// @nodoc
abstract mixin class $InsertRecipesObjectCopyWith<$Res> {
  factory $InsertRecipesObjectCopyWith(
          InsertRecipesObject value, $Res Function(InsertRecipesObject) _then) =
      _$InsertRecipesObjectCopyWithImpl;
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
class _$InsertRecipesObjectCopyWithImpl<$Res>
    implements $InsertRecipesObjectCopyWith<$Res> {
  _$InsertRecipesObjectCopyWithImpl(this._self, this._then);

  final InsertRecipesObject _self;
  final $Res Function(InsertRecipesObject) _then;

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
    return _then(_self.copyWith(
      repId: null == repId
          ? _self.repId
          : repId // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      docId: null == docId
          ? _self.docId
          : docId // ignore: cast_nullable_to_non_nullable
              as String,
      spName: null == spName
          ? _self.spName
          : spName // ignore: cast_nullable_to_non_nullable
              as String,
      brand_1: null == brand_1
          ? _self.brand_1
          : brand_1 // ignore: cast_nullable_to_non_nullable
              as BrandRes,
      address: null == address
          ? _self.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _self.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      total: null == total
          ? _self.total
          : total // ignore: cast_nullable_to_non_nullable
              as String,
      create_date: freezed == create_date
          ? _self.create_date
          : create_date // ignore: cast_nullable_to_non_nullable
              as String?,
      print_date: freezed == print_date
          ? _self.print_date
          : print_date // ignore: cast_nullable_to_non_nullable
              as String?,
      flagImage1: null == flagImage1
          ? _self.flagImage1
          : flagImage1 // ignore: cast_nullable_to_non_nullable
              as String,
      flagImage2: null == flagImage2
          ? _self.flagImage2
          : flagImage2 // ignore: cast_nullable_to_non_nullable
              as String,
      note1: freezed == note1
          ? _self.note1
          : note1 // ignore: cast_nullable_to_non_nullable
              as String?,
      note2: freezed == note2
          ? _self.note2
          : note2 // ignore: cast_nullable_to_non_nullable
              as String?,
      note_emp: freezed == note_emp
          ? _self.note_emp
          : note_emp // ignore: cast_nullable_to_non_nullable
              as String?,
      image1: freezed == image1
          ? _self.image1
          : image1 // ignore: cast_nullable_to_non_nullable
              as File?,
      image2: freezed == image2
          ? _self.image2
          : image2 // ignore: cast_nullable_to_non_nullable
              as File?,
      brand_2: freezed == brand_2
          ? _self.brand_2
          : brand_2 // ignore: cast_nullable_to_non_nullable
              as BrandRes?,
      brand_3: freezed == brand_3
          ? _self.brand_3
          : brand_3 // ignore: cast_nullable_to_non_nullable
              as BrandRes?,
      brand_4: freezed == brand_4
          ? _self.brand_4
          : brand_4 // ignore: cast_nullable_to_non_nullable
              as BrandRes?,
    ));
  }
}

/// Adds pattern-matching-related methods to [InsertRecipesObject].
extension InsertRecipesObjectPatterns on InsertRecipesObject {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_InsertRecipesObject value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _InsertRecipesObject() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_InsertRecipesObject value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _InsertRecipesObject():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_InsertRecipesObject value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _InsertRecipesObject() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String repId,
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
            BrandRes? brand_4)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _InsertRecipesObject() when $default != null:
        return $default(
            _that.repId,
            _that.type,
            _that.docId,
            _that.spName,
            _that.brand_1,
            _that.address,
            _that.phone,
            _that.total,
            _that.create_date,
            _that.print_date,
            _that.flagImage1,
            _that.flagImage2,
            _that.note1,
            _that.note2,
            _that.note_emp,
            _that.image1,
            _that.image2,
            _that.brand_2,
            _that.brand_3,
            _that.brand_4);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String repId,
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
            BrandRes? brand_4)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _InsertRecipesObject():
        return $default(
            _that.repId,
            _that.type,
            _that.docId,
            _that.spName,
            _that.brand_1,
            _that.address,
            _that.phone,
            _that.total,
            _that.create_date,
            _that.print_date,
            _that.flagImage1,
            _that.flagImage2,
            _that.note1,
            _that.note2,
            _that.note_emp,
            _that.image1,
            _that.image2,
            _that.brand_2,
            _that.brand_3,
            _that.brand_4);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String repId,
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
            BrandRes? brand_4)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _InsertRecipesObject() when $default != null:
        return $default(
            _that.repId,
            _that.type,
            _that.docId,
            _that.spName,
            _that.brand_1,
            _that.address,
            _that.phone,
            _that.total,
            _that.create_date,
            _that.print_date,
            _that.flagImage1,
            _that.flagImage2,
            _that.note1,
            _that.note2,
            _that.note_emp,
            _that.image1,
            _that.image2,
            _that.brand_2,
            _that.brand_3,
            _that.brand_4);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _InsertRecipesObject implements InsertRecipesObject {
  _InsertRecipesObject(
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

  /// Create a copy of InsertRecipesObject
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$InsertRecipesObjectCopyWith<_InsertRecipesObject> get copyWith =>
      __$InsertRecipesObjectCopyWithImpl<_InsertRecipesObject>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _InsertRecipesObject &&
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

  @override
  String toString() {
    return 'InsertRecipesObject(repId: $repId, type: $type, docId: $docId, spName: $spName, brand_1: $brand_1, address: $address, phone: $phone, total: $total, create_date: $create_date, print_date: $print_date, flagImage1: $flagImage1, flagImage2: $flagImage2, note1: $note1, note2: $note2, note_emp: $note_emp, image1: $image1, image2: $image2, brand_2: $brand_2, brand_3: $brand_3, brand_4: $brand_4)';
  }
}

/// @nodoc
abstract mixin class _$InsertRecipesObjectCopyWith<$Res>
    implements $InsertRecipesObjectCopyWith<$Res> {
  factory _$InsertRecipesObjectCopyWith(_InsertRecipesObject value,
          $Res Function(_InsertRecipesObject) _then) =
      __$InsertRecipesObjectCopyWithImpl;
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
class __$InsertRecipesObjectCopyWithImpl<$Res>
    implements _$InsertRecipesObjectCopyWith<$Res> {
  __$InsertRecipesObjectCopyWithImpl(this._self, this._then);

  final _InsertRecipesObject _self;
  final $Res Function(_InsertRecipesObject) _then;

  /// Create a copy of InsertRecipesObject
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
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
    return _then(_InsertRecipesObject(
      null == repId
          ? _self.repId
          : repId // ignore: cast_nullable_to_non_nullable
              as String,
      null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      null == docId
          ? _self.docId
          : docId // ignore: cast_nullable_to_non_nullable
              as String,
      null == spName
          ? _self.spName
          : spName // ignore: cast_nullable_to_non_nullable
              as String,
      null == brand_1
          ? _self.brand_1
          : brand_1 // ignore: cast_nullable_to_non_nullable
              as BrandRes,
      null == address
          ? _self.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      null == phone
          ? _self.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      null == total
          ? _self.total
          : total // ignore: cast_nullable_to_non_nullable
              as String,
      freezed == create_date
          ? _self.create_date
          : create_date // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == print_date
          ? _self.print_date
          : print_date // ignore: cast_nullable_to_non_nullable
              as String?,
      null == flagImage1
          ? _self.flagImage1
          : flagImage1 // ignore: cast_nullable_to_non_nullable
              as String,
      null == flagImage2
          ? _self.flagImage2
          : flagImage2 // ignore: cast_nullable_to_non_nullable
              as String,
      freezed == note1
          ? _self.note1
          : note1 // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == note2
          ? _self.note2
          : note2 // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == note_emp
          ? _self.note_emp
          : note_emp // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == image1
          ? _self.image1
          : image1 // ignore: cast_nullable_to_non_nullable
              as File?,
      freezed == image2
          ? _self.image2
          : image2 // ignore: cast_nullable_to_non_nullable
              as File?,
      freezed == brand_2
          ? _self.brand_2
          : brand_2 // ignore: cast_nullable_to_non_nullable
              as BrandRes?,
      freezed == brand_3
          ? _self.brand_3
          : brand_3 // ignore: cast_nullable_to_non_nullable
              as BrandRes?,
      freezed == brand_4
          ? _self.brand_4
          : brand_4 // ignore: cast_nullable_to_non_nullable
              as BrandRes?,
    ));
  }
}

// dart format on
