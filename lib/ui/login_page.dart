import 'package:flutter/material.dart';
import 'package:tokokita/ui/registrasi_page.dart';
import 'dart:math';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  final _emailTextboxController = TextEditingController();
  final _passwordTextboxController = TextEditingController();

  Widget _buildInputField(TextEditingController controller, String label,
      bool isSecret, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        obscureText: isSecret,
        style: const TextStyle(color: Color.fromARGB(255, 169, 127, 206)),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          labelText: label,
          labelStyle:
              const TextStyle(color: Color.fromARGB(255, 169, 127, 206)),
          prefixIcon:
              Icon(icon, color: const Color.fromARGB(255, 169, 127, 206)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return '$label harus diisi';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildStar(Offset position, double size, Color color) {
    return Positioned(
      left: position.dx,
      top: position.dy,
      child: Transform.rotate(
        angle: pi / 5,
        child: ClipPath(
          clipper: StarClipper(),
          child: Container(
            width: size,
            height: size,
            color: color.withOpacity(0.4),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Stars in the background
          _buildStar(const Offset(-50, 100), 150, Colors.pinkAccent),
          _buildStar(const Offset(250, 300), 100, Colors.blueAccent),
          _buildStar(const Offset(100, 600), 120, Colors.purpleAccent),
          _buildStar(const Offset(50, 200), 80, Colors.blue),
          _buildStar(const Offset(200, 0), 120,
              const Color.fromARGB(255, 153, 201, 240)),
          _buildStar(const Offset(450, 250), 120,
              const Color.fromARGB(255, 227, 172, 237)),
          _buildStar(const Offset(400, 500), 180,
              const Color.fromARGB(255, 247, 127, 167)),
          // Main content
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'LOGIN',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 170, 119, 218),
                        ),
                      ),
                      const SizedBox(height: 40),
                      _buildInputField(
                          _emailTextboxController, 'Email', false, Icons.email),
                      _buildInputField(_passwordTextboxController, 'Password',
                          true, Icons.lock),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 198, 117, 230),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 15),
                          textStyle: const TextStyle(fontSize: 18),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          'Login',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // Logika saat login berhasil
                          }
                        },
                      ),
                      const SizedBox(height: 30),
                      InkWell(
                        child: const Text(
                          "Registrasi",
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const RegistrasiPage()),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Star clipper for making star shapes
class StarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final numberOfPoints = 5;
    final radius = size.width / 2;

    final double angle = (2 * pi) / numberOfPoints;
    final double halfAngle = angle / 2;

    for (int i = 0; i < numberOfPoints; i++) {
      double x = radius + radius * cos(i * angle);
      double y = radius + radius * sin(i * angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
      // Inner point
      double innerX = radius + (radius / 2.5) * cos(i * angle + halfAngle);
      double innerY = radius + (radius / 2.5) * sin(i * angle + halfAngle);
      path.lineTo(innerX, innerY);
    }

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
