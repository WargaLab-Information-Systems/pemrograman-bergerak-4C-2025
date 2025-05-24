import 'package:flutter/material.dart';
import '../models/admin.dart';
import '../services/admin.dart';

class ProfileAdminPage extends StatefulWidget {
  const ProfileAdminPage({Key? key}) : super(key: key);

  @override
  State<ProfileAdminPage> createState() => _ProfileAdminPageState();
}

class _ProfileAdminPageState extends State<ProfileAdminPage> {
  final AdminProfileService _service = AdminProfileService();
  late Future<List<AdminProfile>> _profileList;

  @override
  void initState() {
    super.initState();
    _profileList = _service.fetchProfiles();
  }

  void _refresh() {
    setState(() {
      _profileList = _service.fetchProfiles();
    });
  }

  void _showForm({AdminProfile? profile}) {
    final namaCtrl = TextEditingController(text: profile?.nama ?? '');
    final emailCtrl = TextEditingController(text: profile?.email ?? '');
    final passCtrl = TextEditingController(text: profile?.password ?? '');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(profile == null ? 'Tambah Profil' : 'Edit Profil'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: namaCtrl, decoration: InputDecoration(labelText: 'Nama')),
            TextField(controller: emailCtrl, decoration: InputDecoration(labelText: 'Email')),
            TextField(controller: passCtrl, decoration: InputDecoration(labelText: 'Password')),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              AdminProfile newProfile = AdminProfile(
                id: profile?.id ?? '0',
                nama: namaCtrl.text,
                email: emailCtrl.text,
                password: passCtrl.text,
              );

              if (profile == null) {
                await _service.addProfile(newProfile);
              } else {
                await _service.updateProfile(newProfile);
              }

              _refresh();
            },
            child: const Text('Simpan'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Batal'),
          ),
        ],
      ),
    );
  }

  void _deleteProfile(String id) async {
    await _service.deleteProfile(id);
    _refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profil Admin')),
      body: FutureBuilder<List<AdminProfile>>(
        future: _profileList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) return Center(child: CircularProgressIndicator());
          if (!snapshot.hasData || snapshot.data!.isEmpty) return Center(child: Text('Belum ada data admin'));

          final profiles = snapshot.data!;
          return ListView.builder(
            itemCount: profiles.length,
            itemBuilder: (context, index) {
              final profile = profiles[index];
              return ListTile(
                title: Text(profile.nama),
                subtitle: Text(profile.email),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(icon: Icon(Icons.edit), onPressed: () => _showForm(profile: profile)),
                    IconButton(icon: Icon(Icons.delete), onPressed: () => _deleteProfile(profile.id)),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showForm(),
        child: Icon(Icons.add),
      ),
    );
  }
}
