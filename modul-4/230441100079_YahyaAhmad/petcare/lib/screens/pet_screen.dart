import 'package:flutter/material.dart';
import '../models/pet.dart';
import '../services/pet_service.dart';

class PetScreen extends StatefulWidget {
  const PetScreen({Key? key}) : super(key: key);

  @override
  _PetScreenState createState() => _PetScreenState();
}

class _PetScreenState extends State<PetScreen> {
  late Future<List<Pet>> _petFuture;

  @override
  void initState() {
    super.initState();
    _loadPets();
  }

  void _loadPets() {
    setState(() {
      _petFuture = PetService.fetchPets();
    });
  }

  void _showAddPetDialog() {
    final namaController = TextEditingController();
    final jenisController = TextEditingController();
    final umurController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Tambah Peliharaan'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: namaController, decoration: const InputDecoration(labelText: 'Nama')),
            TextField(controller: jenisController, decoration: const InputDecoration(labelText: 'Jenis')),
            TextField(controller: umurController, decoration: const InputDecoration(labelText: 'Umur')),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (namaController.text.isEmpty || 
                  jenisController.text.isEmpty || 
                  umurController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Semua field harus diisi'))
                );
                return;
              }
              
              final newPet = Pet(
                nama: namaController.text,
                jenis: jenisController.text,
                umur: umurController.text,
              );
              
              await PetService.addPet(newPet);
              _loadPets();
              Navigator.pop(context);
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  void _showEditPetDialog(Pet pet) {
    final namaController = TextEditingController(text: pet.nama);
    final jenisController = TextEditingController(text: pet.jenis);
    final umurController = TextEditingController(text: pet.umur);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Peliharaan'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: namaController, decoration: const InputDecoration(labelText: 'Nama')),
            TextField(controller: jenisController, decoration: const InputDecoration(labelText: 'Jenis')),
            TextField(controller: umurController, decoration: const InputDecoration(labelText: 'Umur')),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (pet.id == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('ID peliharaan tidak ditemukan'))
                );
                return;
              }
              
              final updatedPet = Pet(
                nama: namaController.text,
                jenis: jenisController.text,
                umur: umurController.text,
                id: pet.id,
              );
              
              await PetService.updatePet(pet.id!, updatedPet);
              _loadPets();
              Navigator.pop(context);
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  void _confirmDeletePet(Pet pet) {
    if (pet.id == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('ID peliharaan tidak ditemukan'))
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus Peliharaan'),
        content: Text('Apakah Anda yakin ingin menghapus ${pet.nama}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () async {
              await PetService.deletePet(pet.id!);
              _loadPets();
              Navigator.pop(context);
            },
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Peliharaan'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadPets,
          ),
        ],
      ),
      body: FutureBuilder<List<Pet>>(
        future: _petFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          
          final pets = snapshot.data ?? [];
          
          if (pets.isEmpty) {
            return const Center(child: Text('Belum ada data peliharaan'));
          }

          return ListView.builder(
            itemCount: pets.length,
            itemBuilder: (context, index) {
              final pet = pets[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.teal.shade200,
                    child: const Icon(Icons.pets, color: Colors.white),
                  ),
                  title: Text(pet.nama, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('${pet.jenis} - Umur: ${pet.umur}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () => _showEditPetDialog(pet),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _confirmDeletePet(pet),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddPetDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
