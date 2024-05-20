import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthManager {
  static Future<bool> isTokenValid(String token) async {
    try {
      // Envie uma solicitação para verificar se o token é válido
      var response = await http.get(
        Uri.parse('http://localhost/brain-box/api/verify_token.php'),
        headers: {'Authorization': 'Bearer $token'},
      );
      
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data['status'] == 'success') {
          return true; // O token é válido
        }
      }
    } catch (e) {
      print("Erro ao verificar token: $e");
    }
    return false; // O token não é válido
  }
}
