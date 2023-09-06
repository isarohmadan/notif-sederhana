#!/bin/bash

# Fungsi untuk menampilkan durasi waktu dalam format HH:MM:SS
tampilkan_durasi() {
  durasi=$1
  jam=$((durasi / 3600))
  menit=$(( (durasi % 3600) / 60 ))
  detik=$((durasi % 60))
  printf "%02d:%02d:%02d\n" $jam $menit $detik
}




# fungsi membuat log 
create_log(){
  # ini pesan yang ada di file textnya
  pesan="$3 | Aplikasi : $1 dengan waktu penggunaan $2 "

  file="logFile.txt"  # Gantilah dengan nama file yang Anda inginkan

    # Periksa apakah file sudah ada
    if [ -f "$file" ]; then
      # File sudah ada, tambahkan konten ke file
      echo $pesan >> "$file"
    else
      # File belum ada, buat file dan tambahkan konten
      echo $pesan > "$file"
    fi
}


# Inisialisasi Parameter dengan variable
parameter_waktu=$(($1 * 60))
parameter_waktu_setengah=$(($parameter_waktu / 2))
helper=0
# parameter kedua berisi application name
nama_aplikasi=$2

# membuka terminal baru untuk menjalankan applikasi
gnome-terminal -- bash -c  "$nama_aplikasi; exec bash"

# Catat waktu mulai aplikasi
waktu_mulai=$(date +%s)

# Menunggu sampai waktu habis
echo ""
echo ""
echo "Selamat menggunakan aplikasi sampai jatuh tempo waktu yang di set!"

# perulangan untuk memastikan apakah udah jatuh tempo atau belum
while true; do
  # ini adalah waktu durasi yang sudah berlangsung
  durasinya=$(($(date +%s) - waktu_mulai))

  # ini pengkondisian jika durasinya sudah mencapai setengah waktu yang di tentukan
  if [ "$durasinya" == "$parameter_waktu_setengah" ] && [ "$helper" == "0" ]; then
      notify-send "Pemberitahuan~~" "Waktu sudah setengah jalan coy!"
      helper=1
  fi
  # ini pengkondisian jika durasinya sudah mencapai waktu yang di tentukan
  if [ "$durasinya" == "$parameter_waktu" ]; then
      notify-send "Pemberitahuan~~" "Waktu sudah HABISSS!"
	    pkill $3	  
    break
  fi

done

# Catat waktu selesai aplikasi
waktu_selesai=$(date +%s)

# Hitung durasi penggunaan aplikasi
durasi_penggunaan=$((waktu_selesai - waktu_mulai))
format_durasi=$(tampilkan_durasi $durasi_penggunaan)

# membuat log dengan funsi create log yang parameternya yaitu
# 1 nama applikasinya 
# 2 format durasinya seperti 00:12:00 berarti 12 menit
# 3 adalah tanggal d m y berarti day month dan year
create_log $nama_aplikasi $format_durasi $(date +"%d-%m-%Y")

# Menampilkan durasi penggunaan
notify-send "Pemberitahuan~~" "Waktu anda  $format_durasi"


