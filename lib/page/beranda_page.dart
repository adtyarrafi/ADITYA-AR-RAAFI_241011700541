import 'package:flutter/material.dart';
import 'package:cherry_toast/cherry_toast.dart';

class BerandaPage extends StatefulWidget {
  final Function(Map<String, dynamic>) onUpdate;
  final VoidCallback onDelete;

  const BerandaPage({super.key, required this.onUpdate, required this.onDelete});

  @override
  State<BerandaPage> createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage> {
  final Map<String, TextEditingController> _controllers = {
    'nama': TextEditingController(),
    'lokasi': TextEditingController(),
    'role': TextEditingController(),
    'project': TextEditingController(),
    'followers': TextEditingController(),
    'summary': TextEditingController(),
    'bgUrl': TextEditingController(),
    'profileUrl': TextEditingController(),
  };

  List<String> tempExp = [];
  List<String> tempEdu = [];
  final TextEditingController expInput = TextEditingController();
  final TextEditingController eduInput = TextEditingController();

  void _showFormDialog() {
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text("Input Data CV"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                _buildField(_controllers['nama']!, "Nama"),
                _buildField(_controllers['lokasi']!, "Lokasi"),
                _buildField(_controllers['role']!, "Role"),
                _buildField(_controllers['project']!, "Project"),
                _buildField(_controllers['followers']!, "Followers"),
                _buildField(_controllers['bgUrl']!, "URL Background"),
                _buildField(_controllers['profileUrl']!, "URL Profile"),
                _buildField(_controllers['summary']!, "Summary", max: 3),
                const Divider(),
                _buildMultiInput("Experience", expInput, tempExp, () {
                  if (expInput.text.isNotEmpty) {
                    setDialogState(() => tempExp.add(expInput.text));
                    expInput.clear();
                  }
                }),
                const Divider(),
                _buildMultiInput("Education", eduInput, tempEdu, () {
                  if (eduInput.text.isNotEmpty) {
                    setDialogState(() => tempEdu.add(eduInput.text));
                    eduInput.clear();
                  }
                }),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Map<String, dynamic> results = _controllers.map((k, v) => MapEntry(k, v.text));
                results['experience'] = List<String>.from(tempExp);
                results['education'] = List<String>.from(tempEdu);
                widget.onUpdate(results);
                Navigator.pop(context);
                CherryToast.success(title: const Text("Data Berhasil Disimpan")).show(context);
              },
              child: const Text("Simpan"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildField(TextEditingController c, String l, {int max = 1}) => Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: TextField(controller: c, maxLines: max, decoration: InputDecoration(labelText: l, border: const OutlineInputBorder())),
  );

  Widget _buildMultiInput(String label, TextEditingController ctrl, List<String> list, VoidCallback add) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      TextField(controller: ctrl, decoration: InputDecoration(labelText: label, suffixIcon: IconButton(icon: const Icon(Icons.add), onPressed: add))),
      ...list.map((e) => Text("• $e", style: const TextStyle(fontSize: 12))),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pertemuan 4")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _btn("Submit", Colors.green, _showFormDialog),
            const SizedBox(height: 10),
            _btn("Delete", Colors.red, widget.onDelete),
          ],
        ),
      ),
    );
  }

  Widget _btn(String t, Color c, VoidCallback a) => ElevatedButton(
    onPressed: a,
    style: ElevatedButton.styleFrom(backgroundColor: c, minimumSize: const Size(150, 50)),
    child: Text(t, style: const TextStyle(color: Colors.white)),
  );
}