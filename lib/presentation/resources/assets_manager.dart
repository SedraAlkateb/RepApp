const  String imagePath="assets/images";
const  String jsonPath="assets/json";
const  String imageSvgPath="assets/images/svg";
const  String imageSpecPath="assets/images/spec";
const  String imageAsyncPath="assets/images/async";


class ImageAssets{
  static const String d = "$imagePath/d.png";
  static const String domina = "$imagePath/domina.png";
  static const String login = "$imagePath/login.png";
  static const String blue = "$imagePath/blue.jpg";
  static const String doctor = "$imagePath/doctor.png";
  static const String hospital = "$imagePath/hospital.png";
  static const String top = "$imagePath/top.png";
  static const String bottom = "$imagePath/bottom.png";
  static const String doctor2 = "$imagePath/doctor2.png";
  static const String upload = "$imageAsyncPath/upload.png";
  static const String delete = "$imageAsyncPath/delete.png";
  static const String download = "$imageAsyncPath/download.png";

}
class ImageAssetsSpec{
String getImage(int id){
  return "$imageSpecPath/$id.png";
}
}
class JsonAssets{
  static const String error = "$jsonPath/error.json";
  static const String empty = "$jsonPath/empty.json";
  static const String empty1 = "$jsonPath/empty1.json";
  static const String loading1 = "$jsonPath/loading1.json";
  static const String loading2 = "$jsonPath/loading2.json";
  static const String suc2 = "$jsonPath/suc2.json";
  static const String suc = "$jsonPath/suc.json";
  static const String suc1 = "$jsonPath/suc1.json";

}
