import 'package:flutter/material.dart';

import '../../models/recommendation/permit_recommendation_item.dart';
import '../../models/simulation/simulation_data.dart';

class PermitRecommendationEngine {
  static List<PermitRecommendationItem> generate(
    SimulationData data,
  ) {
    final items = <PermitRecommendationItem>[];

    final category = (data.businessCategory ?? '').trim();
    final businessScale = (data.businessScale ?? '').trim();
    final riskLevel = (data.riskLevel ?? '').trim();
    final businessName = (data.businessName ?? '').trim();
    final hasNpwp = _isYes(data.hasNpwp);
    final hasHalalCertificate = _isYes(data.hasHalalCertificate);
    final hasSni = _isYes(data.hasSni);
    final buildingConstruction =
        (data.buildingConstruction ?? '').trim() == 'Ya';

    void addItem(PermitRecommendationItem item) {
      items.add(item);
    }

    switch (category) {
      case 'Kuliner':
        if (!hasHalalCertificate) {
          addItem(
            PermitRecommendationItem(
              id: 'halal',
              title: 'Sertifikat Halal',
              subtitle: 'Penting untuk usaha makanan dan minuman.',
              reason:
                  'Untuk kategori kuliner, sertifikat halal menjadi prioritas utama jika belum dimiliki agar usaha lebih siap dari sisi kepercayaan konsumen dan kepatuhan usaha.',
              statusLabel: 'Prioritas tinggi',
              icon: Icons.verified_user_outlined,
              color: Colors.purple,
              isCompleted: false,
              priority: 0,
              highlights: const [
                'Produk makanan/minuman',
                'Kepercayaan konsumen',
              ],
            ),
          );
        }

        if (businessScale == 'Mikro' || businessScale == 'Kecil') {
          addItem(
            PermitRecommendationItem(
              id: 'pirt',
              title: 'PIRT',
              subtitle: 'Perizinan pangan olahan skala rumah tangga.',
              reason:
                  'Kategori kuliner dengan skala mikro atau kecil umumnya relevan diarahkan ke PIRT sebagai izin lanjutan untuk produk olahan.',
              statusLabel: 'Direkomendasikan',
              icon: Icons.food_bank_outlined,
              color: Colors.deepOrange,
              isCompleted: false,
              priority: 1,
              highlights: const [
                'Usaha kuliner',
                'Skala mikro/kecil',
              ],
            ),
          );
        }

        if (!hasNpwp) {
          addItem(
            PermitRecommendationItem(
              id: 'npwp',
              title: 'NPWP Usaha',
              subtitle: 'Identitas pajak untuk administrasi usaha.',
              reason:
                  'NPWP usaha disarankan sebagai identitas administrasi pajak dan dasar legalitas lanjutan untuk usaha yang sedang berkembang.',
              statusLabel: 'Disarankan',
              icon: Icons.receipt_long_outlined,
              color: Colors.orange,
              isCompleted: false,
              priority: 2,
              highlights: const [
                'Administrasi pajak',
                'Legalitas lanjutan',
              ],
            ),
          );
        }

        if (riskLevel == 'Sedang') {
          addItem(
            PermitRecommendationItem(
              id: 'standar',
              title: 'Sertifikat Standar',
              subtitle: 'Relevan untuk usaha dengan risiko menengah.',
              reason:
                  'Hasil validasi risiko menunjukkan usaha Anda perlu memperhatikan pemenuhan standar perizinan lanjutan.',
              statusLabel: 'Relevan',
              icon: Icons.verified_outlined,
              color: Colors.green,
              isCompleted: false,
              priority: 3,
              highlights: const [
                'Risiko menengah',
                'Izin lanjutan',
              ],
            ),
          );
        }

        if (buildingConstruction) {
          addItem(
            PermitRecommendationItem(
              id: 'pbg',
              title: 'PBG',
              subtitle: 'Perizinan jika ada pembangunan gedung.',
              reason:
                  'Data simulasi menunjukkan usaha akan melakukan pembangunan gedung, sehingga aspek bangunan perlu diperhatikan.',
              statusLabel: 'Bila diperlukan',
              icon: Icons.apartment_outlined,
              color: Colors.brown,
              isCompleted: false,
              priority: 4,
              highlights: const [
                'Pembangunan gedung',
                'Aspek lokasi usaha',
              ],
            ),
          );
        }

        if (businessName.isNotEmpty) {
          addItem(
            PermitRecommendationItem(
              id: 'merek',
              title: 'Hak Merek',
              subtitle: 'Perlindungan identitas dan nama usaha.',
              reason:
                  'Nama usaha sudah diisi, sehingga perlindungan merek bisa dipertimbangkan untuk menjaga identitas bisnis.',
              statusLabel: 'Opsional penting',
              icon: Icons.sell_outlined,
              color: Colors.teal,
              isCompleted: false,
              priority: 5,
              highlights: const [
                'Nama usaha',
                'Brand bisnis',
              ],
            ),
          );
        }
        break;

      case 'Manufaktur':
        if (!hasSni) {
          addItem(
            PermitRecommendationItem(
              id: 'sni',
              title: 'SNI',
              subtitle: 'Standar mutu untuk produk manufaktur.',
              reason:
                  'Kategori manufaktur umumnya lebih relevan diarahkan ke pemenuhan Standar Nasional Indonesia jika belum dimiliki.',
              statusLabel: 'Prioritas tinggi',
              icon: Icons.workspace_premium_outlined,
              color: Colors.blueGrey,
              isCompleted: false,
              priority: 0,
              highlights: const [
                'Kategori manufaktur',
                'Standar produk',
              ],
            ),
          );
        }

        if (!hasNpwp) {
          addItem(
            PermitRecommendationItem(
              id: 'npwp',
              title: 'NPWP Usaha',
              subtitle: 'Identitas pajak untuk administrasi usaha.',
              reason:
                  'NPWP usaha disarankan untuk kelengkapan administrasi pajak dan legalitas lanjutan.',
              statusLabel: 'Disarankan',
              icon: Icons.receipt_long_outlined,
              color: Colors.orange,
              isCompleted: false,
              priority: 1,
              highlights: const [
                'Administrasi pajak',
                'Legalitas lanjutan',
              ],
            ),
          );
        }

        if (riskLevel == 'Sedang') {
          addItem(
            PermitRecommendationItem(
              id: 'standar',
              title: 'Sertifikat Standar',
              subtitle: 'Relevan untuk usaha dengan risiko menengah.',
              reason:
                  'Hasil validasi risiko menunjukkan usaha Anda perlu memperhatikan pemenuhan standar perizinan lanjutan.',
              statusLabel: 'Relevan',
              icon: Icons.verified_outlined,
              color: Colors.green,
              isCompleted: false,
              priority: 2,
              highlights: const [
                'Risiko menengah',
                'Izin lanjutan',
              ],
            ),
          );
        }

        if (buildingConstruction) {
          addItem(
            PermitRecommendationItem(
              id: 'pbg',
              title: 'PBG',
              subtitle: 'Perizinan jika ada pembangunan gedung.',
              reason:
                  'Karena ada pembangunan gedung pada simulasi, aspek bangunan juga perlu diperhatikan.',
              statusLabel: 'Bila diperlukan',
              icon: Icons.apartment_outlined,
              color: Colors.brown,
              isCompleted: false,
              priority: 3,
              highlights: const [
                'Pembangunan gedung',
                'Aspek lokasi usaha',
              ],
            ),
          );
        }

        if (businessName.isNotEmpty) {
          addItem(
            PermitRecommendationItem(
              id: 'merek',
              title: 'Hak Merek',
              subtitle: 'Perlindungan identitas dan nama usaha.',
              reason:
                  'Nama usaha sudah diisi, sehingga perlindungan merek bisa dipertimbangkan untuk menjaga identitas bisnis.',
              statusLabel: 'Opsional penting',
              icon: Icons.sell_outlined,
              color: Colors.teal,
              isCompleted: false,
              priority: 4,
              highlights: const [
                'Nama usaha',
                'Brand bisnis',
              ],
            ),
          );
        }
        break;

      case 'Perdagangan':
      case 'Jasa':
      case 'Teknologi':
      case 'Pendidikan':
      case 'Pariwisata':
      case 'Pertanian':
      case 'Kesehatan':
      case 'Usaha Lainnya':
      default:
        if (!hasNpwp) {
          addItem(
            PermitRecommendationItem(
              id: 'npwp',
              title: 'NPWP Usaha',
              subtitle: 'Identitas pajak untuk administrasi usaha.',
              reason:
                  'NPWP usaha tetap menjadi rekomendasi dasar untuk kelengkapan administrasi pajak dan legalitas lanjutan.',
              statusLabel: 'Disarankan',
              icon: Icons.receipt_long_outlined,
              color: Colors.orange,
              isCompleted: false,
              priority: 0,
              highlights: const [
                'Administrasi pajak',
                'Legalitas lanjutan',
              ],
            ),
          );
        }

        if (riskLevel == 'Sedang') {
          addItem(
            PermitRecommendationItem(
              id: 'standar',
              title: 'Sertifikat Standar',
              subtitle: 'Relevan untuk usaha dengan risiko menengah.',
              reason:
                  'Hasil validasi risiko menunjukkan usaha Anda perlu memperhatikan pemenuhan standar perizinan lanjutan.',
              statusLabel: 'Relevan',
              icon: Icons.verified_outlined,
              color: Colors.green,
              isCompleted: false,
              priority: 1,
              highlights: const [
                'Risiko menengah',
                'Izin lanjutan',
              ],
            ),
          );
        }

        if (buildingConstruction) {
          addItem(
            PermitRecommendationItem(
              id: 'pbg',
              title: 'PBG',
              subtitle: 'Perizinan jika ada pembangunan gedung.',
              reason:
                  'Karena ada pembangunan gedung pada simulasi, aspek bangunan juga perlu diperhatikan.',
              statusLabel: 'Bila diperlukan',
              icon: Icons.apartment_outlined,
              color: Colors.brown,
              isCompleted: false,
              priority: 2,
              highlights: const [
                'Pembangunan gedung',
                'Aspek lokasi usaha',
              ],
            ),
          );
        }

        if (businessName.isNotEmpty) {
          addItem(
            PermitRecommendationItem(
              id: 'merek',
              title: 'Hak Merek',
              subtitle: 'Perlindungan identitas dan nama usaha.',
              reason:
                  'Nama usaha sudah diisi, sehingga perlindungan merek bisa dipertimbangkan untuk menjaga identitas bisnis.',
              statusLabel: 'Opsional penting',
              icon: Icons.sell_outlined,
              color: Colors.teal,
              isCompleted: false,
              priority: 3,
              highlights: const [
                'Nama usaha',
                'Brand bisnis',
              ],
            ),
          );
        }
        break;
    }

    items.sort((a, b) => a.priority.compareTo(b.priority));
    return items;
  }

  static bool _isYes(String? value) {
    return value?.trim().toLowerCase() == 'ya';
  }
}