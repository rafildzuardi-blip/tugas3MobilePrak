
import 'package:flutter/material.dart';

class BMIScreen extends StatefulWidget {
  const BMIScreen({super.key});

  @override
  State<BMIScreen> createState() => _BMIScreenState();
}

class _BMIScreenState extends State<BMIScreen> {
  final _bbController = TextEditingController();
  final _tbController = TextEditingController();

  double? hasilBMI;
  String _keterangan = 'Masukkan data kamu';
  String _jenisKelamin = 'Laki-laki';
  bool _sudahDihitung = false;
  bool _dataValid = true;

  // Warna utama aplikasi
  static const Color biru = Color(0xFF2563EB);
  static const Color putih = Colors.white;
  static const Color teksGelap = Color(0xFF202124);
  static const Color oranye = Color(0xFFEF6C00);
  static const Color oranyeMuda = Color(0xFFFFEDE0);
  static const Color abuAbu = Color(0xFFE5E7EB);

  void _logikaBMI() {
    final double? bb = double.tryParse(
      _bbController.text.trim().replaceAll(',', '.'),
    );

    final double? tb = double.tryParse(
      _tbController.text.trim().replaceAll(',', '.'),
    );

    if (bb == null || tb == null || bb <= 0 || tb <= 0) {
      setState(() {
        hasilBMI = null;
        _keterangan = 'Masukkan berat dan tinggi yang valid';
        _sudahDihitung = true;
        _dataValid = false;
      });
      return;
    }

    final double tbMeter = tb / 100;
    final double bmi = bb / (tbMeter * tbMeter);

    String keterangan;

    if (bmi < 18.5) {
      keterangan = 'Berat badan kurang';
    } else if (bmi < 25) {
      keterangan = 'Berat badan normal';
    } else if (bmi < 30) {
      keterangan = 'Berat badan berlebih';
    } else {
      keterangan = 'Obesitas';
    }

    setState(() {
      hasilBMI = bmi;
      _keterangan = keterangan;
      _sudahDihitung = true;
      _dataValid = true;
    });

    FocusScope.of(context).unfocus();
  }

  void _resetBMI() {
    _bbController.clear();
    _tbController.clear();

    setState(() {
      hasilBMI = null;
      _keterangan = 'Masukkan data kamu';
      _jenisKelamin = 'Laki-laki';
      _sudahDihitung = false;
      _dataValid = true;
    });

    FocusScope.of(context).unfocus();
  }

  void _ubahGender(String gender) {
    setState(() {
      _jenisKelamin = gender;
      hasilBMI = null;
      _keterangan = 'Masukkan data kamu';
      _sudahDihitung = false;
      _dataValid = true;
    });
  }

  @override
  void dispose() {
    _bbController.dispose();
    _tbController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: putih,

      // AppBar biru
      appBar: AppBar(
        title: const Text(
        'FLYY nu gaduh na!!!',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: putih,
            letterSpacing: 1,
          ),
        ),
        centerTitle: true,
        backgroundColor: biru,
        foregroundColor: putih,
        elevation: 0,
        leading: const Icon(Icons.monitor_heart),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header aplikasi
              const Icon(
                Icons.monitor_heart,
                size: 65,
                color: biru,
              ),

              const SizedBox(height: 10),

              const Text(
                'Kenali Kondisi Tubuhmu',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: teksGelap,
                ),
              ),

              const SizedBox(height: 6),

              const Text(
                'Masukkan data untuk menghitung BMI',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),

              const SizedBox(height: 28),

              // Kartu hasil BMI
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: putih,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: abuAbu),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Icon(
                      _jenisKelamin == 'Laki-laki'
                          ? Icons.male
                          : Icons.female,
                      size: 48,
                      color: biru,
                    ),

                    const SizedBox(height: 10),

                    Text(
                      'Hasil BMI $_jenisKelamin',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                        color: teksGelap,
                      ),
                    ),

                    const SizedBox(height: 20),

                    if (_sudahDihitung && !_dataValid)
                      const Text(
                        'Periksa kembali data yang kamu masukkan.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                        ),
                      )
                    else ...[
                      Text(
                        hasilBMI?.toStringAsFixed(1) ?? '--',
                        style: const TextStyle(
                          fontSize: 58,
                          fontWeight: FontWeight.bold,
                          color: oranye,
                        ),
                      ),

                      const SizedBox(height: 12),

                      if (_sudahDihitung && hasilBMI != null)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: oranyeMuda,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Text(
                            _keterangan,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: oranye,
                            ),
                          ),
                        )
                      else
                        const Text(
                          'Hasil akan muncul di sini',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 14,
                          ),
                        ),
                    ],
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // Pilihan jenis kelamin
              const Text(
                'Jenis Kelamin',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  color: teksGelap,
                ),
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: _pilihanGender(
                      'Laki-laki',
                      Icons.male,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _pilihanGender(
                      'Perempuan',
                      Icons.female,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Input berat badan
              TextField(
                controller: _bbController,
                keyboardType:
                    const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: InputDecoration(
                  labelText: 'Berat Badan (kg)',
                  hintText: 'Contoh: 55',
                  prefixIcon: const Icon(
                    Icons.monitor_weight,
                    color: biru,
                  ),
                  filled: true,
                  fillColor: putih,
                  contentPadding: const EdgeInsets.all(18),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: abuAbu),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: abuAbu),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(
                      color: biru,
                      width: 2,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Input tinggi badan
              TextField(
                controller: _tbController,
                keyboardType:
                    const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: InputDecoration(
                  labelText: 'Tinggi Badan (cm)',
                  hintText: 'Contoh: 165',
                  prefixIcon: const Icon(
                    Icons.height,
                    color: biru,
                  ),
                  filled: true,
                  fillColor: putih,
                  contentPadding: const EdgeInsets.all(18),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: abuAbu),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: abuAbu),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(
                      color: biru,
                      width: 2,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 22),

              // Tombol hitung
              SizedBox(
                height: 54,
                child: ElevatedButton.icon(
                  onPressed: _logikaBMI,
                  icon: const Icon(Icons.calculate),
                  label: const Text(
                    'Hitung BMI',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: biru,
                    foregroundColor: putih,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Tombol reset
              SizedBox(
                height: 52,
                child: OutlinedButton.icon(
                  onPressed: _resetBMI,
                  icon: const Icon(Icons.refresh),
                  label: const Text(
                    'Reset',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: biru,
                    side: const BorderSide(
                      color: biru,
                      width: 1.5,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // Informasi kategori BMI
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: abuAbu),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Kategori BMI Dewasa',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: teksGelap,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text('• Di bawah 18,5: Berat badan kurang'),
                    SizedBox(height: 6),
                    Text('• 18,5–24,9: Rentang normal'),
                    SizedBox(height: 6),
                    Text('• 25–29,9: Berat badan berlebih'),
                    SizedBox(height: 6),
                    Text('• 30 ke atas: Obesitas'),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              const Text(
                'BMI adalah alat skrining sederhana. '
                'Kategori ini menggunakan batas umum orang dewasa '
                'dan tidak dibedakan berdasarkan jenis kelamin.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Tombol pilihan jenis kelamin
  Widget _pilihanGender(String gender, IconData ikon) {
    final bool terpilih = _jenisKelamin == gender;

    return InkWell(
      onTap: () => _ubahGender(gender),
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: terpilih ? biru.withOpacity(0.08) : putih,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: terpilih ? biru : abuAbu,
            width: terpilih ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Icon(
              ikon,
              size: 32,
              color: biru,
            ),
            const SizedBox(height: 6),
            Text(
              gender,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: terpilih ? biru : teksGelap,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
