<p align="center">
  <img src="brand/logo-full.svg" alt="GrandFlow" height="64">
</p>

<p align="center">
  <a href="https://github.com/grandindo/grandflow/actions/workflows/ci.yml"><img src="https://github.com/grandindo/grandflow/actions/workflows/ci.yml/badge.svg" alt="CI"></a>
  <a href="https://codecov.io/gh/grandindo/grandflow"><img src="https://codecov.io/gh/grandindo/grandflow/graph/badge.svg" alt="codecov"></a>
</p>

# GrandFlow

Advanced accounting application for Indonesian small businesses. Spring Boot 4.0.3 + Thymeleaf + PostgreSQL.

**Production-ready features:**
- ✅ Core accounting (Chart of Accounts, journal entries, financial reports)
- ✅ Indonesian tax compliance (PPN, PPh 21/23/4(2), e-Faktur, e-Bupot)
- ✅ Payroll with BPJS and automatic PPh 21 calculation
- ✅ Fixed assets with depreciation (straight-line, declining balance)
- ✅ Inventory & simple production (FIFO/weighted average, BOM, production orders)
- ✅ Security hardening (AES-256-GCM encryption, audit logging, RBAC, CSP headers)
- ✅ DevSecOps (CodeQL, SpotBugs, OWASP ZAP DAST, Dependency-Check)

## Quick Start

### Prerequisites
- Java 25 (Azul Zulu JDK)
- PostgreSQL 12+
- Maven 3.8+

### Setup Database
```bash
sudo -u postgres psql
CREATE USER accounting WITH PASSWORD 'your-password';
CREATE DATABASE grandflowdb OWNER accounting;
ALTER ROLE accounting SET client_encoding TO 'utf8';
ALTER ROLE accounting SET default_transaction_isolation TO 'read committed';
GRANT ALL PRIVILEGES ON DATABASE grandflowdb TO accounting;
```

### Build
```bash
./mvnw clean package -DskipTests
```

### Run
```bash
java -jar target/grandflow-*.jar
```

Access at: http://localhost:8080

## Documentation

- [User Manual](https://grandindo.com/grandflow/) - End-user documentation (Indonesian)
- [Features & Roadmap](docs/01-features-and-roadmap.md) - Current features and future plans
- [Architecture](docs/02-architecture.md) - Tech stack, data model, infrastructure
- [Operations Guide](docs/03-operations-guide.md) - Deployment, release, backup/restore

## License

[Apache License 2.0](LICENSE)
