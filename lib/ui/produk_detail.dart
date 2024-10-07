import 'package:flutter/material.dart';
import 'package:tokokita/bloc/produk_bloc.dart';
import 'package:tokokita/model/produk.dart';
import 'package:tokokita/ui/produk_form.dart';
import 'package:tokokita/ui/produk_page.dart';
import 'package:tokokita/widget/warning_dialog.dart';

// ignore: must_be_immutable
class ProdukDetail extends StatefulWidget {
  Produk? produk;

  ProdukDetail({Key? key, this.produk}) : super(key: key);

  @override
  _ProdukDetailState createState() => _ProdukDetailState();
}

class _ProdukDetailState extends State<ProdukDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Produk Amarra'),
        backgroundColor: const Color.fromARGB(255, 240, 132, 231),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 240, 132, 231),
              Color.fromARGB(255, 233, 203, 241),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20), // Spacing at the top
            Text(
              "Kode: ${widget.produk!.kodeProduk}",
              style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(height: 10),
            Text(
              "Nama: ${widget.produk!.namaProduk}",
              style: const TextStyle(fontSize: 20.0, color: Colors.white),
            ),
            const SizedBox(height: 10),
            Text(
              "Harga: Rp. ${widget.produk!.hargaProduk.toString()}",
              style: const TextStyle(fontSize: 20.0, color: Colors.white),
            ),
            const SizedBox(height: 30), // Adding space before the buttons
            _tombolHapusEdit(),
          ],
        ),
      ),
    );
  }

  Widget _tombolHapusEdit() {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.spaceEvenly, // Distributing buttons evenly
      children: [
        // Tombol Edit
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            backgroundColor: const Color.fromARGB(
                255, 240, 132, 231), // Background color for button
            // Menghapus primary untuk mencegah error
          ),
          child: const Text("EDIT",
              style: TextStyle(color: Colors.white)), // Color text explicitly
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
        // Tombol Hapus
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 240, 132, 231),
          ),
          child: const Text("DELETE",
              style: TextStyle(color: Colors.white)), // Color text explicitly
          onPressed: () => confirmHapus(),
        ),
      ],
    );
  }

  void confirmHapus() {
    AlertDialog alertDialog = AlertDialog(
      content: const Text("Yakin ingin menghapus data ini?"),
      actions: [
        // tombol hapus
        OutlinedButton(
          child: const Text("Ya",
              style: TextStyle(color: Color.fromARGB(255, 232, 125, 227))),
          onPressed: () {
            // Pastikan produk.id tidak null
            final id = widget.produk?.id;
            if (id != null) {
              ProdukBloc.deleteProduk(id: id).then(
                (value) => {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ProdukPage()))
                },
                onError: (error) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => const WarningDialog(
                      description: "Hapus gagal, silahkan coba lagi",
                    ),
                  );
                },
              );
            } else {
              // Jika id null, tampilkan pesan error atau penanganan lain
              showDialog(
                context: context,
                builder: (BuildContext context) => const WarningDialog(
                  description: "ID produk tidak ditemukan.",
                ),
              );
            }
          },
        ),
        // tombol batal
        OutlinedButton(
          child: const Text("Batal",
              style: TextStyle(color: Color.fromARGB(255, 232, 125, 227))),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );

    showDialog(builder: (context) => alertDialog, context: context);
  }
}
