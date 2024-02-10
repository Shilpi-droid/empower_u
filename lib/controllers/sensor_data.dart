import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';

class DistanceDataProvider extends ChangeNotifier {
  Timer? _timer;
  int? _distance;
  int? get distance => _distance;

  void startListeningToDistance() {
    print("===================================================");
    print("Called");
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      fetchDataFromAPI();
    });
  }

  void stopListeningToDistance() {
    _timer?.cancel();
  }

  Future<void> fetchDataFromAPI() async {
    print("===================================================");
    print("Fetch");
    final apiUrl = Uri.parse('https://a714-157-32-86-98.ngrok-free.app/data');

    try {
      final response = await http.get(apiUrl);

      if (response.statusCode == 200) {
        final List<int> distances = parseDistanceFromResponse(response.body);
        if (distances.isNotEmpty) {
          _distance = distances.first;
          notifyListeners(); // Notify listeners of the change
        }
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (error) {
      throw Exception('Error in fetch: $error');
    }
  }

  List<int> parseDistanceFromResponse(String responseBody) {
    print("===================================================");
    print("Parse");
    try {
      print("===================================================");
      print(responseBody);
      final List<dynamic> jsonResponseList = jsonDecode(responseBody);
      final List<int> distances = jsonResponseList.map((data) => data['distance_cm'] as int).toList();
      print("distance array");
      if (distances.isNotEmpty) {
        _distance = distances.last;
        if (_distance != null && distances.any((distance) => distance < 100)) {
          Vibration.vibrate();
        }
        notifyListeners(); // Notify listeners of the change
      }
      print(distances);

      return distances;
    } catch (error) {
      throw Exception('Error parsing API response: $error');
    }
  }
}
