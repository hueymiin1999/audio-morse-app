import 'dart:convert';
import 'package:http/http.dart' as http;

// RestService is a wrapper class implmenting for REST API calls.
//  The class is implemented using the Singleton design pattern.
//  i.e. this class will only be instantiated once
//  TODO: Do nothing on this class except changing the baseUrl

class RestService {
  //------- Here is how we implement 'Singleton pattern' in Dart --------
  static final RestService _instance = RestService._constructor();
  factory RestService() {
    return _instance;
  }

  RestService._constructor();
  //---------------------------- end of singleton implementation

  // TODO: change the baseUrl to your own REST API service hosted on Firebase (or heroku)

  static const String baseUrl =
      //'https://us-central1-beautyfood-app-rest.cloudfunctions.net/api';
      'http://192.168.1.105:105';

  Future get(String endpoint) async {
    final response = await http.get(Uri.parse('$baseUrl/$endpoint'));

    if (response.statusCode == 200) {
      print(response.body);
      return jsonDecode(response.body);
    }
    print(response.body);
    throw response;
  }

  Future post(String endpoint, {dynamic data}) async {
    final response = await http.post(Uri.parse('$baseUrl/$endpoint'),
        headers: {'Content-Type': 'application/json'}, body: jsonEncode(data));

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    }
    throw response;
  }

  Future patch(String endpoint, {dynamic data}) async {
    final response = await http.patch(Uri.parse('$baseUrl/$endpoint'),
        headers: {'Content-Type': 'application/json'}, body: jsonEncode(data));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw response;
  }

  Future delete(String endpoint) async {
    final response = await http.delete(Uri.parse('$baseUrl/$endpoint'));

    if (response.statusCode == 200) {
      return;
    }
    throw response;
  }
}
