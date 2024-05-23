import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class QuoteProvider {

  static const String baseUrl = 'https://quotes15.p.rapidapi.com/quotes/random/';
  static const Map<String, String> headers = {
    'X-RapidAPI-Key': 'be47f5aa41mshc74599795214343p19aa56jsn0aaf9762c441',
    'X-RapidAPI-Host': 'quotes15.p.rapidapi.com',
  };

  Future<Map<String, dynamic>> getRandomQuote() async {
    try {
      final response = await http.get(Uri.parse(baseUrl), headers: headers);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load quote');
      }
    } catch (e) {
      _showToast("something went wrong", Colors.red);
      throw Exception('Failed to load quote: $e');
    }
  }

  void _showToast(String message, Color backgroundColor) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: backgroundColor,
      textColor: Colors.white,
    );
  }
}
