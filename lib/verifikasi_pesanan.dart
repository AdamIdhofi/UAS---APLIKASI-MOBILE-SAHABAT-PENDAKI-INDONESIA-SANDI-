import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'Firebase/firestore_service.dart';
import 'keranjang.dart'; // Import the keranjang.dart file

class VerifikasiPesananPage extends StatelessWidget {
  final Map<String, dynamic> dataPesanan;
  final FirestoreService _firestoreService = FirestoreService();

  VerifikasiPesananPage({required this.dataPesanan});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verifikasi Pesanan'),
        backgroundColor: Color(0xFF2E7D32),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        toolbarTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildDetailPesananCard(context),
              SizedBox(height: 20),
              buildDataRombonganCard(context),
              SizedBox(height: 20),
              buildRincianHargaCard(context),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    await _firestoreService.addOrder(dataPesanan);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => KeranjangPage()),
                    );
                  },
                  child: Text('Masukkan ke Keranjang'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF2E7D32),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    textStyle: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDetailPesananCard(BuildContext context) {
    final String namaGunung = dataPesanan['namaGunung'] ?? '';
    print("Fetching data for mountain with name: $namaGunung");

    return FutureBuilder<QuerySnapshot>(
      future: _firestoreService.getMountainByName(namaGunung),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          print("Error: ${snapshot.error}");
          return Center(child: Text('Error occurred while fetching data.'));
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          print("No mountain found with name: $namaGunung");
          return Center(child: Text('Data not available'));
        }

        final doc = snapshot.data!.docs.first;
        final mountain = Mountain.fromFirestore(doc);
        print("Fetched data for mountain: ${mountain.name}");

        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.network(
                      mountain.imageUrl,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Tiket ${mountain.name}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                buildDetailItem('Jumlah Rombongan',
                    (dataPesanan['jumlahAnggota'] ?? 'N/A').toString()),
                buildDetailItem('Tanggal Keberangkatan',
                    dataPesanan['tanggalKeberangkatan'] ?? 'N/A'),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildDataRombonganCard(BuildContext context) {
    final List<dynamic> members = dataPesanan['members'] ?? [];

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSectionTitle('Data Rombongan'),
            SizedBox(height: 10),
            if (members.isNotEmpty) ...[
              buildDetailItem(
                  'Ketua Rombongan', members[0]['namaAnggota'] ?? 'N/A'),
              buildDetailItem('No. Telepon', members[0]['noTelepon'] ?? 'N/A'),
              buildDetailItem('Alamat Email', members[0]['email'] ?? 'N/A'),
            ] else ...[
              buildDetailItem('Ketua Rombongan', 'N/A'),
              buildDetailItem('No. Telepon', 'N/A'),
              buildDetailItem('Alamat Email', 'N/A'),
            ],
            InkWell(
              onTap: () {
                // Panggil fungsi untuk menampilkan data lengkap
                showCompleteMemberDetails(context, members);
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Selengkapnya',
                      style: TextStyle(color: Color(0xFF2E7D32)),
                    ),
                    Icon(Icons.arrow_forward, color: Color(0xFF2E7D32)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showCompleteMemberDetails(BuildContext context, List<dynamic> members) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16),
          height: MediaQuery.of(context).size.height * 0.7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Data Lengkap Rombongan',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: members.length,
                  itemBuilder: (context, index) {
                    final member = members[index];
                    final isKetua =
                        index == 0; // Asumsikan ketua adalah anggota pertama
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 8),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildDetailItem(
                                isKetua ? 'Nama Ketua' : 'Nama Anggota',
                                member['namaAnggota'] ?? 'N/A'),
                            buildDetailItem('No. Identitas',
                                member['noIdentitas'] ?? 'N/A'),
                            buildDetailItem(
                                'No. Telepon', member['noTelepon'] ?? 'N/A'),
                            buildDetailItem('Kewarganegaraan',
                                member['kewarganegaraan'] ?? 'N/A'),
                            buildDetailItem('Jenis Kelamin',
                                member['jenisKelamin'] ?? 'N/A'),
                            if (member['riwayatPenyakit'] != null &&
                                member['riwayatPenyakit'].isNotEmpty)
                              buildDetailItem(
                                  'Riwayat Penyakit',
                                  (member['riwayatPenyakit'] as List<dynamic>)
                                      .join(', ')),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Tutup'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF2E7D32),
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildRincianHargaCard(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSectionTitle('Rincian Harga'),
            SizedBox(height: 10),
            buildDetailItem(
                'Harga Tiket', 'Rp ${dataPesanan['hargaTiket'] ?? 'N/A'}'),
            buildDetailItem(
                'Subtotal', 'Rp ${dataPesanan['hargaTiket'] ?? 'N/A'}'),
            SizedBox(height: 10),
            Divider(),
            buildTotalPriceItem(
                'Jumlah Total', 'Rp ${dataPesanan['totalHarga'] ?? 'N/A'}'),
          ],
        ),
      ),
    );
  }

  Widget buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }

  Widget buildDetailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTotalPriceItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}