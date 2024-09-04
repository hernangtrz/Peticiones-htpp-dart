import 'dart:convert';
import 'package:http/http.dart' as http;
import 'user.dart'; // Asegúrate de tener el archivo user.dart creado

void main() async {
  // URL de la API de usuarios
  final url = Uri.parse('https://jsonplaceholder.typicode.com/users');

  // Realizar la petición GET
  final response = await http.get(url);

  // Verificar si la petición fue exitosa
  if (response.statusCode == 200) {
    // Parsear la respuesta JSON a una lista
    List<dynamic> jsonData = json.decode(response.body);

    // Crear una lista de User a partir del JSON
    List<User> users = jsonData.map((json) => User.fromJson(json)).toList();

    // Mostrar los datos
    print('Lista completa de usuarios:');
    users.forEach((user) {
      print('ID: ${user.id}');
      print('Nombre: ${user.name}');
      print('Username: ${user.username}');
      print('Email: ${user.email}');
      print('---');
    });

    // Filtrar usuarios cuyo username tenga más de 6 caracteres
    List<User> filteredUsers =
        users.where((user) => user.username.length > 6).toList();
    print('\nUsuarios cuyo username tiene más de 6 caracteres:');
    filteredUsers.forEach((user) => print(user.username));

    // Contar usuarios cuyo email termine en .biz
    int bizDomainCount =
        users.where((user) => user.email.endsWith('.biz')).length;
    print(
        '\nCantidad de usuarios con el dominio .biz en su email: $bizDomainCount');
  } else {
    // Manejo de errores
    print('Error al obtener los datos: ${response.statusCode}');
  }
}
