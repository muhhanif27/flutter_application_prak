import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  File? _profileImage; // Variabel untuk menyimpan gambar profil
  final ImagePicker _picker = ImagePicker();

  // Fungsi untuk mengambil gambar dari galeri atau kamera
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

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Latihan Dada'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Latihan'),
            Tab(text: 'Profil'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Halaman 1: Latihan List
          Column(
            children: [
              Card(
                margin: const EdgeInsets.all(16.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Latihan Dada',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      SizedBox(height: 10),
                      Text('2 Latihan'),
                      Text('Incline Bench Press - Dumbbell'),
                      Text('Incline Bench Press - Barbell'),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: TextButton(
                    onPressed: () {},
                    child: const Text('Lihat Semua'),
                  ),
                ),
              ),
            ],
          ),

          // Halaman 2: Profil dan Image Picker
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      // Gambar Profil
                      GestureDetector(
                        onTap:
                            _openImagePicker, // Buka image picker ketika ditekan
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: _profileImage != null
                              ? FileImage(_profileImage!) as ImageProvider
                              : const AssetImage('assets/default_profile.png'),
                          child: _profileImage == null
                              ? const Icon(Icons.camera_alt,
                                  size: 50, color: Colors.white)
                              : null,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Selamat Datang, Gym',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
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
                ListTile(
                  title: const Text('Jenis Kelamin'),
                  trailing: const Text('Laki - Laki'),
                  onTap: () {}, // Tambahkan fungsionalitas jika diperlukan
                ),
                ListTile(
                  title: const Text('Berat Saat Ini'),
                  trailing: const Text('74.0 kg'),
                  onTap: () {},
                ),
                ListTile(
                  title: const Text('Target Berat'),
                  trailing: const Text('70.0 kg'),
                  onTap: () {},
                ),
                ListTile(
                  title: const Text('Tinggi'),
                  trailing: const Text('171.0 cm'),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
