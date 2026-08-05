import 'package:flutter/material.dart';

import '../../models/recommendation/permit_recommendation_item.dart';
import '../../models/simulation/simulation_data.dart';
import 'decision_tree_engine.dart';

class PermitRecommendationEngine {
  static List<PermitRecommendationItem> generate(
    SimulationData data,
  ) {
    final items = <PermitRecommendationItem>[];

    final ruleIds =
        DecisionTreeEngine.evaluate(data);

    for (final rule in ruleIds) {
      final item = _buildRule(rule, data);

      if (item != null) {
        items.add(item);
      }
    }

    items.sort(
      (a, b) =>
          a.priority.compareTo(b.priority),
    );

    return items;
  }

static PermitRecommendationItem? _buildRule(
  String rule,
  SimulationData data,
) {
  switch (rule) {
    case 'HALAL':
      return PermitRecommendationItem(
        id: 'halal',
        title: 'Sertifikat Halal',
        subtitle:
            'Penting untuk usaha makanan dan minuman.',
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
      );

    case 'PIRT':
      return PermitRecommendationItem(
        id: 'pirt',
        title: 'PIRT',
        subtitle:
            'Perizinan pangan olahan skala rumah tangga.',
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
      );

    case 'SNI':
      return PermitRecommendationItem(
        id: 'sni',
        title: 'SNI',
        subtitle:
            'Standar mutu untuk produk manufaktur.',
        reason:
            'Kategori manufaktur umumnya lebih relevan diarahkan ke pemenuhan Standar Nasional Indonesia jika belum dimiliki.',
        statusLabel: 'Prioritas tinggi',
        icon:
            Icons.workspace_premium_outlined,
        color: Colors.blueGrey,
        isCompleted: false,
        priority: 0,
        highlights: const [
          'Kategori manufaktur',
          'Standar produk',
        ],
      );

      case 'NPWP':
        return PermitRecommendationItem(
          id: 'npwp',
          title: 'NPWP Usaha',
          subtitle:
              'Identitas pajak untuk administrasi usaha.',
          reason:
              'NPWP usaha disarankan sebagai identitas administrasi pajak dan dasar legalitas lanjutan untuk usaha yang sedang berkembang.',
          statusLabel: 'Disarankan',
          icon: Icons.receipt_long_outlined,
          color: Colors.orange,
          isCompleted: false,
          priority: 1,
          highlights: const [
            'Administrasi pajak',
            'Legalitas lanjutan',
          ],
        );

      case 'STANDAR':
        return PermitRecommendationItem(
          id: 'standar',
          title: 'Sertifikat Standar',
          subtitle:
              'Relevan untuk usaha dengan risiko menengah.',
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
        );

      case 'PBG':
        return PermitRecommendationItem(
          id: 'pbg',
          title: 'PBG',
          subtitle:
              'Perizinan jika ada pembangunan gedung.',
          reason:
              'Data simulasi menunjukkan usaha akan melakukan pembangunan gedung sehingga aspek bangunan perlu diperhatikan.',
          statusLabel: 'Bila diperlukan',
          icon: Icons.apartment_outlined,
          color: Colors.brown,
          isCompleted: false,
          priority: 3,
          highlights: const [
            'Pembangunan gedung',
            'Aspek lokasi usaha',
          ],
        );

      case 'MEREK':
        return PermitRecommendationItem(
          id: 'merek',
          title: 'Hak Merek',
          subtitle:
              'Perlindungan identitas dan nama usaha.',
          reason:
              'Nama usaha sudah diisi sehingga perlindungan merek dapat dipertimbangkan untuk menjaga identitas bisnis.',
          statusLabel: 'Opsional penting',
          icon: Icons.sell_outlined,
          color: Colors.teal,
          isCompleted: false,
          priority: 4,
          highlights: const [
            'Nama usaha',
            'Brand bisnis',
          ],
        );

      default:
        return null;
    }
  }  
}