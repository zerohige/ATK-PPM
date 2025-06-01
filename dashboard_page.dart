import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_page.dart'; // Import LoginPage

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List<Map<String, String>> items = [
    {'id': '1', 'name': 'Barang A', 'stock': '100', 'unit': 'Pcs'},
    {'id': '2', 'name': 'Barang B', 'stock': '50', 'unit': 'Pack'},
    {'id': '3', 'name': 'Barang C', 'stock': '200', 'unit': 'Pcs'},
  ];

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (!isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    }
  }

  // Logout Function
  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false); // Set status login ke false
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ), // Arahkan ke halaman Login
    );
  }

  void _addItem() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Tambah Barang'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(decoration: InputDecoration(labelText: 'Nama Barang')),
            TextField(
              decoration: InputDecoration(labelText: 'Stok'),
              keyboardType: TextInputType.number,
            ),
            TextField(decoration: InputDecoration(labelText: 'Satuan')),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Tambah'),
          ),
        ],
      ),
    );
  }

  void _deleteItem(String id) {
    setState(() {
      items.removeWhere((item) => item['id'] == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard Admin'),
        backgroundColor: Color(0xFF00274D),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            ElevatedButton(
              onPressed: _addItem,
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Colors.blue, // Ganti 'primary' dengan 'backgroundColor'
              ),
              child: Text('Tambah Barang'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _logout, // Menambahkan tombol logout
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Tombol logout berwarna merah
              ),
              child: Text('Logout'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(item['name']!),
                      subtitle: Text('Stok: ${item['stock']} ${item['unit']}'),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteItem(item['id']!),
                      ),
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
