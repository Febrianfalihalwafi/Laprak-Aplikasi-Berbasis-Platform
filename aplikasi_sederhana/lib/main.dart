import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kafe Kopi Nusantara',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// 📦 Model Data
class MenuItem {
  final String id;
  final String title;
  final String shortDesc;
  final String imageUrl;
  final String fullDesc;

  MenuItem({
    required this.id,
    required this.title,
    required this.shortDesc,
    required this.imageUrl,
    required this.fullDesc,
  });
}

// 📝 Data Dummy
final List<MenuItem> menuItems = [
  MenuItem(
    id: '1',
    title: 'Kopi Susu Gula Aren',
    shortDesc: 'Perpaduan espresso dan susu segar dengan gula aren asli.',
    imageUrl: 'assets/kopisusugulaaren.jpg',
    fullDesc: 'Kopi susu kekinian yang menggunakan biji kopi arabika pilihan, diseduh sempurna dan dicampur dengan susu segar serta gula aren organik yang manis alami.',
  ),
  MenuItem(
    id: '2',
    title: 'Matcha Latte',
    shortDesc: 'Teh hijau Jepang premium dicampur susu creamy.',
    imageUrl: 'assets/matchalatte.jpg',
    fullDesc: 'Dibuat dari bubuk matcha grade premium yang diaduk dengan susu segar hangat/dingin. Memberikan rasa earthy yang menenangkan dan kaya antioksidan.',
  ),
  MenuItem(
    id: '3',
    title: 'Chocolate Hazelnut',
    shortDesc: 'Cokelat Belgia dengan sentuhan hazelnut panggang.',
    imageUrl: 'assets/chocolatehazelnut.jpg',
    fullDesc: 'Minuman cokelat premium yang dipadukan dengan pasta hazelnut panggang, disajikan dengan whipped cream dan taburan cokelat parut di atasnya.',
  ),
];

// 🏠 Home Screen
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kafe Kopi Nusantara'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: menuItems.length,
        itemBuilder: (context, index) {
          final item = menuItems[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  // 🔄 Navigasi ke Halaman Detail
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DetailScreen(item: item),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 🖼️ Gambar
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          item.imageUrl,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            width: 100, height: 100, color: Colors.grey[300],
                            child: const Icon(Icons.image, size: 40),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      // 📖 Judul & Deskripsi Singkat
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.title,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              item.shortDesc,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// 📄 Detail Screen
class DetailScreen extends StatefulWidget {
  final MenuItem item;
  const DetailScreen({super.key, required this.item});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    // ✅ Validasi: Tampilkan Snackbar jika kosong
    if (_nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nama tidak boleh kosong!')),
      );
      return;
    }

    // 🎉 Tampilkan AlertDialog saat berhasil
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Terima kasih, ${_nameController.text}!'),
        content: Text(
          'Catatan Anda:\n"${_noteController.text}"\n\n'
          'Pesanan untuk *${widget.item.title}* akan segera diproses.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.item.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  widget.item.imageUrl,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    height: 200, color: Colors.grey[300],
                    child: const Center(child: Icon(Icons.image, size: 50)),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              widget.item.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              widget.item.fullDesc,
              style: const TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 32),
            const Divider(),
            const SizedBox(height: 16),
            const Text(
              'Form Pemesanan / Catatan:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            // 📝 TextField 1
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Nama Anda',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                prefixIcon: const Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 16),
            // 📝 TextField 2
            TextField(
              controller: _noteController,
              decoration: InputDecoration(
                labelText: 'Catatan Tambahan (opsional)',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                prefixIcon: const Icon(Icons.note),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 24),
            // 🔘 Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _handleSubmit,
                icon: const Icon(Icons.check_circle),
                label: const Text('Kirim Pesanan'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  textStyle: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}