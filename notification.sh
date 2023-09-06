#!/bin/bash

# clear untuk menghapus histori yang ada di layar
clear


# menggunakan zenity untuk menampilkan pesan pop up
zenity --info --title="Siri" --text="App Notifikasi"

# inisialisasi variable warna
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
RESET='\033[0m'


# pesan welcome 
echo -e "${GREEN}====================================${RESET}"
echo -e "${BLUE}   ||               ||  00<<<  ||      =====  ||===||  |0\    /0|  00<<<        ${RESET}"
echo -e "${CYAN}    ||     |||     ||   ||     ||      ||     ||   ||  |0|\  /|0|  ||           ${RESET}"
echo -e "${RED}     ||   || ||   ||    00<<<  ||      ||     ||   ||  || 0\/0 ||  00<<<        ${RESET}"
echo -e "${YELLOW}      ||00|   |00||     ||     ||      ||     ||   ||  ||      ||  ||           ${RESET}"
echo -e "${CYAN}       ||0      0||     00<<<  ======  =====  ||===||  ||      ||  00<<<        ${RESET}"
echo -e "${GREEN}====================================${RESET}"


# Ganti nama kalian disini 
# nama nama anggota
echo " "
echo -e "${RED}APLIKASI NOTIFIKASI${RESET}"
echo " "
echo "------------------------------------------------"
echo "- Putu Dharma Primandika(220040232) "
echo "- Putu Dharma Primandika(220040232) "
echo "- Putu Dharma Primandika(220040232) "
echo "- Putu Dharma Primandika(220040232) "
echo "------------------------------------------------"
echo " "


# Fungsi untuk menampilkan menu home
tampilkan_menu() {
    echo -e "=========== Menu Home ==========="
    echo -e "${BLUE}1.Membuat Sistem Notifikasi! ${RESET}"
    echo -e "${GREEN}2. Membaca Log Notifikasi! ${RESET}"
    echo -e "${RED}3. Keluar ${RESET}"
    echo "============================"
}

# Fungsi untuk menampilkan menu applikasi
tampilkan_menu_applikasi(){
    echo -e "=========== Menu Applikasi ==========="
    echo -e "${BLUE}1. Spotify${RESET}"
    echo -e "${GREEN}2. Google Chrome ${RESET}"
    echo "============================"
}

# inisialisasi variabel awal untuk membantu while nya dalam perulangan

selesai=false

# perulangan untuk menampilkan menu 
while [ "$selesai" = false ]; do
    # menampilkan menu
    tampilkan_menu

    # Meminta pengguna untuk memilih opsi
    read -p "Pilih opsi (1/2/3): " pilihan

    # Menggunakan case statement untuk menangani pilihan
    case $pilihan in
        1)
            application=''
            pidName=''
            tampilkan_menu_applikasi            
            read -p "Pilih opsi (1/2): " app

            # menggunakan case switch untuk menentukan applikasinya
            # application untuk mengexecute filenya sedangkan pidName digunakan untuk mematikan/kill appnya

            case $app in
            1)
                application="spotify"
                pidName="spotify"
                ;;
            2) 
                application="google-chrome"
                pidName="chrome"
                ;;
            *) 
            # ini jika input tidak valid
                echo "Pilihan tidak valid. Silakan coba lagi."
                read -p "Tekan Enter untuk melanjutkan..."
                ;;
                esac

            # memberikan limit waktu penggunaan applikasi!
            echo "Masukan Waktu Berapa limit waktu yang diberikan (Menit!)"
            read menit
            if [ -z "$menit" ]; then
                echo "Harus diisi dul!"
            else
                # Memanggil file durasi untuk memproses durasinya 
                # ada 3 parameter yaitu menit untuk informasi menitnya application untuk nama applikasi yg diexecute
                # dan pid name untuk informasi dalam mematikan applikasi atau kill app
                ./durasi.sh $menit $application $pidName
            fi

            # Tambahkan tindakan untuk Opsi 1 di sini
            ;;
        2)
            #  menampilkan hasil dari log atau histori penggunaan.
            echo "Berikut adalah hasil log selama ini : "

            cat logFile.txt
            ;;
        3)
        # keluar dari programnya
            echo "Keluar dari program."
            selesai=true
            ;;
        *)
        # ini kalo input tidak valid
            echo "Pilihan tidak valid. Silakan coba lagi."
            read -p "Tekan Enter untuk melanjutkan..."
            ;;
    esac
done