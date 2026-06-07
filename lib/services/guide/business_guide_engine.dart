import 'package:flutter/material.dart';

import '../../models/guide/guide_item.dart';
import '../../models/simulation/simulation_data.dart';

class BusinessGuideEngine {
  static List<GuideItem> generate(SimulationData? data) {
    final items = <GuideItem>[];

    final category = (data?.businessCategory ?? '').trim();
    final businessScale = (data?.businessScale ?? '').trim();
    final riskLevel = (data?.riskLevel ?? '').trim();
    final businessName = (data?.businessName ?? '').trim();
    final hasNpwp = _isYes(data?.hasNpwp);
    final hasHalalCertificate = _isYes(data?.hasHalalCertificate);
    final hasSni = _isYes(data?.hasSni);
    final buildingConstruction =
        (data?.buildingConstruction ?? '').trim() == 'Ya';

    final completed = data?.nibCompleted ?? false;

    void addItem(GuideItem item) {
      items.add(item);
    }

    addItem(
      GuideItem(
        id: 'nib',
        title: 'Nomor Induk Berusaha (NIB)',
        subtitle: 'Panduan dasar untuk semua pengguna.',
        overview:
            'NIB adalah identitas dasar usaha di OSS dan menjadi pintu awal untuk banyak proses perizinan.',
        icon: Icons.badge_outlined,
        color: const Color(0xFF2D9CDB),
        isUnlocked: true,
        priority: 0,
        highlights: const [
          'Terbuka untuk semua',
          'Dasar legalitas',
        ],
        sections: const [
          GuideSection(
            title: 'Apa itu NIB?',
            body:
                'NIB adalah identitas usaha yang digunakan di sistem OSS untuk memulai proses legalitas usaha.',
            bullets: [
              'Menjadi identitas dasar usaha',
              'Digunakan untuk banyak proses perizinan',
              'Sering menjadi syarat awal pengurusan izin lain',
            ],
          ),
          GuideSection(
            title: 'Mengapa penting?',
            body:
                'Dengan NIB, usaha memiliki dasar legalitas yang lebih jelas dan lebih mudah mengikuti alur layanan perizinan.',
            bullets: [
              'Mempermudah akses layanan OSS',
              'Menjadi dasar pengurusan izin lanjutan',
              'Membantu usaha terlihat lebih resmi',
            ],
          ),
          GuideSection(
            title: 'Tahapan umum',
            body:
                'Secara umum, pembuatan NIB dilakukan dengan langkah yang sederhana dan terarah.',
            bullets: [
              'Masuk ke OSS',
              'Lengkapi data usaha',
              'Pilih bidang usaha',
              'Tinjau dan terbitkan NIB',
            ],
          ),
          GuideSection(
            title: 'Tips',
            body:
                'Pastikan data usaha sudah konsisten sebelum diterbitkan agar proses berikutnya lebih lancar.',
            bullets: [
              'Gunakan data usaha yang benar',
              'Cek kembali kategori dan KBLI',
              'Pastikan alur simulasi selesai sampai akhir',
            ],
          ),
        ],
      ),
    );

    // Panduan lanjutan hanya terbuka setelah simulasi NIB selesai.
    final bool unlockedOthers = completed;

    // General / lintas kategori
    addItem(
      GuideItem(
        id: 'npwp',
        title: 'NPWP Usaha',
        subtitle: unlockedOthers
            ? 'Identitas pajak untuk administrasi usaha.'
            : 'Tersedia setelah simulasi NIB selesai.',
        overview:
            'NPWP usaha penting untuk administrasi pajak dan kelengkapan legalitas usaha.',
        icon: Icons.receipt_long_outlined,
        color: Colors.orange,
        isUnlocked: unlockedOthers,
        priority: hasNpwp ? 5 : 1,
        highlights: const [
          'Administrasi pajak',
          'Kelengkapan legalitas',
        ],
        sections: const [
          GuideSection(
            title: 'Kapan dipelajari?',
            body:
                'Panduan NPWP relevan untuk usaha yang ingin menata administrasi pajak secara lebih rapi.',
            bullets: [
              'Saat usaha mulai berjalan',
              'Saat kebutuhan administrasi meningkat',
              'Saat ingin mengelola legalitas lebih lengkap',
            ],
          ),
          GuideSection(
            title: 'Yang perlu dipahami',
            body:
                'NPWP membantu identitas pajak usaha menjadi lebih jelas di mata administrasi.',
            bullets: [
              'Data identitas usaha',
              'Kebutuhan pajak',
              'Keterkaitan dengan transaksi usaha',
            ],
          ),
        ],
      ),
    );

    addItem(
      GuideItem(
        id: 'halal',
        title: 'Sertifikat Halal',
        subtitle: unlockedOthers
            ? 'Panduan penting untuk usaha makanan dan minuman.'
            : 'Tersedia setelah simulasi NIB selesai.',
        overview:
            'Sertifikat halal penting untuk usaha kuliner agar lebih siap bersaing dan lebih dipercaya konsumen.',
        icon: Icons.verified_user_outlined,
        color: Colors.green,
        isUnlocked: unlockedOthers,
        priority: category == 'Kuliner' && !hasHalalCertificate ? 1 : 6,
        highlights: const [
          'Usaha kuliner',
          'Produk makanan/minuman',
        ],
        sections: const [
          GuideSection(
            title: 'Kapan relevan?',
            body:
                'Panduan ini sangat relevan untuk usaha makanan dan minuman.',
            bullets: [
              'Kategori kuliner',
              'Produk siap konsumsi',
              'Usaha yang ingin meningkatkan kepercayaan konsumen',
            ],
          ),
          GuideSection(
            title: 'Yang perlu dipahami',
            body:
                'Pemahaman halal biasanya terkait bahan, proses, dan identitas produk.',
            bullets: [
              'Komposisi bahan',
              'Proses produksi',
              'Label dan identitas produk',
            ],
          ),
        ],
      ),
    );

    addItem(
      GuideItem(
        id: 'pirt',
        title: 'PIRT',
        subtitle: unlockedOthers
            ? 'Perizinan untuk pangan olahan skala rumah tangga.'
            : 'Tersedia setelah simulasi NIB selesai.',
        overview:
            'PIRT relevan untuk produk pangan olahan skala rumah tangga atau usaha kecil yang memproduksi makanan.',
        icon: Icons.food_bank_outlined,
        color: Colors.deepOrange,
        isUnlocked: unlockedOthers,
        priority: category == 'Kuliner' &&
                (businessScale == 'Mikro' || businessScale == 'Kecil')
            ? 2
            : 7,
        highlights: const [
          'Skala mikro/kecil',
          'Pangan olahan',
        ],
        sections: const [
          GuideSection(
            title: 'Kapan relevan?',
            body:
                'Panduan ini cocok untuk usaha pangan olahan skala kecil.',
            bullets: [
              'Usaha kuliner rumah tangga',
              'Produk olahan skala kecil',
              'Usaha yang sedang berkembang',
            ],
          ),
          GuideSection(
            title: 'Yang perlu dipahami',
            body:
                'PIRT berkaitan dengan standar dasar pengolahan pangan dan distribusi produk.',
            bullets: [
              'Proses produksi',
              'Kebersihan produk',
              'Distribusi pangan olahan',
            ],
          ),
        ],
      ),
    );

    addItem(
      GuideItem(
        id: 'sni',
        title: 'SNI',
        subtitle: unlockedOthers
            ? 'Standar mutu untuk produk manufaktur.'
            : 'Tersedia setelah simulasi NIB selesai.',
        overview:
            'SNI relevan untuk produk manufaktur yang perlu memenuhi standar nasional.',
        icon: Icons.workspace_premium_outlined,
        color: Colors.green,
        isUnlocked: unlockedOthers,
        priority: category == 'Manufaktur' && !hasSni ? 1 : 8,
        highlights: const [
          'Kategori manufaktur',
          'Standar produk',
        ],
        sections: const [
          GuideSection(
            title: 'Kapan relevan?',
            body:
                'Panduan ini cocok untuk usaha manufaktur yang ingin memahami standar produk.',
            bullets: [
              'Produk hasil manufaktur',
              'Usaha yang memerlukan standar mutu',
              'Peningkatan kualitas produk',
            ],
          ),
          GuideSection(
            title: 'Yang perlu dipahami',
            body:
                'SNI berhubungan dengan mutu, konsistensi, dan kepercayaan terhadap produk.',
            bullets: [
              'Konsistensi mutu',
              'Keamanan produk',
              'Kepercayaan pasar',
            ],
          ),
        ],
      ),
    );

    addItem(
      GuideItem(
        id: 'standar',
        title: 'Sertifikat Standar',
        subtitle: unlockedOthers
            ? 'Relevan untuk usaha dengan risiko menengah.'
            : 'Tersedia setelah simulasi NIB selesai.',
        overview:
            'Sertifikat standar dapat menjadi bagian penting bagi usaha dengan tingkat risiko menengah.',
        icon: Icons.verified_outlined,
        color: Colors.green,
        isUnlocked: unlockedOthers,
        priority: riskLevel == 'Sedang' ? 3 : 9,
        highlights: const [
          'Risiko menengah',
          'Izin lanjutan',
        ],
        sections: const [
          GuideSection(
            title: 'Mengapa dipelajari?',
            body:
                'Panduan ini relevan jika usaha Anda memiliki risiko yang membutuhkan pemenuhan standar lanjutan.',
            bullets: [
              'Menunjang legalitas lanjutan',
              'Mengikuti hasil validasi risiko',
              'Membantu usaha lebih siap secara administratif',
            ],
          ),
          GuideSection(
            title: 'Yang perlu dipahami',
            body:
                'Sertifikat standar biasanya dikaitkan dengan pemenuhan syarat tertentu yang perlu dipahami sejak awal.',
            bullets: [
              'Dokumen pendukung',
              'Pemenuhan standar usaha',
              'Kesiapan operasional',
            ],
          ),
        ],
      ),
    );

    addItem(
      GuideItem(
        id: 'merek',
        title: 'Hak Merek',
        subtitle: unlockedOthers
            ? 'Perlindungan identitas dan nama usaha.'
            : 'Tersedia setelah simulasi NIB selesai.',
        overview:
            'Hak merek penting untuk melindungi identitas usaha dan membangun brand yang lebih kuat.',
        icon: Icons.sell_outlined,
        color: Colors.teal,
        isUnlocked: unlockedOthers,
        priority: businessName.isNotEmpty ? 4 : 10,
        highlights: const [
          'Nama usaha',
          'Brand bisnis',
        ],
        sections: const [
          GuideSection(
            title: 'Mengapa penting?',
            body:
                'Hak merek membantu usaha memiliki perlindungan atas nama dan identitas brand.',
            bullets: [
              'Melindungi nama usaha',
              'Mengurangi risiko peniruan',
              'Mendukung citra brand',
            ],
          ),
          GuideSection(
            title: 'Yang perlu dipahami',
            body:
                'Pemahaman dasar tentang merek membantu usaha lebih siap berkembang secara profesional.',
            bullets: [
              'Identitas merek',
              'Pembedaan produk',
              'Perlindungan bisnis',
            ],
          ),
        ],
      ),
    );

    addItem(
      GuideItem(
        id: 'pbg',
        title: 'PBG',
        subtitle: unlockedOthers
            ? 'Panduan untuk usaha yang membangun gedung.'
            : 'Tersedia setelah simulasi NIB selesai.',
        overview:
            'PBG relevan jika usaha melakukan pembangunan gedung atau penyesuaian bangunan usaha.',
        icon: Icons.apartment_outlined,
        color: Colors.orange,
        isUnlocked: unlockedOthers,
        priority: buildingConstruction ? 5 : 11,
        highlights: const [
          'Bangunan usaha',
          'Aspek lokasi',
        ],
        sections: const [
          GuideSection(
            title: 'Kapan relevan?',
            body:
                'Panduan ini perlu dipahami jika usaha berhubungan dengan pembangunan gedung.',
            bullets: [
              'Pembangunan fasilitas usaha',
              'Penyesuaian bangunan',
              'Aspek lokasi usaha',
            ],
          ),
          GuideSection(
            title: 'Yang perlu dipahami',
            body:
                'Aspek bangunan sering terkait dengan kesiapan lokasi dan penggunaan ruang usaha.',
            bullets: [
              'Lokasi usaha',
              'Struktur bangunan',
              'Kebutuhan operasional',
            ],
          ),
        ],
      ),
    );

    items.sort((a, b) => a.priority.compareTo(b.priority));
    return items;
  }

  static bool _isYes(String? value) {
    return value?.trim().toLowerCase() == 'ya';
  }
}