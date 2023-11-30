import 'package:examen_flutter/apis/user_api.dart';
import 'package:examen_flutter/model/userModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CreateUser extends StatefulWidget {
  const CreateUser({super.key});

  @override
  State<CreateUser> createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {
  
  List<UserModel> userList = []; 
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  UserModel? editingUser;
  @override
  void initState() {
    super.initState();
    // Llama a la función para cargar la lista de usuarios al iniciar la pantalla
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
  
  Future<void> createUser() async {
    final String username = usernameController.text;
    final String lastmane = lastnameController.text;
    final String email = emailController.text;


    if (username.isEmpty || email.isEmpty || lastmane.isEmpty) {
      // Puedes mostrar un mensaje de error si los campos están vacíos
      print("Por favor, complete todos los campos");
      return;
    }

    try {
      final api = UserApi.create();
      final newUser = UserModel(
        idUser: 0, // El ID se generará automáticamente en el servidor
        username: username,
        email: email,
        lastname: lastmane, // Puedes dejar los demás campos vacíos o con valores predeterminados
        password: '',
        rol: '',
      );

      final createdUser = await api.createUser(newUser);
      // Vuelve a cargar la lista de usuarios después de crear uno
      await loadUserList();
      // Limpia los campos de entrada después de crear un usuario
      usernameController.clear();
      emailController.clear();
      lastnameController.clear();
    } catch (e) {
      // Manejo de errores, puedes mostrar un mensaje de error si es necesario
      print("Error al crear el usuario: $e");
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
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
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
                        'assets/flecha.svg',
                        height: 25,
                        width: 25,
                        color: Color(0xFF9DA8C3),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 50,
                ),
                Text(
                  'Nuevo Usuario',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xFF243465),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  Text(
                    'Nombre',
                    
                    style: TextStyle(fontSize: 18, color: Color(0xFF243465)),
                  ),
                  TextField(
                    controller: usernameController,
                    style: TextStyle(
                      color: Color(0xFF848A9C),
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(color: Color(0xFFF1F4FF)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(color: Color(0xFF9DA8C3)),
                      ),
                      hintText: "",
                      hintStyle: TextStyle(
                          color: Color(0xFF848A9C),
                          decoration: TextDecoration.none,
                          fontSize: 16,
                          fontWeight: FontWeight.normal),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 14.0,
                          horizontal:
                              16.0), // Ajusta estos valores según tus necesidades
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Apellido',
                    
                    style: TextStyle(fontSize: 18, color: Color(0xFF243465)),
                  ),
                  TextField(
                    controller: lastnameController,
                    style: TextStyle(
                      color: Color(0xFF848A9C),
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(color: Color(0xFFF1F4FF)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(color: Color(0xFF9DA8C3)),
                      ),
                      hintText: "",
                      hintStyle: TextStyle(
                          color: Color(0xFF848A9C),
                          decoration: TextDecoration.none,
                          fontSize: 16,
                          fontWeight: FontWeight.normal),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 14.0,
                          horizontal:
                              16.0), // Ajusta estos valores según tus necesidades
                    ),
                  ),
                  Text(
                    'Correo',
                    
                    style: TextStyle(fontSize: 18, color: Color(0xFF243465)),
                  ),
                  TextField(
                    controller: emailController,
                    style: TextStyle(
                      color: Color(0xFF848A9C),
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(color: Color(0xFFF1F4FF)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(color: Color(0xFF9DA8C3)),
                      ),
                      hintText: "",
                      hintStyle: TextStyle(
                          color: Color(0xFF848A9C),
                          decoration: TextDecoration.none,
                          fontSize: 16,
                          fontWeight: FontWeight.normal),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 14.0,
                          horizontal:
                              16.0), // Ajusta estos valores según tus necesidades
                    ),
                  ),
                  Text(
                    'Contraseña',
                    
                    style: TextStyle(fontSize: 18, color: Color(0xFF243465)),
                  ),
                  TextField(
                    // controller: nameController,
                    style: TextStyle(
                      color: Color(0xFF848A9C),
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(color: Color(0xFFF1F4FF)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(color: Color(0xFF9DA8C3)),
                      ),
                      hintText: "",
                      hintStyle: TextStyle(
                          color: Color(0xFF848A9C),
                          decoration: TextDecoration.none,
                          fontSize: 16,
                          fontWeight: FontWeight.normal),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 14.0,
                          horizontal:
                              16.0), // Ajusta estos valores según tus necesidades
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 52,
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              // onPrimary: Color(0xFF243465), 
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                                side: BorderSide(
                                    color: Color(0xFFC4C8D3),
                                    width: 1), // Añade el borde
                              ),
                              elevation: 0, // Quita la sombra
                              padding: EdgeInsets.symmetric(vertical: 12),
                            ),
                            child: Text(
                              'Cancelar',
                              style: TextStyle(
                                color: Color(0xFF848A9C),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              createUser();
                              Navigator.pop(context);                            
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xFF0961F5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 12),
                            ),
                            child: Text(
                              'Guardar',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}