void main() {
  // Soal 1: Panggil hitungLuasPersegiPanjang
  double panjang = 8.0;
  double lebar = 9.0;
  double luas = hitungLuasPersegiPanjang(panjang, lebar);
  print('Luas: ${luas.toStringAsFixed(2)} cm²');

  // Soal 3: Buat dua objek Profil
  Profil profil1 = Profil(
    nama: 'Adam Marchelino',
    nim: '362558302044',
    emailKampus: 'adam@poliwangi.ac.id',
  );

  Profil profil2 = Profil(
    nama: 'Adam Marchelina',
    nim: '362458302087',
    // emailKampus: 'Marchelina@poliwangi.ac.id',
  );
  // bisa di uncoment jika ingn melihat perbedaan saat ada email dibandingkan tidak ada email

  profil1.tampilkanInfo();
  profil2.tampilkanInfo();

  // untuk print panjang email profil
  print('Panjang email profil1: ${profil1.emailKampus?.length}');
  print('Panjang email profil2: ${profil2.emailKampus?.length}');
}

// Soal 1: Implementasikan fungsi ini
double hitungLuasPersegiPanjang(double panjang, double lebar) {
  return panjang * lebar;
}

// Soal 2: Implementasikan class ini
class Profil {
  String nama;
  String nim;
  String? emailKampus;

  Profil({required this.nama, required this.nim, this.emailKampus});

  void tampilkanInfo() {
    print('[$nim] $nama | Email: ${emailKampus ?? '(belum ada email)'}');
  }
}
