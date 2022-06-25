import 'dart:convert';

import 'package:http/http.dart' as http;

import 'data_class.dart';

class Services {
  Future<List<cData>> getAllData() async {
    final response = await http.get(
      Uri.parse('https://6283762138279cef71d77f41.mockapi.io/api/v1/data2'),
    );

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);

      return jsonResponse.map((data) => cData.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future postData(
    String pName,
    String pAvatar,
    String pAddress,
    String pEmail,
    String pJob,
    String pQuote,
  ) async {
    final response = await http.post(
      Uri.parse('https://6283762138279cef71d77f41.mockapi.io/api/v1/data2'),
      body: {
        'nama': pName,
        'avatar': pAvatar,
        'alamat': pAddress,
        'email': pEmail,
        'pekerjaan': pJob,
        'quote': pQuote,
      },
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      throw Exception('Failed to post data');
    }
  }

  Future<cData> getSingleData(String id) async {
    final response = await http.get(
      Uri.parse('https://6283762138279cef71d77f41.mockapi.io/api/v1/data2/$id'),
    );

    if (response.statusCode == 200) {
      cData jsonResponse = cData.fromJson(json.decode(response.body));
      return jsonResponse;
    } else {
      throw Exception('Failed to get data');
    }
  }

  Future<bool> deleteData(String id) async {
    final response = await http.delete(
      Uri.parse('https://6283762138279cef71d77f41.mockapi.io/api/v1/data2/$id'),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to delete data');
    }
  }
}
