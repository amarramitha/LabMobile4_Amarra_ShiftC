import 'package:flutter/material.dart';
import 'package:tokokita/model/produk.dart';
import 'dart:math';

class ProdukForm extends StatefulWidget {
  final Produk? produk;

  ProdukForm({Key? key, this.produk}) : super(key: key);

  @override
  _ProdukFormState createState() => _ProdukFormState();
}

class _ProdukFormState extends State<ProdukForm> {
  final _formKey = GlobalKey<FormState>();
  String tombolSubmit = "SIMPAN";

  final _kodeProdukTextboxController = TextEditingController();
  final _namaProdukTextboxController = TextEditingController();
  final _hargaProdukTextboxController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isUpdate();
  }

  void isUpdate() {
    if (widget.produk != null) {
      setState(() {
        tombolSubmit = "UBAH";
        _kodeProdukTextboxController.text = widget.produk!.kodeProduk!;
        _namaProdukTextboxController.text = widget.produk!.namaProduk!;
        _hargaProdukTextboxController.text =
            widget.produk!.hargaProduk.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.produk == null
                ? 'Tambah Produk Amarra'
                : 'Ubah Produk Amarra',
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
      ),
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
          SafeArea(
            child: Container(
              width: double.infinity,
              height:
                  double.infinity, // Make sure the container takes full height
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _kodeProdukTextField(),
                      const SizedBox(height: 10),
                      _namaProdukTextField(),
                      const SizedBox(height: 10),
                      _hargaProdukTextField(),
                      const SizedBox(height: 20),
                      _buttonSubmit(),
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

  // Create TextBox for Kode Produk
  Widget _kodeProdukTextField() {
    return _buildTextField(
      label: "Kode Produk",
      controller: _kodeProdukTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Kode Produk harus diisi";
        }
        return null;
      },
    );
  }

  // Create TextBox for Nama Produk
  Widget _namaProdukTextField() {
    return _buildTextField(
      label: "Nama Produk",
      controller: _namaProdukTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Nama Produk harus diisi";
        }
        return null;
      },
    );
  }

  // Create TextBox for Harga Produk
  Widget _hargaProdukTextField() {
    return _buildTextField(
      label: "Harga",
      controller: _hargaProdukTextboxController,
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value!.isEmpty) {
          return "Harga harus diisi";
        }
        return null;
      },
    );
  }

  // Create TextField with custom styling
  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white,
        labelStyle: const TextStyle(color: Color.fromARGB(255, 169, 127, 206)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      ),
      keyboardType: keyboardType,
      controller: controller,
      validator: validator,
    );
  }

  // Create Save/Update Button
  Widget _buttonSubmit() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 198, 117, 230),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: Text(tombolSubmit, style: const TextStyle(color: Colors.white)),
      onPressed: () {
        var validate = _formKey.currentState!.validate();
        if (validate) {
          // Logic when data is valid
        }
      },
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
