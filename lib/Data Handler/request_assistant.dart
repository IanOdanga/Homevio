import 'dart:convert';
import 'package:http/http.dart' as http;

class RequestAssistant{
  static Future<dynamic> getRequest(String url) async{
    http.Response response = await http.get(Uri.https("maps.googleapis.com", "/maps/api/geocode/json?address=1600+Amphitheatre+Parkway,+Mountain+View,+CA&key=YOUR_API_KEY"));

    try
    {
      if (response.statusCode == 200){
        String JsonData = response.body;
        var decodeData = jsonDecode(JsonData);
        return decodeData;
      }
      else
      {
        return "Failed, no response";
      }
    }
    catch (exp)
    {
      return "Failed.";
    }
  }
}