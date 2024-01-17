# Database System for an e-library Application #

## Deskripsi Project ##
Project ini bertujuan untuk merancang sistem database untuk aplikasi e-library atau perpustakaan online. Aplikasi ini mengawasi banyak perpustakaan, masing-masing menampung beragam koleksi buku dengan jumlah berbeda yang tersedia untuk dipinjam. Pengguna dapat meminjam atau mem-booking buku (bila buku tidak segera tersedia untuk dipinjam).
Dataset tidak disediakan sehingga dataset perlu dibuat secara mandiri dengan beberapa pilihan metode. Salah satu metode yang ditawarkan adalah menggunakan pemrograman Python dengan meng-generate dummy dataset menggunakan library Faker. Metode ini lah yang digunakan untuk membuat dataset pada project ini.
Tools yang digunakan pada project ini adalah PostgreSQL, Google Colab untuk melakukan pemrograman Python, dan juga dbdiagram.io untuk membuat Entity Relationship Diagram (ERD).

## Mission Statement ##
E-library application adalah aplikasi yang dirancang untuk memudahkan pecinta buku untuk meminjam buku secara online. Dibutuhkan database yang mampu mengelola data untuk aplikasi tersebut. Agar aplikasi dapat berjalankan dengan mengedepankan kualitas pelayanan, maka dibutuhkan beberapa ketentuan dalam sistem database.

Perpustakaan yang terdaftar di dalam perpustakaan online ini adalah sebanyak 34 perpustakaan yang merupakan cabang perpustakaan di setiap provinsi yang ada di Indonesia. Setiap perpustakaan memiliki koleksi buku dengan berbagai macam kategori. Buku yang tersedia di perpustakaan online ini berjumlah sebanyak 1000 buku dengan jumlah yang bervariasi untuk setiap bukunya.

Pengguna aplikasi ini dapat meminjam maksimal 2 buku pada waktu yang sama dengan masa peminjaman tidak lebih dari 14 hari. Buku dapat dikembalikan sebelum tenggat waktu tercapai. Namun, jika buku tidak dikembalikan dalam waktu 14 hari, maka buku akan ditarik secara otomatis oleh sistem. 

Jika buku yang akan dipinjam oleh pengguna sedang tidak tersedia, pengguna dapat melakukan booking dengan maksimal jumlah buku yang dapat di-booking adalah 2 buku pada waktu yang sama.

Aplikasi ini memberikan akses kepada pengguna untuk melakukan peminjaman, melakukan booking, serta personalisasi profil. Selain itu, aplikasi ini senantiasa menyimpan aktifitas peminjaman dan booking yang dilakukan oleh pengguna sebagai data yang dapat diolah dikemudian hari untuk kepentingan tertentu.

Adapun batasan-batasan yang terdapat pada database ini adalah sebagai berikut.

1. Fitur “Setiap user dapat meninjam maksimal 2 buku” dan “Setiap user dapat menunggu maksimal 2 buku” pada database ini tidak dibangun menggunakan logic Python. Namun, pada saat dummy dataset sudah di-import ke database, dilakukan query untuk melihat apakah ada user yang tercatat meminjam/mem-booking lebih dari 2 buku. Jika ada, raw datanya akan dimodifikasi agar memenuhi kriteria tersebut untuk kepentingan analisis. (penjelasan pada bagian Lain-lain)
2. Pada tabel loans dan books ataupun holds dan books, jika dilakukan perbandinagn mungkin ditemukan jumlah buku yang terpinjam/ditunggu melebihi jumlah buku yang tersedia karena data tersebut di-generate secara random menggunakan library Faker.
3.  Buku dengan id yang sama pada tabel loans dan holds ketika dijumlahkan pada periode “active loan” dapat melebihi jumlah buku yang tersedia. Ini juga disebabkan dataset yang di-generate secara random menggunakan library Faker.
4. Pada requirement soal terdapat fitur “The library maintains a hold queue, and when a book becomes available, it can be borrowed by the customer at the front of the queue. Additionally, if a customer doesn't borrow a held book within one week, the book is released for other users to borrow.“. Fitur ini tidak terdefinisi pada database ini.

## Entity Relationship Diagram ##
![image](https://github.com/alfayyedh/e-library-database/assets/144636916/1a50deff-9786-4418-8330-a5fbe1de6fca)





