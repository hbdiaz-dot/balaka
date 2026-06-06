# GrandFlow Project Rename Summary

## ✅ Completed Tasks

### Phase 1: Core Configuration Files
- [x] **pom.xml**
  - groupId: `com.artivisi` → `com.grandindo`
  - artifactId: `accounting-finance` → `grandflow`
  - name: `accounting-finance` → `grandflow`
  - description updated to reflect GrandFlow

- [x] **application.properties**
  - spring.application.name: `accounting-finance` → `grandflow`
  - spring.datasource.url: `accountingdb` → `grandflowdb`
  - app.theme.name: `balaka` → `grandflow`
  - app.theme.footer-text: `Balaka` → `GrandFlow`
  - springdoc.packages-to-scan: `com.artivisi.accountingfinance` → `com.grandindo.grandflow`

- [x] **README.md**
  - Project title updated to GrandFlow
  - All references to Balaka/balaka → GrandFlow/grandflow
  - All references to Artivisi → Grandindo
  - Documentation links updated

### Database Changes
- Database name: `accountingdb` → `grandflowdb`
- Package scan path updated for Spring documentation

## 📋 Next Steps (Manual Actions)

### 1. Update Java Package Structure
```bash
# Rename package directories
mv src/main/java/com/artivisi src/main/java/com/grandindo
mv src/test/java/com/artivisi src/test/java/com/grandindo

# Update package declarations in all .java files
find src -name "*.java" -exec sed -i 's/package com\.artivisi/package com.grandindo/g' {} \;
find src -name "*.java" -exec sed -i 's/import com\.artivisi/import com.grandindo/g' {} \;
```

### 2. Create Database
```bash
sudo -u postgres psql
CREATE DATABASE grandflowdb OWNER accounting;
ALTER ROLE accounting SET client_encoding TO 'utf8';
ALTER ROLE accounting SET default_transaction_isolation TO 'read committed';
GRANT ALL PRIVILEGES ON DATABASE grandflowdb TO accounting;
```

### 3. Build Application
```bash
./mvnw clean package -DskipTests
```

### 4. Run Application
```bash
java -jar target/grandflow-*.jar
```

### 5. GitHub Repository Update
1. Go to: https://github.com/hbdiaz-dot/balaka/settings
2. Change repository name from `balaka` to `grandflow`
3. Update repository description
4. Update homepage URL

## 🔍 Verification Checklist

- [ ] pom.xml has correct groupId (com.grandindo) and artifactId (grandflow)
- [ ] application.properties references grandflowdb
- [ ] Theme name set to grandflow
- [ ] Spring doc package scan updated
- [ ] README.md updated with new name
- [ ] Java packages renamed to com.grandindo.grandflow
- [ ] Database created as grandflowdb
- [ ] Application builds successfully
- [ ] Application starts without errors
- [ ] Login page displays correct theme
- [ ] GitHub repository renamed

## 📊 Rename Summary

| Item | Old Name | New Name |
|------|----------|----------|
| Company | Artivisi | Grandindo |
| Application | Balaka | GrandFlow |
| Java Package | com.artivisi.accountingfinance | com.grandindo.grandflow |
| Maven GroupId | com.artivisi | com.grandindo |
| Maven ArtifactId | accounting-finance | grandflow |
| Database | accountingdb | grandflowdb |
| Theme Name | balaka | grandflow |

## 🔧 Configuration References

### Before
```properties
spring.application.name=accounting-finance
spring.datasource.url=...accountingdb...
app.theme.name=balaka
springdoc.packages-to-scan=com.artivisi.accountingfinance.controller.api
```

### After
```properties
spring.application.name=grandflow
spring.datasource.url=...grandflowdb...
app.theme.name=grandflow
springdoc.packages-to-scan=com.grandindo.grandflow.controller.api
```

## 📝 Notes

- All files have been updated in the main branch
- Java source files need manual package renaming
- Database needs to be created before running the application
- GitHub repository settings should be updated for consistency
- Update any external references or documentation pointing to the old name

---

**Status**: ✅ Phase 1 Complete - Ready for Phase 2 (Java packages and directory structure)
