class AdminProfile {
  final String id;
  final String nama;
  final String email;
  final String password;

  AdminProfile({
    required this.id,
    required this.nama,
    required this.email,
    required this.password,
  });

  factory AdminProfile.fromJson(Map<String, dynamic> json) {
    return AdminProfile(
      id: json['id_admin'],
      nama: json['nama'],
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, String> toJson() {
    return {
      'id_admin': id,
      'nama': nama,
      'email': email,
      'password': password,
    };
  }
}
