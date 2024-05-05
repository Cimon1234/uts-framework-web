// ignore_for_file: use_key_in_widget_constructors, use_super_parameters, deprecated_member_use, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import package intl

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Aksesoris HP',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
        ),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LandingPage(),
        '/home': (context) => const MyHomePage(title: 'Beranda Aplikasi Aksesoris HP'),
      },
    );
  }
}

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selamat Datang'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Selamat datang di Aplikasi Aksesoris HP',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/home');
              },
              child: const Text('Lanjutkan'),
            ),
          ],
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Accessory> accessories = [
    Accessory(name: 'Case Transparan', price: 50, image: 'images/case.png'),
    Accessory(name: 'Earphone Bluetooth', price: 200, image: 'images/earphone.jpeg'),
    Accessory(name: 'Powerbank 10000mAh', price: 150, image: 'images/powerbank.jpeg'),
    Accessory(name: 'Charger USB-C', price: 30, image: 'images/casan.jpg'),
    Accessory(name: 'Smartwatch', price: 300, image: 'images/jam.jpg'),
    Accessory(name: 'Memory Card 64GB', price: 25, image: 'images/memori.jpeg'),
    Accessory(name: 'Selfie Stick', price: 20, image: 'images/tongsis.jpg'),
    Accessory(name: 'Wireless Charger', price: 40, image: 'images/wireles.jpg'),
    Accessory(name: 'Screen Protector', price: 10, image: 'images/screen.jpg'),
    Accessory(name: 'Bluetooth Speaker', price: 80, image: 'images/speaker.jpg'),
    // Tambahkan aksesoris lainnya di sini
  ];

  List<Accessory> cartItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
            },
            icon: Icon(Icons.shopping_cart),
          ),
        ],
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(8.0), // Tambahkan sedikit padding pada grid
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
        ),
        itemCount: accessories.length,
        itemBuilder: (BuildContext context, int index) {
          final numberFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp'); // Format mata uang Rupiah
          return GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Anda ingin membeli ${accessories[index].name}?'),
                    content: Text('Harga: ${numberFormat.format(accessories[index].price)}'), // Tampilkan harga dalam format Rupiah
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Batal'),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            cartItems.add(accessories[index]);
                          });
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('${accessories[index].name} telah ditambahkan ke keranjang.'),
                            duration: Duration(seconds: 2),
                          ));
                        },
                        child: const Text('Tambah ke Keranjang'),
                      ),
                    ],
                  );
                },
              );
            },
            child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    accessories[index].image,
                    width: 120, // Perbesar ukuran gambar
                    height: 120, // Perbesar ukuran gambar
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 8),
                  Text(
                    accessories[index].name,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    numberFormat.format(accessories[index].price), // Tampilkan harga dalam format Rupiah
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class Accessory {
  final String name;
  final int price;
  final String image;

  Accessory({required this.name, required this.price, required this.image});
}