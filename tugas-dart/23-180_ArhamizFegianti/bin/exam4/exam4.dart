class PraktikanStudent {
  String fullName;
  int age;

  PraktikanStudent(this.fullName, this.age);

  int incrementAge() {
    // TODO 1

    return age + 1;

    // End of TODO 1
  }

  Future<String> getStudentInfo() async {
    // TODO 2

    await Future.delayed(Duration(seconds: 3));

    String fullName = "Lutfi";
    int age = 18;

    return "Nama Lengkap: $fullName, Umur: $age tahun";

    // End of TODO 2
  }
}

dynamic createStudent() {
  // TODO 3

  PraktikanStudent praktikanStudent = PraktikanStudent("Arhamiz Fegianti", 20);
  return praktikanStudent;

  // End of TODO 3
}
