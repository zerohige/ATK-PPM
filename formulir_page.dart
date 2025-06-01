import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:signature/signature.dart'; // Pastikan untuk menambahkan dependensi signature pad

class FormulirPage extends StatefulWidget {
  @override
  _FormulirPageState createState() => _FormulirPageState();
}

class _FormulirPageState extends State<FormulirPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _teleponController = TextEditingController();
  final TextEditingController _catatanController = TextEditingController();
  final SignatureController _signatureController = SignatureController(
    penColor: Colors.black,
    penStrokeWidth: 5,
  );

  String _departemen = '';
  String _barang = '';
  String _satuan = 'pcs';
  int _jumlah = 1;

  List<String> _departemenOptions = [
    'Mahasiswa TI',
    'Mahasiswa TE',
    'Mahasiswa TP',
    'Mahasiswa lainnya',
    'Dosen',
    'Tenaga Pengajar',
    'Staff TU',
  ];

  List<String> _barangOptions = [
    'Pensil',
    'Pulpen',
    'Kertas A4',
    'Penghapus',
    'Stapler',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulir Permintaan Barang'),
        backgroundColor: Color(0xFF00274D),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Nama Pemohon
                Text(
                  'Nama:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                TextFormField(
                  controller: _namaController,
                  decoration: InputDecoration(
                    hintText: 'Masukkan Nama',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: 16.0,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nama wajib diisi';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15),

                // Departemen Pemohon
                Text(
                  'Departemen:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                DropdownButtonFormField<String>(
                  value: _departemen.isEmpty ? null : _departemen,
                  items: _departemenOptions.map((String dep) {
                    return DropdownMenuItem<String>(
                      value: dep,
                      child: Text(dep),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _departemen = value!;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: 16.0,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Pilih Departemen';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15),

                // Nomor Telepon
                Text(
                  'Nomor Telepon:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                TextFormField(
                  controller: _teleponController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: 'Masukkan Nomor Telepon',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: 16.0,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nomor telepon wajib diisi';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15),

                // Barang yang Diminta
                Text(
                  'Barang yang Diminta:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                DropdownButtonFormField<String>(
                  value: _barang.isEmpty ? null : _barang,
                  items: _barangOptions.map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _barang = value!;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: 16.0,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Pilih barang yang diminta';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15),

                // Jumlah Barang
                Text(
                  'Jumlah Barang:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                TextFormField(
                  initialValue: '1',
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Masukkan Jumlah Barang',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: 16.0,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Jumlah barang wajib diisi';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _jumlah = int.tryParse(value) ?? 1;
                    });
                  },
                ),
                SizedBox(height: 15),

                // Satuan Barang
                Text(
                  'Satuan Barang:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                DropdownButtonFormField<String>(
                  value: _satuan,
                  items: ['pcs', 'pack'].map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _satuan = value!;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: 16.0,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Pilih satuan barang';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15),

                // Catatan Pemohon
                Text(
                  'Catatan Pemohon (maks. 25 karakter):',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                TextFormField(
                  controller: _catatanController,
                  maxLength: 25,
                  decoration: InputDecoration(
                    hintText: 'Masukkan Catatan',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: 16.0,
                    ),
                  ),
                ),
                SizedBox(height: 20),

                // Tanda Tangan Digital
                Text(
                  'Tanda Tangan:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Signature(
                  controller: _signatureController,
                  height: 150,
                  backgroundColor: Colors.grey[200]!,
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    _signatureController.clear();
                  },
                  child: Text('Hapus Tanda Tangan'),
                ),
                SizedBox(height: 20),

                // Submit Button
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Simpan data atau kirim ke server
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Formulir berhasil dikirim!')),
                        );
                      }
                    },
                    child: Text('Kirim Permintaan'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF007bff),
                      padding: EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 30,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
