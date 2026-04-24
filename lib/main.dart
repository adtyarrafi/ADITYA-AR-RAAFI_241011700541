import 'package:flutter/material.dart';
import 'package:pert4/page/beranda_page.dart';
import 'package:pert4/page/profile_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Index halaman yang aktif
  int _currentIndex = 0;

  // Data utama aplikasi (State)
  Map<String, dynamic> profileData = {
    'nama': 'Aditya Ar Raafi',
    'lokasi': 'Jakarta, Indonesia',
    'role': 'Informatika',
    'project': '10',
    'followers': '1200',
    'summary': 'Lulusan SMKN 1 Jakarta jurusan Teknik Informatika.',
    'bgUrl': 'ganteng.jpeg',
    'profileUrl': 'ganteng.jpeg',
    'experience': [],
    'education': ['SMKN 1 Jakarta - TKJ'],
  };

  @override
  Widget build(BuildContext context) {
    // List halaman yang akan ditampilkan di Navbar
    final List<Widget> pages = [
      BerandaPage(
        onUpdate: (newData) => setState(() => profileData = newData),
        onDelete: () => setState(() {
          profileData = {
            'nama': '', 'lokasi': '', 'role': '', 'project': '0', 'followers': '0',
            'summary': '', 'bgUrl': '', 'profileUrl': '',
            'experience': [], 'education': [],
          };
        }),
      ),
      ProfilePage(data: profileData),
    ];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: pages[_currentIndex], // Menampilkan halaman sesuai index Navbar
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index; // Berpindah halaman saat icon di klik
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Beranda",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}