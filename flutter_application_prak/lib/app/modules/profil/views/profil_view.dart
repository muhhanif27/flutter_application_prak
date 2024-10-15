import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilView extends StatefulWidget {
  const ProfilView({Key? key}) : super(key: key);

  @override
  State<ProfilView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfilView> {
  File? _profileImage; // Variabel untuk menyimpan gambar profil
  final ImagePicker _picker = ImagePicker();

  // Variabel untuk menyimpan informasi dasar
  String _gender = 'Laki - Laki';
  double _currentWeight = 74.0;
  double _targetWeight = 70.0;
  double _height = 171.0;

  // Fungsi untuk membuka pemilih gambar
  Future<void> _openImagePicker() async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Ambil Foto dari Kamera'),
                onTap: () async {
                  Navigator.pop(context);
                  final XFile? pickedImage =
                      await _picker.pickImage(source: ImageSource.camera);
                  if (pickedImage != null) {
                    setState(() {
                      _profileImage = File(pickedImage.path);
                    });
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo),
                title: const Text('Pilih dari Galeri'),
                onTap: () async {
                  Navigator.pop(context);
                  final XFile? pickedImage =
                      await _picker.pickImage(source: ImageSource.gallery);
                  if (pickedImage != null) {
                    setState(() {
                      _profileImage = File(pickedImage.path);
                    });
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Fungsi untuk menunjukkan dialog pemilihan jenis kelamin
  void _showGenderSelectionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Pilih Jenis Kelamin'),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () {
                setState(() {
                  _gender = 'Laki - Laki';
                });
                Navigator.pop(context);
              },
              child: const Text('Laki - Laki'),
            ),
            SimpleDialogOption(
              onPressed: () {
                setState(() {
                  _gender = 'Perempuan';
                });
                Navigator.pop(context);
              },
              child: const Text('Perempuan'),
            ),
          ],
        );
      },
    );
  }

  // Fungsi untuk menunjukkan dialog input
  void _showInputDialog(
      String title, String currentValue, Function(String) onSave) {
    TextEditingController controller =
        TextEditingController(text: currentValue);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit $title'),
          content: TextField(
            controller: controller,
            keyboardType: title.contains('Berat') || title == 'Tinggi'
                ? TextInputType.number
                : TextInputType.text,
            decoration: InputDecoration(hintText: 'Masukkan $title'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                onSave(controller.text);
                Navigator.pop(context);
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
        backgroundColor: Colors.blue[800],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: _openImagePicker,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: _profileImage != null
                          ? FileImage(_profileImage!)
                          : const AssetImage('assets/default_profile.png')
                              as ImageProvider,
                      child: _profileImage == null
                          ? const Icon(Icons.camera_alt,
                              size: 50, color: Colors.white)
                          : null,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Selamat Datang, Gym',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: _openImagePicker,
                    child: const Text('Ubah Foto Profil'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Info Dasar',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            Card(
              color: Colors.blue[50],
              child: Column(
                children: [
                  ListTile(
                    title: const Text('Jenis Kelamin'),
                    trailing: Text(_gender),
                    onTap: _showGenderSelectionDialog,
                  ),
                  ListTile(
                    title: const Text('Berat Saat Ini (kg)'),
                    trailing: Text('$_currentWeight kg'),
                    onTap: () {
                      _showInputDialog(
                          'Berat Saat Ini', _currentWeight.toString(),
                          (newValue) {
                        setState(() {
                          _currentWeight = double.parse(newValue);
                        });
                      });
                    },
                  ),
                  ListTile(
                    title: const Text('Target Berat (kg)'),
                    trailing: Text('$_targetWeight kg'),
                    onTap: () {
                      _showInputDialog('Target Berat', _targetWeight.toString(),
                          (newValue) {
                        setState(() {
                          _targetWeight = double.parse(newValue);
                        });
                      });
                    },
                  ),
                  ListTile(
                    title: const Text('Tinggi (cm)'),
                    trailing: Text('$_height cm'),
                    onTap: () {
                      _showInputDialog('Tinggi', _height.toString(),
                          (newValue) {
                        setState(() {
                          _height = double.parse(newValue);
                        });
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
