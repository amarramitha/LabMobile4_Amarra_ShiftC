import 'dart:convert';
import 'package:tokokita/helpers/api.dart';
import 'package:tokokita/helpers/api_url.dart';
import 'package:tokokita/model/produk.dart';

class ProdukBloc {
  // Mendapatkan daftar produk
  static Future<List<Produk>> getProduks() async {
    String apiUrl = ApiUrl.listProduk;
    var response = await Api().get(apiUrl);

    if (response.statusCode == 200) {
      var jsonObj = json.decode(response.body);
      List<dynamic> listProduk = (jsonObj as Map<String, dynamic>)['data'];
      List<Produk> produks = [];

      for (var item in listProduk) {
        produks.add(Produk.fromJson(item));
      }

      return produks;
    } else {
      throw Exception("Failed to load produk");
    }
  }

  // Menambahkan produk baru
  static Future<bool> addProduk({required Produk produk}) async {
    String apiUrl = ApiUrl.createProduk;

    var body = {
      "kode_produk": produk.kodeProduk,
      "nama_produk": produk.namaProduk,
      "harga": produk.hargaProduk.toString(),
    };

    var response = await Api().post(apiUrl, body);

    if (response.statusCode == 200) {
      var jsonObj = json.decode(response.body);
      return jsonObj['status'];
    } else {
      throw Exception("Failed to add produk");
    }
  }

  // Memperbarui produk yang sudah ada
  static Future<bool> updateProduk({required Produk produk}) async {
    // Pastikan id produk tidak null sebelum memanggil int.parse
    if (produk.id == null) {
      throw Exception("ID produk tidak boleh null");
    }

    String apiUrl = ApiUrl.updateProduk(
        produk.id!); // Jika id adalah int, tidak perlu parse
    print(apiUrl);

    var body = {
      "kode_produk": produk.kodeProduk,
      "nama_produk": produk.namaProduk,
      "harga": produk.hargaProduk.toString(),
    };

    print("Body : $body");
    var response = await Api().put(apiUrl, jsonEncode(body));

    if (response.statusCode == 200) {
      var jsonObj = json.decode(response.body);
      return jsonObj['status'];
    } else {
      throw Exception("Failed to update produk");
    }
  }

  // Menghapus produk
  static Future<bool> deleteProduk({required int id}) async {
    String apiUrl = ApiUrl.deleteProduk(id);
    var response = await Api().delete(apiUrl);

    if (response.statusCode == 200) {
      var jsonObj = json.decode(response.body);
      return (jsonObj as Map<String, dynamic>)['data'];
    } else {
      throw Exception("Failed to delete produk");
    }
  }
}
