import 'package:examen_flutter/apis/user_api.dart';
import 'package:examen_flutter/model/userModel.dart';
import 'package:examen_flutter/ui/createUser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter/material.dart';

class UserConten extends StatefulWidget {
  const UserConten({super.key});

  @override
  State<UserConten> createState() => _UserContenState();
}

class _UserContenState extends State<UserConten> {
  List<UserModel> userList = [];
  @override
  void initState() {
    super.initState();
    loadUserList();
  }

  Future<void> loadUserList() async {
    try {
      // Utiliza la clase UserApi para obtener la lista de usuarios
      final api = UserApi.create();
      final users = await api.listUsers();
      setState(() {
        userList = users;
      });
    } catch (e) {
      // Manejo de errores, puedes mostrar un mensaje de error si es necesario
      print("Error al cargar la lista de usuarios: $e");
    }
  }

  Future<void> deleteUser(int userId) async {
    try {
      final api = UserApi.create();
      await api.deleteUser(userId);
      // Vuelve a cargar la lista de usuarios después de eliminar uno
      await loadUserList();
    } catch (e) {
      // Manejo de errores, puedes mostrar un mensaje de error si es necesario
      print("Error al eliminar el usuario: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.fromLTRB(16, 40, 16, 0),
        child: Column(
          children: [
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    loadUserList();
                  },
                  child: Container(
                    // margin: EdgeInsets.fromLTRB(0,10,0,10),
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                      // color: Color(0xFFF2F8FF),
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                        color: Color(0xFFF1F4FF),
                        width: 1.0,
                      ),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        'assets/gira.svg',
                        height: 25,
                        width: 25,
                        color: Color(0xFF9DA8C3),
                      ),
                    ),
                  ),
                ),
                Text(
                  'Usuarios',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xFF243465),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreateUser()));
                  },
                  child: Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                      // color: Color(0xFFF2F8FF),
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                        color: Color(0xFFF1F4FF),
                        width: 1.0,
                      ),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        'assets/mas.svg',
                        height: 20,
                        width: 20,
                        color: Color(0xFF9DA8C3),
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 15),
            userList.isEmpty
                ? Center(
                    child:
                        CircularProgressIndicator()) // Muestra un indicador de carga si la lista está vacía
                : Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: userList.length,
                      itemBuilder: (context, index) {
                        final user = userList[index];
                        return ListTile(
                          title: Text(
                            user.username,
                            style: TextStyle(
                              color: Color(0xFF243465),
                              fontSize: 20,
                            ),
                          ),
                          subtitle: Text(user.email),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  // editUser(user);
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  // Mostrar un diálogo de confirmación antes de eliminar
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text('Eliminar Usuario'),
                                        content: Text(
                                            '¿Estás seguro de que deseas eliminar este usuario?'),
                                        actions: [
                                          TextButton(
                                            child: Text('Cancelar'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          TextButton(
                                            child: Text('Eliminar'),
                                            onPressed: () {
                                              // Llama a la función para eliminar el usuario
                                              deleteUser(user.idUser);
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
