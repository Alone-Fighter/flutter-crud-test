abstract class Routes{
  Routes._();

  static const String baseUrl = "http://192.168.137.1/PHP-REST-API";

  static const String getData = "$baseUrl/getdata.php";
  static const String postData = "$baseUrl/adddata.php";
  static const String deleteData = "$baseUrl/deleteData.php";
  static const String editData = "$baseUrl/editdata.php";

}