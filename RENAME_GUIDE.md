# GrandFlow Project Rename - Panduan Lengkap

## 🚀 Memulai Rename

Sebelum menjalankan script, pastikan:
1. ✅ Anda sudah backup repository
2. ✅ Git commit history sudah clean
3. ✅ Tidak ada perubahan yang belum di-commit

### Step 1: Clone Repository
```bash
cd ~/projects
git clone https://github.com/hbdiaz-dot/balaka.git
cd balaka
git checkout main
```

### Step 2: Jalankan Script Rename
```bash
chmod +x rename-project.sh
./rename-project.sh
```

Script akan melakukan:
- ✅ Rename direktori Java packages
- ✅ Replace semua referensi `balaka` → `grandflow`
- ✅ Replace semua referensi `artivisi` → `grandindo`
- ✅ Update pom.xml
- ✅ Update application properties
- ✅ Update database references
- ✅ Update GitHub references
- ✅ Generate laporan ringkasan

### Step 3: Verifikasi Perubahan
```bash
# Lihat file yang berubah
git status

# Lihat detail perubahan
git diff --stat

# Review perubahan penting
git diff pom.xml
git diff src/main/resources/
```

### Step 4: Build dan Test
```bash
# Clean build
./mvnw clean package -DskipTests

# Atau dengan test
./mvnw clean package

# Test aplikasi
java -jar target/grandflow-*.jar
```

### Step 5: Commit dan Push
```bash
git add .
git commit -m "refactor: rename project balaka→grandflow, artivisi→grandindo"
git push origin main
```

### Step 6: Update GitHub Repository
1. Buka https://github.com/hbdiaz-dot/balaka/settings
2. Di bagian "Repository name", ubah dari `balaka` → `grandflow`
3. Update description jika diperlukan
4. Update homepage URL jika ada

## 📝 File-file yang Akan Berubah

### Konfigurasi
- `pom.xml` - Project Group ID dan artifact ID
- `src/main/resources/application.yml` - Application properties
- `src/main/resources/application.properties` - Database connection
- `build.gradle` / `gradle.properties` - Gradle configuration

### Source Code
- `src/main/java/com/artivisi/` → `src/main/java/com/grandindo/`
- Semua file `.java` di dalam direktori
- Import statements di semua files
- Package declarations

### Database
- Migration files di `src/main/resources/db/migration/`
- SQL scripts yang reference nama aplikasi
- Seed data yang reference nama perusahaan

### Documentation
- `README.md`
- `docs/` directory
- Configuration guides

### Deployment
- `docker-compose.yml` - Image names dan container names
- `.github/workflows/` - CI/CD workflows
- `deploy/` scripts

### Configuration
- `.semgrep/` - Semgrep rules
- Ansible playbooks
- Pulumi configuration

## ⚠️ Manual Checks Setelah Rename

### 1. Verifikasi Database
```bash
# Check apakah database name sudah berubah ke grandflowdb
grep -r "grandflowdb" .

# Check SQL migrations
find . -name "*.sql" -exec grep -l "balaka\|artivisi" {} \;
```

### 2. Verifikasi URLs
```bash
# Check semua URL references
grep -r "balaka\.id\|artivisi\.com" . --exclude-dir=.git
```

### 3. Verifikasi Docker
Jika menggunakan Docker:
```bash
# Update image names
docker build -t grandindo/grandflow .

# Update docker-compose
docker-compose up -d
```

### 4. Verifikasi Environment Variables
```bash
# Check jika ada env variables yang perlu diupdate
grep -r "BALAKA\|ARTIVISI" . --exclude-dir=.git
```

### 5. Test Login
- Akses aplikasi: http://localhost:8080
- Default username: `admin`
- Default password: (dari konfigurasi Anda)

## 📊 File-file yang Dihasilkan

Setelah menjalankan script, akan ada:

### RENAME_SUMMARY.txt
Laporan lengkap perubahan yang dibuat, meliputi:
- Changes made
- Next steps
- Important reminders

### Git Changes
```bash
# Lihat semua file yang berubah
git status

# Contoh output:
# modified:   pom.xml
# modified:   README.md
# renamed:    src/main/java/com/artivisi/... → src/main/java/com/grandindo/...
# ...
```

## 🔍 Troubleshooting

### Error: "command not found: sed"
Pastikan Anda di Linux/Mac atau gunakan WSL di Windows:
```bash
# Windows dengan WSL
wsl
cd /mnt/c/path/to/balaka
./rename-project.sh
```

### Error: "Permission denied"
```bash
chmod +x rename-project.sh
./rename-project.sh
```

### Masih ada referensi ke nama lama
```bash
# Check
grep -r "balaka" . --exclude-dir=.git --exclude-dir=target --exclude-dir=node_modules

# Manual replace jika perlu
sed -i 's/balaka/grandflow/g' filename
```

### Build gagal setelah rename
1. Clean build: `./mvnw clean`
2. Update IDE cache (IntelliJ: File > Invalidate Caches)
3. Rebuild: `./mvnw package -DskipTests`

### Database tidak bisa terkoneksi
```bash
# Verify database exists
sudo -u postgres psql -l | grep grandflowdb

# Jika tidak ada, create:
sudo -u postgres psql
CREATE DATABASE grandflowdb OWNER accounting;
```

## 🎯 Verifikasi Checklist

- [ ] Script rename sudah dijalankan
- [ ] RENAME_SUMMARY.txt sudah direviu
- [ ] `git status` menunjukkan perubahan yang diharapkan
- [ ] Tidak ada referensi "balaka" atau "artivisi" (kecuali di commit history)
- [ ] pom.xml sudah updated dengan groupId/artifactId baru
- [ ] Package names sudah direname
- [ ] Build berhasil: `./mvnw clean package`
- [ ] Database grandflowdb sudah dibuat
- [ ] Aplikasi bisa diakses di http://localhost:8080
- [ ] Login berhasil dengan user admin
- [ ] Semua fitur utama berfungsi normal
- [ ] Git commit sudah di-push

## 📞 Bantuan Lebih Lanjut

Jika ada masalah:

1. **Check RENAME_SUMMARY.txt**
   ```bash
   cat RENAME_SUMMARY.txt
   ```

2. **Review git diff**
   ```bash
   git diff | less
   ```

3. **Check script output**
   Script sudah menampilkan ✓ untuk setiap step sukses

4. **Revert jika perlu**
   ```bash
   git reset --hard HEAD
   ```

---

**Selamat! Proses rename project sudah siap. Ikuti langkah-langkah di atas untuk menyelesaikan rename dari Balaka → GrandFlow dan Artivisi → GrandIndo.** 🎉
