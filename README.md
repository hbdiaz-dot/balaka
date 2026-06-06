# GrandFlow - Advanced Accounting Application

**Sebelumnya:** Balaka by Artivisi  
**Sekarang:** GrandFlow by Grandindo

Aplikasi akuntansi profesional untuk UKM Indonesia dengan fitur lengkap termasuk perpajakan, payroll, inventory, dan laporan keuangan.

## 🚀 Quick Start

### Database Setup
```bash
sudo -u postgres psql
CREATE USER accounting WITH PASSWORD 'your-password';
CREATE DATABASE grandflowdb OWNER accounting;
GRANT ALL PRIVILEGES ON DATABASE grandflowdb TO accounting;
```

### Build & Run
```bash
./mvnw clean package
java -jar target/grandflow-*.jar
```

## 📋 Project Status

✅ Phase 1: Core Configuration Renamed  
⏳ Phase 2: Java Source Code (Pending Manual Update)

## 📚 Documentation

- [Rename Guide](RENAME_GUIDE.md) - Complete rename procedure
- [Completion Report](RENAME_COMPLETION_REPORT.md) - Phase 1 details

## 📄 License

[Apache License 2.0](LICENSE)
