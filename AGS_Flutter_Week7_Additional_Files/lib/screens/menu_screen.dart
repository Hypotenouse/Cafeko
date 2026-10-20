import 'package:flutter/material.dart';
import 'add_order_screen.dart';
import 'cart_screen.dart';

// ============================================================================
// MENU SCREEN - BREW & BITE (Week 7: State Management & Form Integration)
// Alta Global School | IT Grade 10 & 11 (SHS)
// ============================================================================

class MenuScreen extends StatefulWidget {
  final List<Map<String, dynamic>> cartSaatIni;
  final String? userName;
  final String? userClass;

  const MenuScreen({
    super.key,
    this.cartSaatIni = const [],
    this.userName,
    this.userClass,
  });

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  late List<Map<String, dynamic>> _localCart;

  final List<Map<String, dynamic>> kantinMenu = [
    {
      'name': 'Kopi Susu Aren',
      'price': 'Rp 22.000',
      'icon': Icons.local_cafe,
      'stall': 'Barista A',
    },
    {
      'name': 'Caramel Macchiato',
      'price': 'Rp 28.000',
      'icon': Icons.local_cafe,
      'stall': 'Barista B',
    },
    {
      'name': 'Croissant Butter',
      'price': 'Rp 18.000',
      'icon': Icons.bakery_dining,
      'stall': 'Pastry',
    },
    {
      'name': 'Cheese Cake',
      'price': 'Rp 25.000',
      'icon': Icons.cake,
      'stall': 'Pastry',
    },
    {
      'name': 'Matcha Latte',
      'price': 'Rp 24.000',
      'icon': Icons.emoji_food_beverage,
      'stall': 'Barista A',
    },
  ];

  @override
  void initState() {
    super.initState();
    _localCart = List<Map<String, dynamic>>.from(widget.cartSaatIni);
  }

  Future<void> _navigateAndAddCustomOrder() async {
    final newItem = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(builder: (context) => const AddOrderScreen()),
    );

    if (newItem != null) {
      setState(() {
        kantinMenu.insert(0, {
          'name': newItem['name'],
          'price': 'Rp ${newItem['price']}',
          'icon': Icons.fastfood,
          'stall': 'Menu Kustom',
        });
      });

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${newItem['name']} ditambahkan ke daftar menu!'),
          backgroundColor: const Color(0xFF0284C7),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color brandBlue = Color(0xFF0284C7);
    final String displayName = widget.userName ?? 'Siswa';

    return Scaffold(
      backgroundColor: const Color(0xFFF0F9FF),
      appBar: AppBar(
        title: Text(
          'Menu Brew & Bite',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: brandBlue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            tooltip: 'Tambah Item Baru',
            icon: const Icon(Icons.add_box_outlined),
            onPressed: _navigateAndAddCustomOrder,
          ),
          IconButton(
            tooltip: 'Lihat Keranjang',
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartScreen(userName: displayName),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Greeting
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Text(
                'Halo, $displayName! Pilih menu kamu:',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                ),
              ),
            ),

            // Add Custom Item Row
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Daftar Menu',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1E293B)),
                  ),
                  TextButton.icon(
                    onPressed: _navigateAndAddCustomOrder,
                    icon: const Icon(Icons.add, size: 18, color: Color(0xFF0284C7)),
                    label: const Text('Tambah Menu', style: TextStyle(color: Color(0xFF0284C7), fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),

            // Menu Cards using ListView.builder
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: kantinMenu.length,
              itemBuilder: (context, index) {
                final item = kantinMenu[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.07),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    leading: CircleAvatar(
                      backgroundColor: const Color(0xFFE0F2FE),
                      child: Icon(
                        item['icon'] as IconData,
                        color: brandBlue,
                      ),
                    ),
                    title: Text(
                      item['name'] as String,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    subtitle: Text(
                      '${item['stall']}  •  ${item['price']}',
                      style: const TextStyle(color: Color(0xFF64748B), fontSize: 13),
                    ),
                    trailing: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: brandBlue,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CartScreen(
                              userName: displayName,
                              selectedItem: item['name'] as String,
                              selectedPrice: item['price'] as String,
                            ),
                          ),
                        );
                      },
                      child: const Text('Pesan', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
