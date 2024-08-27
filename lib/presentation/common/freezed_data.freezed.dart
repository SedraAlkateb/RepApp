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
mixin _$LoginObject {
  String get userName => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LoginObjectCopyWith<LoginObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginObjectCopyWith<$Res> {
  factory $LoginObjectCopyWith(
          LoginObject value, $Res Function(LoginObject) then) =
      _$LoginObjectCopyWithImpl<$Res, LoginObject>;
  @useResult
  $Res call({String userName, String password});
}

/// @nodoc
class _$LoginObjectCopyWithImpl<$Res, $Val extends LoginObject>
    implements $LoginObjectCopyWith<$Res> {
  _$LoginObjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userName = null,
    Object? password = null,
  }) {
    return _then(_value.copyWith(
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LoginObjectImplCopyWith<$Res>
    implements $LoginObjectCopyWith<$Res> {
  factory _$$LoginObjectImplCopyWith(
          _$LoginObjectImpl value, $Res Function(_$LoginObjectImpl) then) =
      __$$LoginObjectImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String userName, String password});
}

/// @nodoc
class __$$LoginObjectImplCopyWithImpl<$Res>
    extends _$LoginObjectCopyWithImpl<$Res, _$LoginObjectImpl>
    implements _$$LoginObjectImplCopyWith<$Res> {
  __$$LoginObjectImplCopyWithImpl(
      _$LoginObjectImpl _value, $Res Function(_$LoginObjectImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userName = null,
    Object? password = null,
  }) {
    return _then(_$LoginObjectImpl(
      null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$LoginObjectImpl implements _LoginObject {
  _$LoginObjectImpl(this.userName, this.password);

  @override
  final String userName;
  @override
  final String password;

  @override
  String toString() {
    return 'LoginObject(userName: $userName, password: $password)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginObjectImpl &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @override
  int get hashCode => Object.hash(runtimeType, userName, password);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginObjectImplCopyWith<_$LoginObjectImpl> get copyWith =>
      __$$LoginObjectImplCopyWithImpl<_$LoginObjectImpl>(this, _$identity);
}

abstract class _LoginObject implements LoginObject {
  factory _LoginObject(final String userName, final String password) =
      _$LoginObjectImpl;

  @override
  String get userName;
  @override
  String get password;
  @override
  @JsonKey(ignore: true)
  _$$LoginObjectImplCopyWith<_$LoginObjectImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ProfileObject {
  int get user_id => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ProfileObjectCopyWith<ProfileObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileObjectCopyWith<$Res> {
  factory $ProfileObjectCopyWith(
          ProfileObject value, $Res Function(ProfileObject) then) =
      _$ProfileObjectCopyWithImpl<$Res, ProfileObject>;
  @useResult
  $Res call({int user_id});
}

/// @nodoc
class _$ProfileObjectCopyWithImpl<$Res, $Val extends ProfileObject>
    implements $ProfileObjectCopyWith<$Res> {
  _$ProfileObjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user_id = null,
  }) {
    return _then(_value.copyWith(
      user_id: null == user_id
          ? _value.user_id
          : user_id // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProfileObjectImplCopyWith<$Res>
    implements $ProfileObjectCopyWith<$Res> {
  factory _$$ProfileObjectImplCopyWith(
          _$ProfileObjectImpl value, $Res Function(_$ProfileObjectImpl) then) =
      __$$ProfileObjectImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int user_id});
}

/// @nodoc
class __$$ProfileObjectImplCopyWithImpl<$Res>
    extends _$ProfileObjectCopyWithImpl<$Res, _$ProfileObjectImpl>
    implements _$$ProfileObjectImplCopyWith<$Res> {
  __$$ProfileObjectImplCopyWithImpl(
      _$ProfileObjectImpl _value, $Res Function(_$ProfileObjectImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user_id = null,
  }) {
    return _then(_$ProfileObjectImpl(
      null == user_id
          ? _value.user_id
          : user_id // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$ProfileObjectImpl implements _ProfileObject {
  _$ProfileObjectImpl(this.user_id);

  @override
  final int user_id;

  @override
  String toString() {
    return 'ProfileObject(user_id: $user_id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileObjectImpl &&
            (identical(other.user_id, user_id) || other.user_id == user_id));
  }

  @override
  int get hashCode => Object.hash(runtimeType, user_id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfileObjectImplCopyWith<_$ProfileObjectImpl> get copyWith =>
      __$$ProfileObjectImplCopyWithImpl<_$ProfileObjectImpl>(this, _$identity);
}

abstract class _ProfileObject implements ProfileObject {
  factory _ProfileObject(final int user_id) = _$ProfileObjectImpl;

  @override
  int get user_id;
  @override
  @JsonKey(ignore: true)
  _$$ProfileObjectImplCopyWith<_$ProfileObjectImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$SignUpObject {
  int get city_id => throw _privateConstructorUsedError;
  int get area_id => throw _privateConstructorUsedError;
  String get street => throw _privateConstructorUsedError;
  int get subscription_id => throw _privateConstructorUsedError;
  String get firstName => throw _privateConstructorUsedError;
  String get lastName => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;
  String get phoneNumber => throw _privateConstructorUsedError;
  int get transportation_line_id => throw _privateConstructorUsedError;
  int get transfer_position_id => throw _privateConstructorUsedError;
  File? get image => throw _privateConstructorUsedError;
  int get university_id => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SignUpObjectCopyWith<SignUpObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignUpObjectCopyWith<$Res> {
  factory $SignUpObjectCopyWith(
          SignUpObject value, $Res Function(SignUpObject) then) =
      _$SignUpObjectCopyWithImpl<$Res, SignUpObject>;
  @useResult
  $Res call(
      {int city_id,
      int area_id,
      String street,
      int subscription_id,
      String firstName,
      String lastName,
      String email,
      String password,
      String phoneNumber,
      int transportation_line_id,
      int transfer_position_id,
      File? image,
      int university_id});
}

/// @nodoc
class _$SignUpObjectCopyWithImpl<$Res, $Val extends SignUpObject>
    implements $SignUpObjectCopyWith<$Res> {
  _$SignUpObjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? city_id = null,
    Object? area_id = null,
    Object? street = null,
    Object? subscription_id = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? email = null,
    Object? password = null,
    Object? phoneNumber = null,
    Object? transportation_line_id = null,
    Object? transfer_position_id = null,
    Object? image = freezed,
    Object? university_id = null,
  }) {
    return _then(_value.copyWith(
      city_id: null == city_id
          ? _value.city_id
          : city_id // ignore: cast_nullable_to_non_nullable
              as int,
      area_id: null == area_id
          ? _value.area_id
          : area_id // ignore: cast_nullable_to_non_nullable
              as int,
      street: null == street
          ? _value.street
          : street // ignore: cast_nullable_to_non_nullable
              as String,
      subscription_id: null == subscription_id
          ? _value.subscription_id
          : subscription_id // ignore: cast_nullable_to_non_nullable
              as int,
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      transportation_line_id: null == transportation_line_id
          ? _value.transportation_line_id
          : transportation_line_id // ignore: cast_nullable_to_non_nullable
              as int,
      transfer_position_id: null == transfer_position_id
          ? _value.transfer_position_id
          : transfer_position_id // ignore: cast_nullable_to_non_nullable
              as int,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as File?,
      university_id: null == university_id
          ? _value.university_id
          : university_id // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SignUpObjectImplCopyWith<$Res>
    implements $SignUpObjectCopyWith<$Res> {
  factory _$$SignUpObjectImplCopyWith(
          _$SignUpObjectImpl value, $Res Function(_$SignUpObjectImpl) then) =
      __$$SignUpObjectImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int city_id,
      int area_id,
      String street,
      int subscription_id,
      String firstName,
      String lastName,
      String email,
      String password,
      String phoneNumber,
      int transportation_line_id,
      int transfer_position_id,
      File? image,
      int university_id});
}

/// @nodoc
class __$$SignUpObjectImplCopyWithImpl<$Res>
    extends _$SignUpObjectCopyWithImpl<$Res, _$SignUpObjectImpl>
    implements _$$SignUpObjectImplCopyWith<$Res> {
  __$$SignUpObjectImplCopyWithImpl(
      _$SignUpObjectImpl _value, $Res Function(_$SignUpObjectImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? city_id = null,
    Object? area_id = null,
    Object? street = null,
    Object? subscription_id = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? email = null,
    Object? password = null,
    Object? phoneNumber = null,
    Object? transportation_line_id = null,
    Object? transfer_position_id = null,
    Object? image = freezed,
    Object? university_id = null,
  }) {
    return _then(_$SignUpObjectImpl(
      null == city_id
          ? _value.city_id
          : city_id // ignore: cast_nullable_to_non_nullable
              as int,
      null == area_id
          ? _value.area_id
          : area_id // ignore: cast_nullable_to_non_nullable
              as int,
      null == street
          ? _value.street
          : street // ignore: cast_nullable_to_non_nullable
              as String,
      null == subscription_id
          ? _value.subscription_id
          : subscription_id // ignore: cast_nullable_to_non_nullable
              as int,
      null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      null == transportation_line_id
          ? _value.transportation_line_id
          : transportation_line_id // ignore: cast_nullable_to_non_nullable
              as int,
      null == transfer_position_id
          ? _value.transfer_position_id
          : transfer_position_id // ignore: cast_nullable_to_non_nullable
              as int,
      freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as File?,
      null == university_id
          ? _value.university_id
          : university_id // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$SignUpObjectImpl implements _SignUpObject {
  _$SignUpObjectImpl(
      this.city_id,
      this.area_id,
      this.street,
      this.subscription_id,
      this.firstName,
      this.lastName,
      this.email,
      this.password,
      this.phoneNumber,
      this.transportation_line_id,
      this.transfer_position_id,
      this.image,
      this.university_id);

  @override
  final int city_id;
  @override
  final int area_id;
  @override
  final String street;
  @override
  final int subscription_id;
  @override
  final String firstName;
  @override
  final String lastName;
  @override
  final String email;
  @override
  final String password;
  @override
  final String phoneNumber;
  @override
  final int transportation_line_id;
  @override
  final int transfer_position_id;
  @override
  final File? image;
  @override
  final int university_id;

  @override
  String toString() {
    return 'SignUpObject(city_id: $city_id, area_id: $area_id, street: $street, subscription_id: $subscription_id, firstName: $firstName, lastName: $lastName, email: $email, password: $password, phoneNumber: $phoneNumber, transportation_line_id: $transportation_line_id, transfer_position_id: $transfer_position_id, image: $image, university_id: $university_id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignUpObjectImpl &&
            (identical(other.city_id, city_id) || other.city_id == city_id) &&
            (identical(other.area_id, area_id) || other.area_id == area_id) &&
            (identical(other.street, street) || other.street == street) &&
            (identical(other.subscription_id, subscription_id) ||
                other.subscription_id == subscription_id) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.transportation_line_id, transportation_line_id) ||
                other.transportation_line_id == transportation_line_id) &&
            (identical(other.transfer_position_id, transfer_position_id) ||
                other.transfer_position_id == transfer_position_id) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.university_id, university_id) ||
                other.university_id == university_id));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      city_id,
      area_id,
      street,
      subscription_id,
      firstName,
      lastName,
      email,
      password,
      phoneNumber,
      transportation_line_id,
      transfer_position_id,
      image,
      university_id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SignUpObjectImplCopyWith<_$SignUpObjectImpl> get copyWith =>
      __$$SignUpObjectImplCopyWithImpl<_$SignUpObjectImpl>(this, _$identity);
}

abstract class _SignUpObject implements SignUpObject {
  factory _SignUpObject(
      final int city_id,
      final int area_id,
      final String street,
      final int subscription_id,
      final String firstName,
      final String lastName,
      final String email,
      final String password,
      final String phoneNumber,
      final int transportation_line_id,
      final int transfer_position_id,
      final File? image,
      final int university_id) = _$SignUpObjectImpl;

  @override
  int get city_id;
  @override
  int get area_id;
  @override
  String get street;
  @override
  int get subscription_id;
  @override
  String get firstName;
  @override
  String get lastName;
  @override
  String get email;
  @override
  String get password;
  @override
  String get phoneNumber;
  @override
  int get transportation_line_id;
  @override
  int get transfer_position_id;
  @override
  File? get image;
  @override
  int get university_id;
  @override
  @JsonKey(ignore: true)
  _$$SignUpObjectImplCopyWith<_$SignUpObjectImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$UpdateStudentObject {
  int get studentId => throw _privateConstructorUsedError;
  int? get city_id => throw _privateConstructorUsedError;
  int? get area_id => throw _privateConstructorUsedError;
  String? get street => throw _privateConstructorUsedError;
  int? get subscription_id => throw _privateConstructorUsedError;
  String? get firstName => throw _privateConstructorUsedError;
  String? get lastName => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get phoneNumber => throw _privateConstructorUsedError;
  int? get transportation_line_id => throw _privateConstructorUsedError;
  int? get transfer_position_id => throw _privateConstructorUsedError;
  File? get image => throw _privateConstructorUsedError;
  int? get university_id => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UpdateStudentObjectCopyWith<UpdateStudentObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdateStudentObjectCopyWith<$Res> {
  factory $UpdateStudentObjectCopyWith(
          UpdateStudentObject value, $Res Function(UpdateStudentObject) then) =
      _$UpdateStudentObjectCopyWithImpl<$Res, UpdateStudentObject>;
  @useResult
  $Res call(
      {int studentId,
      int? city_id,
      int? area_id,
      String? street,
      int? subscription_id,
      String? firstName,
      String? lastName,
      String? email,
      String? phoneNumber,
      int? transportation_line_id,
      int? transfer_position_id,
      File? image,
      int? university_id});
}

/// @nodoc
class _$UpdateStudentObjectCopyWithImpl<$Res, $Val extends UpdateStudentObject>
    implements $UpdateStudentObjectCopyWith<$Res> {
  _$UpdateStudentObjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? studentId = null,
    Object? city_id = freezed,
    Object? area_id = freezed,
    Object? street = freezed,
    Object? subscription_id = freezed,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? email = freezed,
    Object? phoneNumber = freezed,
    Object? transportation_line_id = freezed,
    Object? transfer_position_id = freezed,
    Object? image = freezed,
    Object? university_id = freezed,
  }) {
    return _then(_value.copyWith(
      studentId: null == studentId
          ? _value.studentId
          : studentId // ignore: cast_nullable_to_non_nullable
              as int,
      city_id: freezed == city_id
          ? _value.city_id
          : city_id // ignore: cast_nullable_to_non_nullable
              as int?,
      area_id: freezed == area_id
          ? _value.area_id
          : area_id // ignore: cast_nullable_to_non_nullable
              as int?,
      street: freezed == street
          ? _value.street
          : street // ignore: cast_nullable_to_non_nullable
              as String?,
      subscription_id: freezed == subscription_id
          ? _value.subscription_id
          : subscription_id // ignore: cast_nullable_to_non_nullable
              as int?,
      firstName: freezed == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: freezed == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      transportation_line_id: freezed == transportation_line_id
          ? _value.transportation_line_id
          : transportation_line_id // ignore: cast_nullable_to_non_nullable
              as int?,
      transfer_position_id: freezed == transfer_position_id
          ? _value.transfer_position_id
          : transfer_position_id // ignore: cast_nullable_to_non_nullable
              as int?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as File?,
      university_id: freezed == university_id
          ? _value.university_id
          : university_id // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UpdateStudentObjectImplCopyWith<$Res>
    implements $UpdateStudentObjectCopyWith<$Res> {
  factory _$$UpdateStudentObjectImplCopyWith(_$UpdateStudentObjectImpl value,
          $Res Function(_$UpdateStudentObjectImpl) then) =
      __$$UpdateStudentObjectImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int studentId,
      int? city_id,
      int? area_id,
      String? street,
      int? subscription_id,
      String? firstName,
      String? lastName,
      String? email,
      String? phoneNumber,
      int? transportation_line_id,
      int? transfer_position_id,
      File? image,
      int? university_id});
}

/// @nodoc
class __$$UpdateStudentObjectImplCopyWithImpl<$Res>
    extends _$UpdateStudentObjectCopyWithImpl<$Res, _$UpdateStudentObjectImpl>
    implements _$$UpdateStudentObjectImplCopyWith<$Res> {
  __$$UpdateStudentObjectImplCopyWithImpl(_$UpdateStudentObjectImpl _value,
      $Res Function(_$UpdateStudentObjectImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? studentId = null,
    Object? city_id = freezed,
    Object? area_id = freezed,
    Object? street = freezed,
    Object? subscription_id = freezed,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? email = freezed,
    Object? phoneNumber = freezed,
    Object? transportation_line_id = freezed,
    Object? transfer_position_id = freezed,
    Object? image = freezed,
    Object? university_id = freezed,
  }) {
    return _then(_$UpdateStudentObjectImpl(
      null == studentId
          ? _value.studentId
          : studentId // ignore: cast_nullable_to_non_nullable
              as int,
      city_id: freezed == city_id
          ? _value.city_id
          : city_id // ignore: cast_nullable_to_non_nullable
              as int?,
      area_id: freezed == area_id
          ? _value.area_id
          : area_id // ignore: cast_nullable_to_non_nullable
              as int?,
      street: freezed == street
          ? _value.street
          : street // ignore: cast_nullable_to_non_nullable
              as String?,
      subscription_id: freezed == subscription_id
          ? _value.subscription_id
          : subscription_id // ignore: cast_nullable_to_non_nullable
              as int?,
      firstName: freezed == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: freezed == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      transportation_line_id: freezed == transportation_line_id
          ? _value.transportation_line_id
          : transportation_line_id // ignore: cast_nullable_to_non_nullable
              as int?,
      transfer_position_id: freezed == transfer_position_id
          ? _value.transfer_position_id
          : transfer_position_id // ignore: cast_nullable_to_non_nullable
              as int?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as File?,
      university_id: freezed == university_id
          ? _value.university_id
          : university_id // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$UpdateStudentObjectImpl implements _UpdateStudentObject {
  _$UpdateStudentObjectImpl(this.studentId,
      {this.city_id,
      this.area_id,
      this.street,
      this.subscription_id,
      this.firstName,
      this.lastName,
      this.email,
      this.phoneNumber,
      this.transportation_line_id,
      this.transfer_position_id,
      this.image,
      this.university_id});

  @override
  final int studentId;
  @override
  final int? city_id;
  @override
  final int? area_id;
  @override
  final String? street;
  @override
  final int? subscription_id;
  @override
  final String? firstName;
  @override
  final String? lastName;
  @override
  final String? email;
  @override
  final String? phoneNumber;
  @override
  final int? transportation_line_id;
  @override
  final int? transfer_position_id;
  @override
  final File? image;
  @override
  final int? university_id;

  @override
  String toString() {
    return 'UpdateStudentObject(studentId: $studentId, city_id: $city_id, area_id: $area_id, street: $street, subscription_id: $subscription_id, firstName: $firstName, lastName: $lastName, email: $email, phoneNumber: $phoneNumber, transportation_line_id: $transportation_line_id, transfer_position_id: $transfer_position_id, image: $image, university_id: $university_id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateStudentObjectImpl &&
            (identical(other.studentId, studentId) ||
                other.studentId == studentId) &&
            (identical(other.city_id, city_id) || other.city_id == city_id) &&
            (identical(other.area_id, area_id) || other.area_id == area_id) &&
            (identical(other.street, street) || other.street == street) &&
            (identical(other.subscription_id, subscription_id) ||
                other.subscription_id == subscription_id) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.transportation_line_id, transportation_line_id) ||
                other.transportation_line_id == transportation_line_id) &&
            (identical(other.transfer_position_id, transfer_position_id) ||
                other.transfer_position_id == transfer_position_id) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.university_id, university_id) ||
                other.university_id == university_id));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      studentId,
      city_id,
      area_id,
      street,
      subscription_id,
      firstName,
      lastName,
      email,
      phoneNumber,
      transportation_line_id,
      transfer_position_id,
      image,
      university_id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateStudentObjectImplCopyWith<_$UpdateStudentObjectImpl> get copyWith =>
      __$$UpdateStudentObjectImplCopyWithImpl<_$UpdateStudentObjectImpl>(
          this, _$identity);
}

abstract class _UpdateStudentObject implements UpdateStudentObject {
  factory _UpdateStudentObject(final int studentId,
      {final int? city_id,
      final int? area_id,
      final String? street,
      final int? subscription_id,
      final String? firstName,
      final String? lastName,
      final String? email,
      final String? phoneNumber,
      final int? transportation_line_id,
      final int? transfer_position_id,
      final File? image,
      final int? university_id}) = _$UpdateStudentObjectImpl;

  @override
  int get studentId;
  @override
  int? get city_id;
  @override
  int? get area_id;
  @override
  String? get street;
  @override
  int? get subscription_id;
  @override
  String? get firstName;
  @override
  String? get lastName;
  @override
  String? get email;
  @override
  String? get phoneNumber;
  @override
  int? get transportation_line_id;
  @override
  int? get transfer_position_id;
  @override
  File? get image;
  @override
  int? get university_id;
  @override
  @JsonKey(ignore: true)
  _$$UpdateStudentObjectImplCopyWith<_$UpdateStudentObjectImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ResetPasswordObject {
  String get email => throw _privateConstructorUsedError;
  int get code => throw _privateConstructorUsedError;
  String get newPassword => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ResetPasswordObjectCopyWith<ResetPasswordObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ResetPasswordObjectCopyWith<$Res> {
  factory $ResetPasswordObjectCopyWith(
          ResetPasswordObject value, $Res Function(ResetPasswordObject) then) =
      _$ResetPasswordObjectCopyWithImpl<$Res, ResetPasswordObject>;
  @useResult
  $Res call({String email, int code, String newPassword});
}

/// @nodoc
class _$ResetPasswordObjectCopyWithImpl<$Res, $Val extends ResetPasswordObject>
    implements $ResetPasswordObjectCopyWith<$Res> {
  _$ResetPasswordObjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? code = null,
    Object? newPassword = null,
  }) {
    return _then(_value.copyWith(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as int,
      newPassword: null == newPassword
          ? _value.newPassword
          : newPassword // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ResetPasswordObjectImplCopyWith<$Res>
    implements $ResetPasswordObjectCopyWith<$Res> {
  factory _$$ResetPasswordObjectImplCopyWith(_$ResetPasswordObjectImpl value,
          $Res Function(_$ResetPasswordObjectImpl) then) =
      __$$ResetPasswordObjectImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String email, int code, String newPassword});
}

/// @nodoc
class __$$ResetPasswordObjectImplCopyWithImpl<$Res>
    extends _$ResetPasswordObjectCopyWithImpl<$Res, _$ResetPasswordObjectImpl>
    implements _$$ResetPasswordObjectImplCopyWith<$Res> {
  __$$ResetPasswordObjectImplCopyWithImpl(_$ResetPasswordObjectImpl _value,
      $Res Function(_$ResetPasswordObjectImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? code = null,
    Object? newPassword = null,
  }) {
    return _then(_$ResetPasswordObjectImpl(
      null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as int,
      null == newPassword
          ? _value.newPassword
          : newPassword // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ResetPasswordObjectImpl implements _ResetPasswordObject {
  _$ResetPasswordObjectImpl(this.email, this.code, this.newPassword);

  @override
  final String email;
  @override
  final int code;
  @override
  final String newPassword;

  @override
  String toString() {
    return 'ResetPasswordObject(email: $email, code: $code, newPassword: $newPassword)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResetPasswordObjectImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.newPassword, newPassword) ||
                other.newPassword == newPassword));
  }

  @override
  int get hashCode => Object.hash(runtimeType, email, code, newPassword);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ResetPasswordObjectImplCopyWith<_$ResetPasswordObjectImpl> get copyWith =>
      __$$ResetPasswordObjectImplCopyWithImpl<_$ResetPasswordObjectImpl>(
          this, _$identity);
}

abstract class _ResetPasswordObject implements ResetPasswordObject {
  factory _ResetPasswordObject(
          final String email, final int code, final String newPassword) =
      _$ResetPasswordObjectImpl;

  @override
  String get email;
  @override
  int get code;
  @override
  String get newPassword;
  @override
  @JsonKey(ignore: true)
  _$$ResetPasswordObjectImplCopyWith<_$ResetPasswordObjectImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$LostItemObject {
  int get tripId => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  File? get image => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LostItemObjectCopyWith<LostItemObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LostItemObjectCopyWith<$Res> {
  factory $LostItemObjectCopyWith(
          LostItemObject value, $Res Function(LostItemObject) then) =
      _$LostItemObjectCopyWithImpl<$Res, LostItemObject>;
  @useResult
  $Res call({int tripId, String description, File? image});
}

/// @nodoc
class _$LostItemObjectCopyWithImpl<$Res, $Val extends LostItemObject>
    implements $LostItemObjectCopyWith<$Res> {
  _$LostItemObjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tripId = null,
    Object? description = null,
    Object? image = freezed,
  }) {
    return _then(_value.copyWith(
      tripId: null == tripId
          ? _value.tripId
          : tripId // ignore: cast_nullable_to_non_nullable
              as int,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as File?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LostItemObjectImplCopyWith<$Res>
    implements $LostItemObjectCopyWith<$Res> {
  factory _$$LostItemObjectImplCopyWith(_$LostItemObjectImpl value,
          $Res Function(_$LostItemObjectImpl) then) =
      __$$LostItemObjectImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int tripId, String description, File? image});
}

/// @nodoc
class __$$LostItemObjectImplCopyWithImpl<$Res>
    extends _$LostItemObjectCopyWithImpl<$Res, _$LostItemObjectImpl>
    implements _$$LostItemObjectImplCopyWith<$Res> {
  __$$LostItemObjectImplCopyWithImpl(
      _$LostItemObjectImpl _value, $Res Function(_$LostItemObjectImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tripId = null,
    Object? description = null,
    Object? image = freezed,
  }) {
    return _then(_$LostItemObjectImpl(
      null == tripId
          ? _value.tripId
          : tripId // ignore: cast_nullable_to_non_nullable
              as int,
      null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as File?,
    ));
  }
}

/// @nodoc

class _$LostItemObjectImpl implements _LostItemObject {
  _$LostItemObjectImpl(this.tripId, this.description, this.image);

  @override
  final int tripId;
  @override
  final String description;
  @override
  final File? image;

  @override
  String toString() {
    return 'LostItemObject(tripId: $tripId, description: $description, image: $image)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LostItemObjectImpl &&
            (identical(other.tripId, tripId) || other.tripId == tripId) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.image, image) || other.image == image));
  }

  @override
  int get hashCode => Object.hash(runtimeType, tripId, description, image);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LostItemObjectImplCopyWith<_$LostItemObjectImpl> get copyWith =>
      __$$LostItemObjectImplCopyWithImpl<_$LostItemObjectImpl>(
          this, _$identity);
}

abstract class _LostItemObject implements LostItemObject {
  factory _LostItemObject(
          final int tripId, final String description, final File? image) =
      _$LostItemObjectImpl;

  @override
  int get tripId;
  @override
  String get description;
  @override
  File? get image;
  @override
  @JsonKey(ignore: true)
  _$$LostItemObjectImplCopyWith<_$LostItemObjectImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$DailyReservationObject {
  int get tripId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get phone => throw _privateConstructorUsedError;
  int get transfer_position_id => throw _privateConstructorUsedError;
  int get seet => throw _privateConstructorUsedError;
  String get fcm_token => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
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

  @JsonKey(ignore: true)
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
  @override
  @JsonKey(ignore: true)
  _$$DailyReservationObjectImplCopyWith<_$DailyReservationObjectImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ChangePasswordObject {
  String get newPassword_confirmation => throw _privateConstructorUsedError;
  String get oldPassword => throw _privateConstructorUsedError;
  String get newPassword => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ChangePasswordObjectCopyWith<ChangePasswordObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChangePasswordObjectCopyWith<$Res> {
  factory $ChangePasswordObjectCopyWith(ChangePasswordObject value,
          $Res Function(ChangePasswordObject) then) =
      _$ChangePasswordObjectCopyWithImpl<$Res, ChangePasswordObject>;
  @useResult
  $Res call(
      {String newPassword_confirmation,
      String oldPassword,
      String newPassword});
}

/// @nodoc
class _$ChangePasswordObjectCopyWithImpl<$Res,
        $Val extends ChangePasswordObject>
    implements $ChangePasswordObjectCopyWith<$Res> {
  _$ChangePasswordObjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? newPassword_confirmation = null,
    Object? oldPassword = null,
    Object? newPassword = null,
  }) {
    return _then(_value.copyWith(
      newPassword_confirmation: null == newPassword_confirmation
          ? _value.newPassword_confirmation
          : newPassword_confirmation // ignore: cast_nullable_to_non_nullable
              as String,
      oldPassword: null == oldPassword
          ? _value.oldPassword
          : oldPassword // ignore: cast_nullable_to_non_nullable
              as String,
      newPassword: null == newPassword
          ? _value.newPassword
          : newPassword // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChangePasswordObjectImplCopyWith<$Res>
    implements $ChangePasswordObjectCopyWith<$Res> {
  factory _$$ChangePasswordObjectImplCopyWith(_$ChangePasswordObjectImpl value,
          $Res Function(_$ChangePasswordObjectImpl) then) =
      __$$ChangePasswordObjectImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String newPassword_confirmation,
      String oldPassword,
      String newPassword});
}

/// @nodoc
class __$$ChangePasswordObjectImplCopyWithImpl<$Res>
    extends _$ChangePasswordObjectCopyWithImpl<$Res, _$ChangePasswordObjectImpl>
    implements _$$ChangePasswordObjectImplCopyWith<$Res> {
  __$$ChangePasswordObjectImplCopyWithImpl(_$ChangePasswordObjectImpl _value,
      $Res Function(_$ChangePasswordObjectImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? newPassword_confirmation = null,
    Object? oldPassword = null,
    Object? newPassword = null,
  }) {
    return _then(_$ChangePasswordObjectImpl(
      null == newPassword_confirmation
          ? _value.newPassword_confirmation
          : newPassword_confirmation // ignore: cast_nullable_to_non_nullable
              as String,
      null == oldPassword
          ? _value.oldPassword
          : oldPassword // ignore: cast_nullable_to_non_nullable
              as String,
      null == newPassword
          ? _value.newPassword
          : newPassword // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ChangePasswordObjectImpl implements _ChangePasswordObject {
  _$ChangePasswordObjectImpl(
      this.newPassword_confirmation, this.oldPassword, this.newPassword);

  @override
  final String newPassword_confirmation;
  @override
  final String oldPassword;
  @override
  final String newPassword;

  @override
  String toString() {
    return 'ChangePasswordObject(newPassword_confirmation: $newPassword_confirmation, oldPassword: $oldPassword, newPassword: $newPassword)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChangePasswordObjectImpl &&
            (identical(
                    other.newPassword_confirmation, newPassword_confirmation) ||
                other.newPassword_confirmation == newPassword_confirmation) &&
            (identical(other.oldPassword, oldPassword) ||
                other.oldPassword == oldPassword) &&
            (identical(other.newPassword, newPassword) ||
                other.newPassword == newPassword));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, newPassword_confirmation, oldPassword, newPassword);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChangePasswordObjectImplCopyWith<_$ChangePasswordObjectImpl>
      get copyWith =>
          __$$ChangePasswordObjectImplCopyWithImpl<_$ChangePasswordObjectImpl>(
              this, _$identity);
}

abstract class _ChangePasswordObject implements ChangePasswordObject {
  factory _ChangePasswordObject(
      final String newPassword_confirmation,
      final String oldPassword,
      final String newPassword) = _$ChangePasswordObjectImpl;

  @override
  String get newPassword_confirmation;
  @override
  String get oldPassword;
  @override
  String get newPassword;
  @override
  @JsonKey(ignore: true)
  _$$ChangePasswordObjectImplCopyWith<_$ChangePasswordObjectImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$CreateSalonObject {
  String get name => throw _privateConstructorUsedError;
  String get desc => throw _privateConstructorUsedError;
  File? get image => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String get lat => throw _privateConstructorUsedError;
  String get lng => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CreateSalonObjectCopyWith<CreateSalonObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateSalonObjectCopyWith<$Res> {
  factory $CreateSalonObjectCopyWith(
          CreateSalonObject value, $Res Function(CreateSalonObject) then) =
      _$CreateSalonObjectCopyWithImpl<$Res, CreateSalonObject>;
  @useResult
  $Res call(
      {String name,
      String desc,
      File? image,
      String status,
      String lat,
      String lng});
}

/// @nodoc
class _$CreateSalonObjectCopyWithImpl<$Res, $Val extends CreateSalonObject>
    implements $CreateSalonObjectCopyWith<$Res> {
  _$CreateSalonObjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? desc = null,
    Object? image = freezed,
    Object? status = null,
    Object? lat = null,
    Object? lng = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      desc: null == desc
          ? _value.desc
          : desc // ignore: cast_nullable_to_non_nullable
              as String,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as File?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      lat: null == lat
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as String,
      lng: null == lng
          ? _value.lng
          : lng // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CreateSalonObjectImplCopyWith<$Res>
    implements $CreateSalonObjectCopyWith<$Res> {
  factory _$$CreateSalonObjectImplCopyWith(_$CreateSalonObjectImpl value,
          $Res Function(_$CreateSalonObjectImpl) then) =
      __$$CreateSalonObjectImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String desc,
      File? image,
      String status,
      String lat,
      String lng});
}

/// @nodoc
class __$$CreateSalonObjectImplCopyWithImpl<$Res>
    extends _$CreateSalonObjectCopyWithImpl<$Res, _$CreateSalonObjectImpl>
    implements _$$CreateSalonObjectImplCopyWith<$Res> {
  __$$CreateSalonObjectImplCopyWithImpl(_$CreateSalonObjectImpl _value,
      $Res Function(_$CreateSalonObjectImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? desc = null,
    Object? image = freezed,
    Object? status = null,
    Object? lat = null,
    Object? lng = null,
  }) {
    return _then(_$CreateSalonObjectImpl(
      null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      null == desc
          ? _value.desc
          : desc // ignore: cast_nullable_to_non_nullable
              as String,
      freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as File?,
      null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      null == lat
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as String,
      null == lng
          ? _value.lng
          : lng // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$CreateSalonObjectImpl implements _CreateSalonObject {
  _$CreateSalonObjectImpl(
      this.name, this.desc, this.image, this.status, this.lat, this.lng);

  @override
  final String name;
  @override
  final String desc;
  @override
  final File? image;
  @override
  final String status;
  @override
  final String lat;
  @override
  final String lng;

  @override
  String toString() {
    return 'CreateSalonObject(name: $name, desc: $desc, image: $image, status: $status, lat: $lat, lng: $lng)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateSalonObjectImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.desc, desc) || other.desc == desc) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.lat, lat) || other.lat == lat) &&
            (identical(other.lng, lng) || other.lng == lng));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, name, desc, image, status, lat, lng);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateSalonObjectImplCopyWith<_$CreateSalonObjectImpl> get copyWith =>
      __$$CreateSalonObjectImplCopyWithImpl<_$CreateSalonObjectImpl>(
          this, _$identity);
}

abstract class _CreateSalonObject implements CreateSalonObject {
  factory _CreateSalonObject(
      final String name,
      final String desc,
      final File? image,
      final String status,
      final String lat,
      final String lng) = _$CreateSalonObjectImpl;

  @override
  String get name;
  @override
  String get desc;
  @override
  File? get image;
  @override
  String get status;
  @override
  String get lat;
  @override
  String get lng;
  @override
  @JsonKey(ignore: true)
  _$$CreateSalonObjectImplCopyWith<_$CreateSalonObjectImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$CreateAdminObject {
  String? get name => throw _privateConstructorUsedError;
  String? get password => throw _privateConstructorUsedError;
  int? get id => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CreateAdminObjectCopyWith<CreateAdminObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateAdminObjectCopyWith<$Res> {
  factory $CreateAdminObjectCopyWith(
          CreateAdminObject value, $Res Function(CreateAdminObject) then) =
      _$CreateAdminObjectCopyWithImpl<$Res, CreateAdminObject>;
  @useResult
  $Res call({String? name, String? password, int? id});
}

/// @nodoc
class _$CreateAdminObjectCopyWithImpl<$Res, $Val extends CreateAdminObject>
    implements $CreateAdminObjectCopyWith<$Res> {
  _$CreateAdminObjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? password = freezed,
    Object? id = freezed,
  }) {
    return _then(_value.copyWith(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      password: freezed == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CreateAdminObjectImplCopyWith<$Res>
    implements $CreateAdminObjectCopyWith<$Res> {
  factory _$$CreateAdminObjectImplCopyWith(_$CreateAdminObjectImpl value,
          $Res Function(_$CreateAdminObjectImpl) then) =
      __$$CreateAdminObjectImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? name, String? password, int? id});
}

/// @nodoc
class __$$CreateAdminObjectImplCopyWithImpl<$Res>
    extends _$CreateAdminObjectCopyWithImpl<$Res, _$CreateAdminObjectImpl>
    implements _$$CreateAdminObjectImplCopyWith<$Res> {
  __$$CreateAdminObjectImplCopyWithImpl(_$CreateAdminObjectImpl _value,
      $Res Function(_$CreateAdminObjectImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? password = freezed,
    Object? id = freezed,
  }) {
    return _then(_$CreateAdminObjectImpl(
      freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$CreateAdminObjectImpl implements _CreateAdminObject {
  _$CreateAdminObjectImpl(this.name, this.password, this.id);

  @override
  final String? name;
  @override
  final String? password;
  @override
  final int? id;

  @override
  String toString() {
    return 'CreateAdminObject(name: $name, password: $password, id: $id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateAdminObjectImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.id, id) || other.id == id));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, password, id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateAdminObjectImplCopyWith<_$CreateAdminObjectImpl> get copyWith =>
      __$$CreateAdminObjectImplCopyWithImpl<_$CreateAdminObjectImpl>(
          this, _$identity);
}

abstract class _CreateAdminObject implements CreateAdminObject {
  factory _CreateAdminObject(
          final String? name, final String? password, final int? id) =
      _$CreateAdminObjectImpl;

  @override
  String? get name;
  @override
  String? get password;
  @override
  int? get id;
  @override
  @JsonKey(ignore: true)
  _$$CreateAdminObjectImplCopyWith<_$CreateAdminObjectImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$CreateServiceObject {
  String get name => throw _privateConstructorUsedError;
  String get desc => throw _privateConstructorUsedError;
  File? get image => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String get price => throw _privateConstructorUsedError;
  int get employeeId => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CreateServiceObjectCopyWith<CreateServiceObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateServiceObjectCopyWith<$Res> {
  factory $CreateServiceObjectCopyWith(
          CreateServiceObject value, $Res Function(CreateServiceObject) then) =
      _$CreateServiceObjectCopyWithImpl<$Res, CreateServiceObject>;
  @useResult
  $Res call(
      {String name,
      String desc,
      File? image,
      String status,
      String price,
      int employeeId});
}

/// @nodoc
class _$CreateServiceObjectCopyWithImpl<$Res, $Val extends CreateServiceObject>
    implements $CreateServiceObjectCopyWith<$Res> {
  _$CreateServiceObjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? desc = null,
    Object? image = freezed,
    Object? status = null,
    Object? price = null,
    Object? employeeId = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      desc: null == desc
          ? _value.desc
          : desc // ignore: cast_nullable_to_non_nullable
              as String,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as File?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as String,
      employeeId: null == employeeId
          ? _value.employeeId
          : employeeId // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CreateServiceObjectImplCopyWith<$Res>
    implements $CreateServiceObjectCopyWith<$Res> {
  factory _$$CreateServiceObjectImplCopyWith(_$CreateServiceObjectImpl value,
          $Res Function(_$CreateServiceObjectImpl) then) =
      __$$CreateServiceObjectImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String desc,
      File? image,
      String status,
      String price,
      int employeeId});
}

/// @nodoc
class __$$CreateServiceObjectImplCopyWithImpl<$Res>
    extends _$CreateServiceObjectCopyWithImpl<$Res, _$CreateServiceObjectImpl>
    implements _$$CreateServiceObjectImplCopyWith<$Res> {
  __$$CreateServiceObjectImplCopyWithImpl(_$CreateServiceObjectImpl _value,
      $Res Function(_$CreateServiceObjectImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? desc = null,
    Object? image = freezed,
    Object? status = null,
    Object? price = null,
    Object? employeeId = null,
  }) {
    return _then(_$CreateServiceObjectImpl(
      null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      null == desc
          ? _value.desc
          : desc // ignore: cast_nullable_to_non_nullable
              as String,
      freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as File?,
      null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as String,
      null == employeeId
          ? _value.employeeId
          : employeeId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$CreateServiceObjectImpl implements _CreateServiceObject {
  _$CreateServiceObjectImpl(this.name, this.desc, this.image, this.status,
      this.price, this.employeeId);

  @override
  final String name;
  @override
  final String desc;
  @override
  final File? image;
  @override
  final String status;
  @override
  final String price;
  @override
  final int employeeId;

  @override
  String toString() {
    return 'CreateServiceObject(name: $name, desc: $desc, image: $image, status: $status, price: $price, employeeId: $employeeId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateServiceObjectImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.desc, desc) || other.desc == desc) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.employeeId, employeeId) ||
                other.employeeId == employeeId));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, name, desc, image, status, price, employeeId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateServiceObjectImplCopyWith<_$CreateServiceObjectImpl> get copyWith =>
      __$$CreateServiceObjectImplCopyWithImpl<_$CreateServiceObjectImpl>(
          this, _$identity);
}

abstract class _CreateServiceObject implements CreateServiceObject {
  factory _CreateServiceObject(
      final String name,
      final String desc,
      final File? image,
      final String status,
      final String price,
      final int employeeId) = _$CreateServiceObjectImpl;

  @override
  String get name;
  @override
  String get desc;
  @override
  File? get image;
  @override
  String get status;
  @override
  String get price;
  @override
  int get employeeId;
  @override
  @JsonKey(ignore: true)
  _$$CreateServiceObjectImplCopyWith<_$CreateServiceObjectImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$CreateEmployeeObject {
  String get name => throw _privateConstructorUsedError;
  String get salary => throw _privateConstructorUsedError;
  File? get image => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CreateEmployeeObjectCopyWith<CreateEmployeeObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateEmployeeObjectCopyWith<$Res> {
  factory $CreateEmployeeObjectCopyWith(CreateEmployeeObject value,
          $Res Function(CreateEmployeeObject) then) =
      _$CreateEmployeeObjectCopyWithImpl<$Res, CreateEmployeeObject>;
  @useResult
  $Res call({String name, String salary, File? image});
}

/// @nodoc
class _$CreateEmployeeObjectCopyWithImpl<$Res,
        $Val extends CreateEmployeeObject>
    implements $CreateEmployeeObjectCopyWith<$Res> {
  _$CreateEmployeeObjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? salary = null,
    Object? image = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      salary: null == salary
          ? _value.salary
          : salary // ignore: cast_nullable_to_non_nullable
              as String,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as File?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CreateEmployeeObjectImplCopyWith<$Res>
    implements $CreateEmployeeObjectCopyWith<$Res> {
  factory _$$CreateEmployeeObjectImplCopyWith(_$CreateEmployeeObjectImpl value,
          $Res Function(_$CreateEmployeeObjectImpl) then) =
      __$$CreateEmployeeObjectImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String salary, File? image});
}

/// @nodoc
class __$$CreateEmployeeObjectImplCopyWithImpl<$Res>
    extends _$CreateEmployeeObjectCopyWithImpl<$Res, _$CreateEmployeeObjectImpl>
    implements _$$CreateEmployeeObjectImplCopyWith<$Res> {
  __$$CreateEmployeeObjectImplCopyWithImpl(_$CreateEmployeeObjectImpl _value,
      $Res Function(_$CreateEmployeeObjectImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? salary = null,
    Object? image = freezed,
  }) {
    return _then(_$CreateEmployeeObjectImpl(
      null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      null == salary
          ? _value.salary
          : salary // ignore: cast_nullable_to_non_nullable
              as String,
      freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as File?,
    ));
  }
}

/// @nodoc

class _$CreateEmployeeObjectImpl implements _CreateEmployeeObject {
  _$CreateEmployeeObjectImpl(this.name, this.salary, this.image);

  @override
  final String name;
  @override
  final String salary;
  @override
  final File? image;

  @override
  String toString() {
    return 'CreateEmployeeObject(name: $name, salary: $salary, image: $image)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateEmployeeObjectImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.salary, salary) || other.salary == salary) &&
            (identical(other.image, image) || other.image == image));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, salary, image);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateEmployeeObjectImplCopyWith<_$CreateEmployeeObjectImpl>
      get copyWith =>
          __$$CreateEmployeeObjectImplCopyWithImpl<_$CreateEmployeeObjectImpl>(
              this, _$identity);
}

abstract class _CreateEmployeeObject implements CreateEmployeeObject {
  factory _CreateEmployeeObject(
          final String name, final String salary, final File? image) =
      _$CreateEmployeeObjectImpl;

  @override
  String get name;
  @override
  String get salary;
  @override
  File? get image;
  @override
  @JsonKey(ignore: true)
  _$$CreateEmployeeObjectImplCopyWith<_$CreateEmployeeObjectImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$CreateProductObject {
  String get name => throw _privateConstructorUsedError;
  String get desc => throw _privateConstructorUsedError;
  File? get image => throw _privateConstructorUsedError;
  String get quantity => throw _privateConstructorUsedError;
  String get price => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CreateProductObjectCopyWith<CreateProductObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateProductObjectCopyWith<$Res> {
  factory $CreateProductObjectCopyWith(
          CreateProductObject value, $Res Function(CreateProductObject) then) =
      _$CreateProductObjectCopyWithImpl<$Res, CreateProductObject>;
  @useResult
  $Res call(
      {String name, String desc, File? image, String quantity, String price});
}

/// @nodoc
class _$CreateProductObjectCopyWithImpl<$Res, $Val extends CreateProductObject>
    implements $CreateProductObjectCopyWith<$Res> {
  _$CreateProductObjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? desc = null,
    Object? image = freezed,
    Object? quantity = null,
    Object? price = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      desc: null == desc
          ? _value.desc
          : desc // ignore: cast_nullable_to_non_nullable
              as String,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as File?,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CreateProductObjectImplCopyWith<$Res>
    implements $CreateProductObjectCopyWith<$Res> {
  factory _$$CreateProductObjectImplCopyWith(_$CreateProductObjectImpl value,
          $Res Function(_$CreateProductObjectImpl) then) =
      __$$CreateProductObjectImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name, String desc, File? image, String quantity, String price});
}

/// @nodoc
class __$$CreateProductObjectImplCopyWithImpl<$Res>
    extends _$CreateProductObjectCopyWithImpl<$Res, _$CreateProductObjectImpl>
    implements _$$CreateProductObjectImplCopyWith<$Res> {
  __$$CreateProductObjectImplCopyWithImpl(_$CreateProductObjectImpl _value,
      $Res Function(_$CreateProductObjectImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? desc = null,
    Object? image = freezed,
    Object? quantity = null,
    Object? price = null,
  }) {
    return _then(_$CreateProductObjectImpl(
      null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      null == desc
          ? _value.desc
          : desc // ignore: cast_nullable_to_non_nullable
              as String,
      freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as File?,
      null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as String,
      null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$CreateProductObjectImpl implements _CreateProductObject {
  _$CreateProductObjectImpl(
      this.name, this.desc, this.image, this.quantity, this.price);

  @override
  final String name;
  @override
  final String desc;
  @override
  final File? image;
  @override
  final String quantity;
  @override
  final String price;

  @override
  String toString() {
    return 'CreateProductObject(name: $name, desc: $desc, image: $image, quantity: $quantity, price: $price)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateProductObjectImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.desc, desc) || other.desc == desc) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.price, price) || other.price == price));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, name, desc, image, quantity, price);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateProductObjectImplCopyWith<_$CreateProductObjectImpl> get copyWith =>
      __$$CreateProductObjectImplCopyWithImpl<_$CreateProductObjectImpl>(
          this, _$identity);
}

abstract class _CreateProductObject implements CreateProductObject {
  factory _CreateProductObject(
      final String name,
      final String desc,
      final File? image,
      final String quantity,
      final String price) = _$CreateProductObjectImpl;

  @override
  String get name;
  @override
  String get desc;
  @override
  File? get image;
  @override
  String get quantity;
  @override
  String get price;
  @override
  @JsonKey(ignore: true)
  _$$CreateProductObjectImplCopyWith<_$CreateProductObjectImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
