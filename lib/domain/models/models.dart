import 'dart:io';

class User {
  int id;
  String first_name;
  String last_name;
  String email;
  String whatsapp_number;
  String image;

  User(this.id, this.first_name, this.last_name, this.email,
      this.whatsapp_number, this.image);
}
class SalonCard{
  int id;
  String name;
  SalonCard(this.id, this.name);
}
class Card{
  int id;
  SalonCard? salonCard;

  Card(this.id,this.salonCard, );
}

class ViewAdmin {
  int id;
  String name;
  String salon;
  List<Service>? services;
  List<Product>? products;

  ViewAdmin(this.id, this.name, this.salon, this.services, this.products);
}

class SalonModel {
  int id;
  String name;
  String latitude;
  String longitude;
  String logo_image;
  String description;

  SalonModel(this.id, this.name, this.latitude, this.longitude, this.logo_image,
      this.description);
}
class ShowSalonModel {
  int id;
  String name;
  String latitude;
  String longitude;
  String? logo_image;
  String description;
  String status;
  String admin;
  List<Product>?product;
  List<Employees>? employees;
  ShowSalonModel(this.id, this.name, this.latitude, this.longitude, this.logo_image,
      this.description,this.status, this.admin,{this.employees,this.product});
}
class StoreSalonModel{
  String name;
  String latitude;
  String longitude;
  File logo_image;
  String description;
  String status;

  StoreSalonModel(this.name, this.latitude, this.longitude, this.logo_image,
      this.description, this.status);
}
class Admin {
  String name;
  int id;

  Admin(this.name, this.id);
}

class Service {
  int id;
  String name;
  String description;
  int price;
  String status;
  String date;
  String time;

  Service(this.id, this.name, this.description, this.price, this.status,
      this.date, this.time);
}
class ShowService {
  Service service;
  String employee;
  List<SalonModel>? salons;
  ShowService(this.service, this.employee,this.salons);
}
class ShowProduct{
  int id;
  String name;
  String description;
  int price;
  String image;
  int quantity;
  List<SalonModel>? salons;
  List<Admin>?admins;

  ShowProduct(this.id, this.name, this.description, this.price, this.image,
      this.quantity, this.salons, this.admins);
}
class ShowEmployee {
  int id;
  String name;
  String image;
  int salary;
  Service? service;
  Admin ? admin;
  String salon;


  ShowEmployee(this.id, this.name, this.image, this.salary,
      this.service, this.admin, this.salon);
}
class Product {
  int id;
  String name;
  String description;
  int price;
  String image;
  int quantity;

  Product(this.id, this.name, this.description, this.price, this.image,
      this.quantity);
}
class Employees {
  int id;
  String name;
  String image;
  int salary;
  Employees(this.id, this.name, this.image, this.salary);
}
class AllAdminModel {
  List<Admin> admin;

  AllAdminModel(this.admin);
}

class Token {
  String token;
  Token(this.token);
}

class UpdateUser {
  String? first_name;
  String? last_name;
  String? email;
  String? whatsapp_number;
  String? image;
  UpdateUser(
      {this.first_name,
      this.last_name,
      this.email,
      this.whatsapp_number,
      this.image});
}

class TokenUser {
  String access_token;
  TokenUser(this.access_token);
}
class AppointmentCard {
  int id;
  String date;
  String time;
  AppointmentCard(this.id, this.date, this.time);
}
class ServiceCard {
  int id;
  String name;
  int price;

  ServiceCard(this.id, this.name, this.price);
}
class Appointments{
  int id;
  AppointmentCard? appointment;
  ServiceCard? service;
  SalonCard? salon;
  Appointments(this.id, this.appointment, this.service, this.salon);
}
class AppointmentsBase {
  List<Appointments>? appointments;
  int  totalPrice;
  AppointmentsBase(this.appointments, this.totalPrice);
}
class ShowAppointment  {
  int? id;
  ServiceCard ? service;
  AppointmentCard?appointment;
  SalonCard?salon;

  ShowAppointment(this.id, this.service, this.appointment,
      this.salon);
}
const List<String> status=["active","inactive"];
const List<String> typeAuth=["Super Admin","Admin","Uesr"];