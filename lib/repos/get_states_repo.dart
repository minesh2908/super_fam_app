import 'dart:async';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:super_fam_app/model/state_model.dart';

class GetStatesRepo {
  Future<StateModal> getStateList() async {
    try {
      final response = await http.get(
        Uri.parse('https://www.jsonkeeper.com/b/1WOV'),
      );

      if (response.statusCode == 200) {
        log('res: ${response.body}');
        return StateModal.fromJson(response.body);
      } else {
        // Handle non-200 responses

        throw Exception('Something went wrong!');
      }
    } on TimeoutException catch (_) {
      // Handle timeout

      throw Exception('The request timed out. Please try again later.');
    } on http.ClientException catch (e) {
      // Handle client-side errors (e.g., no internet connection)

      throw Exception('Network error occurred: ${e.message}');
    } catch (e) {
      // Handle any other errors

      throw Exception('An unexpected error occurred: $e');
    }
  }
}
