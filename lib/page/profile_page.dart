import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final Map<String, dynamic> data;
  const ProfilePage({super.key, required this.data});

  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                Image.network(data['bgUrl'], height: 200, width: double.infinity, fit: BoxFit.cover),
                Positioned(
                  bottom: -50,
                  child: CircleAvatar(
                    radius: 60, backgroundColor: Colors.white,
                    child: CircleAvatar(radius: 55, backgroundImage: NetworkImage(data['profileUrl'])),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 60),
            Text(data['nama'], style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text(data['lokasi'], style: const TextStyle(color: Colors.grey)),
            Text(data['role'], style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _stat("Project", data['project']),
                _stat("Followers", data['followers']),
              ],
            ),
            _section("Summary", [Text(data['summary'])]),
            _section("Experience", (data['experience'] as List).map((e) => Text("• $e")).toList()),
            _section("Education", (data['education'] as List).map((e) => Text("• $e")).toList()),
          ],
        ),
      ),
    );
  }

  Widget _stat(String l, String v) => Column(children: [Text(l, style: const TextStyle(color: Colors.blue)), Text(v)]);
  Widget _section(String t, List<Widget> c) => Padding(
    padding: const EdgeInsets.all(20),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(t, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      const Divider(color: Colors.green, thickness: 2),
      ...c,
    ]),
  );
}