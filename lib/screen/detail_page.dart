import 'package:flutter/material.dart';
import 'package:olah_data/models/game_store_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';

class DetailPage extends StatelessWidget {
  final GameStore game;
  const DetailPage({super.key, required this.game});

  // Fungsi untuk membuka URL
  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $uri');
    }
  }

  @override
  Widget build(BuildContext context) {
    final priceDisplay = game.price;

    return Scaffold(
      appBar: AppBar(
        title: Text(game.name),
        backgroundColor: const Color.fromARGB(255, 255, 192, 247),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar Utama (Header Image)
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.network(
                game.imageUrls[0],
                width: double.infinity,
                fit: BoxFit.cover,
                height: 200,
                errorBuilder: (context, error, stackTrace) => 
                  Container(
                    height: 200,
                    color: Colors.grey.shade300,
                    child: const Center(child: Text('Image not loaded')),
                  ),
              ),
            ),
            const SizedBox(height: 16),

            // Nama dan Harga
            Text(
              game.name,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              priceDisplay,
              style: const TextStyle( 
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Colors.black, 
              ),
            ),
            const Divider(height: 32, thickness: 1),

            // Informasi Rilis dan Review
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildInfoChip(
                  icon: Icons.calendar_today,
                  label: 'Release Date',
                  value: game.releaseDate,
                ),
                _buildInfoChip(
                  icon: Icons.star,
                  label: 'Review Avg',
                  value: game.reviewAverage,
                ),
                _buildInfoChip(
                  icon: Icons.people,
                  label: 'Total Reviews',
                  value: game.reviewCount,
                ),
              ],
            ),
            const Divider(height: 32, thickness: 1),

            // Tentang Game (About)
            const Text(
              'About This Game',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              game.about,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),

            // Tags
            const Text(
              'Tags',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: game.tags.map((tag) => Chip(
                label: Text(tag),
                backgroundColor: const Color.fromARGB(255, 255, 192, 247),
                labelStyle: TextStyle(color: const Color.fromARGB(255, 124, 80, 118), fontWeight: FontWeight.bold),
              )).toList(),
            ),
            const SizedBox(height: 24),

            // Link ke Store (Dengan url_launcher)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  _launchUrl(game.linkStore);
                },
                icon: const Icon(Icons.storefront, color: Color.fromARGB(255, 2, 0, 1)),
                label: const Text(
                  'Go to Store Page',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 255, 192, 247),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Galeri Gambar (Image Gallery) - Vertikal
            const Text(
              'Image Gallery',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: game.imageUrls.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      game.imageUrls[index],
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => 
                        Container(
                          width: double.infinity,
                          height: 180,
                          color: Colors.grey.shade300,
                          child: Center(child: Text('Image ${index + 1}')),
                        ),
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

  Widget _buildInfoChip({required IconData icon, required String label, required String value}) {
    return Column(
      children: [
        Icon(icon, color: const Color.fromARGB(255, 255, 192, 247), size: 24),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}