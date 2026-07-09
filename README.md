# Kiosk Audio Scheduler (PlayAudioBg)

[![Platform](https://img.shields.io/badge/platform-Windows%2010%20%7C%2011-blue)](https://www.microsoft.com/windows)
[![Built with](https://img.shields.io/badge/Built%20with-Delphi%20%2F%20FMX-red)](https://www.embarcadero.com/products/delphi)

Aplikasi background murni (tanpa GUI & tanpa jendela konsol) berbasis Delphi yang dirancang khusus untuk kebutuhan komputer **Kiosk / Public Service Mall (MPP)**. Aplikasi ini berfungsi untuk memutar file audio notifikasi atau lagu kebangsaan secara berkala dan terjadwal melalui Windows Task Scheduler tanpa mengganggu tampilan layar kiosk utama.

## ✨ Fitur Utama
* **100% Silent Background:** Berjalan tanpa memunculkan jendela Command Prompt atau aplikasi pemutar musik (seperti Windows Media Player), sehingga aman dari gangguan visual di layar Kiosk.
* **Portable Path Resolution:** Otomatis mendeteksi file audio yang berada di satu folder yang sama dengan file `.exe`.
* **Auto-Terminate:** Aplikasi langsung menutup diri secara bersih (*killed from memory*) begitu durasi audio selesai diputar.
* **Native Audio Engine:** Menggunakan framework FireMonkey (FMX) Media Player bawaan yang stabil dan minim *resource* CPU/RAM.

---

## 📂 Struktur Penempatan File

Agar aplikasi dapat berjalan dengan baik, pastikan file eksekusi (`.exe`) dan file audio berada di dalam **satu folder yang sama**. Anda bebas meletakkan folder ini di direktori mana pun (direkomendasikan di luar Drive C untuk menghindari kendala hak akses/permission).

**Contoh Struktur Folder:**
```text
D:\KioskTools\AudioScheduler\
├── PlayAudioBg.exe      <-- Aplikasi hasil compile Delphi
└── audio.mp3            <-- File audio yang akan diputar (wajib bernama audio.mp3)

📌 **Catatan:** Jika Anda ingin memutar lagu yang berbeda (misalnya: *Indonesia Raya*), cukup ganti nama file lagu tersebut menjadi `audio.mp3` dan letakkan di folder yang sama.

---

## ⚙️ Panduan Konfigurasi Windows Task Scheduler (Detail)

Untuk menjalankan audio ini secara berulang (misalkan setiap hari jam 10.00), ikuti langkah-langkah presisi berikut:

### Langkah 1: Membuat Task Baru
1. Tekan tombol `Windows + R`, ketik `taskschd.msc`, lalu tekan **Enter**.
2. Pada panel *Actions* di sebelah kanan, klik **Create Task...** (Jangan memilih *Create Basic Task*).

### Langkah 2: Mengatur Tab 'General'
1. **Name:** Isi dengan nama yang jelas, contoh: `Kiosk_Pemutar_Indonesia_Raya`.
2. **Security options:** * Pilih **`Run only when user is logged on`**.
   * ⚠️ **PENTING:** Jangan memilih *"Run whether user is logged on or not"*, karena Windows akan mengisolasi output audio ke **Session 0** sehingga suara tidak akan keluar ke speaker.

### Langkah 3: Mengatur Waktu & Pengulangan (Tab 'Triggers')
1. Klik tombol **New...**.
2. Pada bagian *Begin the task*, pilih **On a schedule**.
3. Pada bagian *Settings*, pilih **Daily** dan atur waktu mulai pada jam **10:00:00 AM** (atau sesuaikan dengan kebutuhan Kiosk Anda).
4. *(Opsional)* Jika ingin diulang setiap beberapa jam dalam sehari:
   * Di bawah *Advanced settings*, centang **Repeat task every:** lalu pilih/ketik rentang waktu (misal: `1 hour`).
   * Set *for a duration of:* menjadi **Indefinitely** (Selamanya).
5. Pastikan opsi **Enabled** di bagian bawah telah dicentang, lalu klik **OK**.

### Langkah 4: Mengatur Eksekusi Aplikasi (Tab 'Actions')
1. Klik tombol **New...**.
2. Set *Action* menjadi **Start a program**.
3. Pada kolom **Program/script**, klik **Browse...** dan arahkan ke file `.exe` Anda, contoh: `D:\KioskTools\AudioScheduler\PlayAudioBg.exe`.
4. ⚠️ **SANGAT PENTING:** Pada kolom **Start in (optional)**, masukkan alamat folder tempat `.exe` berada **TANPA tanda kutip**.
   * *Contoh:* `D:\KioskTools\AudioScheduler`
   * *Jika kolom ini dikosongkan, aplikasi akan gagal menemukan file `audio.mp3` karena direktori default Windows Task Scheduler akan beralih ke `C:\Windows\System32`.*
5. Klik **OK**.

### Langkah 5: Mengatur Kondisi Daya (Tab 'Conditions')
1. Masuk ke tab **Conditions**.
2. Hapus centang pada opsi **Start the task only if the computer is on AC power** (Ini memastikan aplikasi tetap berjalan jika komputer kiosk menggunakan UPS atau berupa mini-PC/laptop mini yang mendeteksi daya baterai).

---

## 🧪 Cara Pengujian Manual
Setelah semua langkah di atas selesai dikonfigurasi:
1. Kembali ke halaman utama Task Scheduler, lalu cari task `Kiosk_Pemutar_Indonesia_Raya` di daftar tengah.
2. **Klik kanan** pada nama task tersebut, lalu pilih **Run**.
3. Audio akan langsung terdengar dari speaker Kiosk secara senyap tanpa memunculkan jendela apa pun. Setelah audio selesai, status Task akan kembali menjadi *Ready*.

---

## 🛠️ Pengembangan (Development)
Aplikasi ini dikembangkan menggunakan **Delphi** dengan target platform Windows 32-bit/64-bit menggunakan pendekatan aplikasi GUI tanpa Form (mengabaikan inisialisasi `Vcl.Forms` atau `FMX.Forms`) untuk menghasilkan performa background murni.