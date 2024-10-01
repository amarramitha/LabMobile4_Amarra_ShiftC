import 'package:flutter/material.dart';
import 'package:tokokita/model/produk.dart';
import 'package:tokokita/ui/produk_form.dart';
import 'dart:math';

class ProdukDetail extends StatefulWidget {
  final Produk? produk;

  ProdukDetail({Key? key, this.produk}) : super(key: key);

  @override
  _ProdukDetailState createState() => _ProdukDetailState();
}

class _ProdukDetailState extends State<ProdukDetail> {
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
          SafeArea(
            child: Center(
              // Centering the content
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Card(
                  color: const Color.fromARGB(255, 211, 183, 232),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 40.0, // Increased vertical padding
                      horizontal: 25.0,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Kode : ${widget.produk!.kodeProduk}",
                          style: const TextStyle(
                            fontSize: 20.0,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Nama : ${widget.produk!.namaProduk}",
                          style: const TextStyle(
                            fontSize: 18.0,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Harga : Rp. ${widget.produk!.hargaProduk.toString()}",
                          style: const TextStyle(
                            fontSize: 18.0,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 20),
                        _tombolHapusEdit(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      appBar: AppBar(
        title: const Text(
          'Detail Produk Amarra',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
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
            color:
                color.withOpacity(0.4), // Reduced opacity for a subtle effect
          ),
        ),
      ),
    );
  }

  // Create Edit and Delete buttons
  Widget _tombolHapusEdit() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center, // Centering buttons
      children: [
        // Edit Button
        OutlinedButton(
          child: const Text("EDIT", style: TextStyle(color: Colors.white)),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProdukForm(
                  produk: widget.produk!,
                ),
              ),
            );
          },
        ),
        const SizedBox(width: 10), // Space between buttons
        // Delete Button
        OutlinedButton(
          child: const Text("DELETE", style: TextStyle(color: Colors.white)),
          onPressed: () => confirmHapus(),
        ),
      ],
    );
  }

  // Confirm delete data
  void confirmHapus() {
    AlertDialog alertDialog = AlertDialog(
      content: const Text(
        "Yakin ingin menghapus data ini?",
        style: TextStyle(color: Colors.black),
      ),
      actions: [
        // Delete button
        OutlinedButton(
          child: const Text("Ya", style: TextStyle(color: Colors.white)),
          onPressed: () {
            // Logic for deleting product
            Navigator.pop(context);
          },
        ),
        // Cancel button
        OutlinedButton(
          child: const Text("Batal", style: TextStyle(color: Colors.white)),
          onPressed: () => Navigator.pop(context),
        ),
      ],
      backgroundColor: const Color.fromARGB(255, 211, 183, 232),
    );
    showDialog(
      context: context,
      builder: (context) => alertDialog,
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
