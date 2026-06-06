# GrandFlow Project Rename - Phase 1 Complete ✅

## Status
- **Date:** 2026-06-06
- **Phase:** 1 of 3
- **Status:** ✅ COMPLETE

## Changes Made

### pom.xml
- `groupId`: com.artivisi → **com.grandindo**
- `artifactId`: accounting-finance → **grandflow**
- `name`: accounting-finance → **grandflow**
- `description`: Updated to reflect GrandFlow

### application.properties
- `spring.application.name`: accounting-finance → **grandflow**
- `spring.datasource.url`: accountingdb → **grandflowdb**
- `app.theme.name`: balaka → **grandflow**
- `app.theme.footer-text`: Balaka → **GrandFlow**
- `springdoc.packages-to-scan`: com.artivisi.accountingfinance → **com.grandindo.grandflow**

### README.md
- Updated project title to **GrandFlow**
- Updated setup instructions
- Updated documentation references

## Next Steps (Manual)

1. **Rename Java Package Directories**
   ```bash
   mv src/main/java/com/artivisi src/main/java/com/grandindo
   mv src/test/java/com/artivisi src/test/java/com/grandindo
   ```

2. **Update Java Files**
   ```bash
   find src -name "*.java" -exec sed -i 's/package com\.artivisi/package com.grandindo/g' {} \;
   find src -name "*.java" -exec sed -i 's/import com\.artivisi/import com.grandindo/g' {} \;
   ```

3. **Create Database**
   ```bash
   sudo -u postgres createdb grandflowdb
   ```

4. **Build & Test**
   ```bash
   ./mvnw clean package -DskipTests
   java -jar target/grandflow-*.jar
   ```

5. **Update GitHub**
   - Go to: https://github.com/hbdiaz-dot/balaka/settings
   - Rename repository from `balaka` to `grandflow`
   - Update description and homepage

## Rename Summary

| Item | Old | New |
|------|-----|-----|
| Company | Artivisi | Grandindo |
| App | Balaka | GrandFlow |
| Package | com.artivisi.accountingfinance | com.grandindo.grandflow |
| Database | accountingdb | grandflowdb |
| Theme | balaka | grandflow |

---

**Ready for Phase 2: Java Source Code Update** 🚀
