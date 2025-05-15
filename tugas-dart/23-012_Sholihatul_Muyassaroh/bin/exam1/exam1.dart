dynamic studentInfo() {
  // TODO 1
  String name = "Sholihatul Muyassaroh";
  int favNumber = 2;
  bool isPraktikan = true;
  print(isPraktikan); // Output true
  // End of TODO 1
  return [name, favNumber, isPraktikan];
}


dynamic circleArea(num r) {
  if (r < 0) {
    return 0.0;
  } else {
    const double pi = 3.1415926535897932; //π sama dengan library dart.math;

    // TODO 2

    return pi * r * r;

    // End of TODO 2
  }
}

int? parseAndAddOne(String? input) {
  // TODO 3
  if (input == null) {
      return null;
    }
    
    int? number;
    try {
      number = int.parse(input);
    } catch (e) {
      throw Exception('Input harus berupa angka');
    }
    
    return number + 1;
  // End of TODO 3
}

