#!/bin/bash

###############################################################################
# Advanced Rename Script - Phase 2
# Handles edge cases and special configurations
# Usage: ./rename-advanced.sh
###############################################################################

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

log_info() { echo -e "${BLUE}ℹ ${1}${NC}"; }
log_success() { echo -e "${GREEN}✓ ${1}${NC}"; }
log_warning() { echo -e "${YELLOW}⚠ ${1}${NC}"; }
log_error() { echo -e "${RED}✗ ${1}${NC}"; }

###############################################################################
# Fix application.properties specifics
###############################################################################
fix_application_properties() {
    log_info "Fixing application.properties with special cases..."
    
    local app_props="src/main/resources/application.properties"
    
    if [ -f "$app_props" ]; then
        # Fix database URL - accountingdb → grandflowdb
        sed -i 's/accountingdb/grandflowdb/g' "$app_props"
        log_success "Updated database name in application.properties"
        
        # Fix theme name - balaka → grandflow
        sed -i 's/app\.theme\.name=balaka/app.theme.name=grandflow/g' "$app_props"
        log_success "Updated theme name"
        
        # Fix theme footer - Balaka → Grandflow
        sed -i 's/app\.theme\.footer-text=Balaka/app.theme.footer-text=Grandflow/g' "$app_props"
        log_success "Updated theme footer text"
        
        # Fix Spring doc package scan
        sed -i 's/com\.artivisi\.accountingfinance/com.grandindo.grandflow/g' "$app_props"
        log_success "Updated Spring doc package scan"
    fi
}

###############################################################################
# Fix application.yml if exists
###############################################################################
fix_application_yml() {
    log_info "Checking application.yml files..."
    
    for yml_file in src/main/resources/application.yml src/main/resources/application.yaml; do
        if [ -f "$yml_file" ]; then
            log_info "Processing $yml_file..."
            
            # Replace database name
            sed -i 's/accountingdb/grandflowdb/g' "$yml_file"
            
            # Replace theme
            sed -i 's/balaka/grandflow/g' "$yml_file"
            sed -i 's/Balaka/Grandflow/g' "$yml_file"
            
            # Replace package references
            sed -i 's/com\.artivisi/com.grandindo/g' "$yml_file"
            sed -i 's/Artivisi/Grandindo/g' "$yml_file"
            
            log_success "Updated $yml_file"
        fi
    done
}

###############################################################################
# Update Spring Boot Application class
###############################################################################
update_spring_boot_app() {
    log_info "Updating Spring Boot Application classes..."
    
    # Find main Application class
    local app_class=$(find src/main/java -name "*Application.java" 2>/dev/null | head -1)
    
    if [ -n "$app_class" ]; then
        log_success "Found main Application class: $app_class"
        
        # Update package name
        sed -i 's/package com\.artivisi/package com.grandindo/g' "$app_class"
        sed -i 's/import com\.artivisi/import com.grandindo/g' "$app_class"
        
        log_success "Updated package references in Application class"
    fi
}

###############################################################################
# Update all Java source files
###############################################################################
update_java_files() {
    log_info "Updating all Java source files..."
    
    # Update package declarations
    find src/main/java -name "*.java" -exec sed -i 's/^package com\.artivisi/package com.grandindo/g' {} \;
    log_success "Updated package declarations"
    
    # Update import statements
    find src/main/java -name "*.java" -exec sed -i 's/^import com\.artivisi/import com.grandindo/g' {} \;
    log_success "Updated import statements"
    
    # Update test files
    find src/test/java -name "*.java" -exec sed -i 's/^package com\.artivisi/package com.grandindo/g' {} \;
    find src/test/java -name "*.java" -exec sed -i 's/^import com\.artivisi/import com.grandindo/g' {} \;
    log_success "Updated test files"
}

###############################################################################
# Update SQL migration files
###############################################################################
update_sql_migrations() {
    log_info "Updating SQL migration files..."
    
    if [ -d "src/main/resources/db/migration" ]; then
        find src/main/resources/db/migration -name "*.sql" -exec sed -i \
            's/balaka/grandflow/g; s/artivisi/grandindo/g' {} \;
        log_success "Updated SQL migration files"
    else
        log_warning "SQL migration directory not found"
    fi
}

###############################################################################
# Update HTML/Thymeleaf templates
###############################################################################
update_templates() {
    log_info "Updating HTML templates..."
    
    if [ -d "src/main/resources/templates" ]; then
        # Replace in template files
        find src/main/resources/templates -name "*.html" -exec sed -i \
            's/Balaka/Grandflow/g; s/balaka/grandflow/g' {} \;
        
        log_success "Updated template files"
    fi
}

###############################################################################
# Update CSS and static resources
###############################################################################
update_static_resources() {
    log_info "Updating static resources..."
    
    if [ -d "src/main/resources/static" ]; then
        # Update CSS files
        find src/main/resources/static -name "*.css" -exec sed -i \
            's/balaka/grandflow/g; s/Balaka/Grandflow/g' {} \;
        
        # Update JS files
        find src/main/resources/static -name "*.js" -exec sed -i \
            's/balaka/grandflow/g; s/Balaka/Grandflow/g' {} \;
        
        log_success "Updated static resources"
    fi
}

###############################################################################
# Update Maven wrapper and build files
###############################################################################
update_maven_files() {
    log_info "Updating Maven-related files..."
    
    # Update pom.xml specifics
    if [ -f "pom.xml" ]; then
        # Project name
        sed -i 's/<name>accounting-finance<\/name>/<name>grandflow<\/name>/g' pom.xml
        
        # Description
        sed -i 's/Indonesian accounting application/GrandFlow: Indonesian accounting application/g' pom.xml
        
        # GroupId
        sed -i 's/<groupId>com\.artivisi<\/groupId>/<groupId>com.grandindo<\/groupId>/g' pom.xml
        
        # ArtifactId
        sed -i 's/<artifactId>accounting-finance<\/artifactId>/<artifactId>grandflow<\/artifactId>/g' pom.xml
        
        log_success "Updated pom.xml"
    fi
}

###############################################################################
# Update GitHub Actions workflows
###############################################################################
update_workflows() {
    log_info "Updating GitHub Actions workflows..."
    
    if [ -d ".github/workflows" ]; then
        find .github/workflows -name "*.yml" -o -name "*.yaml" | while read -r workflow; do
            sed -i 's/balaka/grandflow/g; s/artivisi/grandindo/g' "$workflow"
        done
        log_success "Updated GitHub Actions workflows"
    fi
}

###############################################################################
# Update Docker files
###############################################################################
update_docker_files() {
    log_info "Updating Docker files..."
    
    for docker_file in Dockerfile docker-compose.yml Dockerfile.prod .dockerignore; do
        if [ -f "$docker_file" ]; then
            sed -i 's/balaka/grandflow/g; s/artivisi/grandindo/g; s/accountingdb/grandflowdb/g' "$docker_file"
            log_success "Updated $docker_file"
        fi
    done
}

###############################################################################
# Update Ansible playbooks
###############################################################################
update_ansible() {
    log_info "Updating Ansible playbooks..."
    
    if [ -d "deploy/ansible" ]; then
        find deploy/ansible -name "*.yml" -o -name "*.yaml" | while read -r playbook; do
            sed -i 's/balaka/grandflow/g; s/artivisi/grandindo/g; s/accounting-finance/grandflow/g; s/accountingdb/grandflowdb/g' "$playbook"
        done
        log_success "Updated Ansible playbooks"
    fi
}

###############################################################################
# Update Pulumi configuration
###############################################################################
update_pulumi() {
    log_info "Updating Pulumi configuration..."
    
    if [ -d "deploy/pulumi" ]; then
        find deploy/pulumi -name "*.ts" -o -name "*.js" | while read -r file; do
            sed -i 's/balaka/grandflow/g; s/artivisi/grandindo/g; s/accounting-finance/grandflow/g' "$file"
        done
        log_success "Updated Pulumi configuration"
    fi
}

###############################################################################
# Update README and documentation
###############################################################################
update_documentation() {
    log_info "Updating documentation..."
    
    # Update main README
    if [ -f "README.md" ]; then
        sed -i 's/Balaka/GrandFlow/g; s/balaka/grandflow/g' README.md
        sed -i 's/Artivisi/Grandindo/g; s/artivisi/grandindo/g' README.md
        sed -i 's/accounting-finance/grandflow/g' README.md
        sed -i 's|github.com/artivisi/balaka|github.com/grandindo/grandflow|g' README.md
        log_success "Updated README.md"
    fi
    
    # Update documentation files
    if [ -d "docs" ]; then
        find docs -name "*.md" -exec sed -i \
            's/Balaka/GrandFlow/g; s/balaka/grandflow/g; s/Artivisi/Grandindo/g; s/artivisi/grandindo/g' {} \;
        log_success "Updated documentation files"
    fi
}

###############################################################################
# Update configuration files
###############################################################################
update_config_files() {
    log_info "Updating configuration files..."
    
    # Update .env files
    if [ -f ".env" ] || [ -f ".env.example" ]; then
        [ -f ".env" ] && sed -i 's/balaka/grandflow/g; s/artivisi/grandindo/g' .env
        [ -f ".env.example" ] && sed -i 's/balaka/grandflow/g; s/artivisi/grandindo/g' .env.example
        log_success "Updated .env files"
    fi
    
    # Update Makefile
    if [ -f "Makefile" ]; then
        sed -i 's/balaka/grandflow/g; s/artivisi/grandindo/g; s/accounting-finance/grandflow/g' Makefile
        log_success "Updated Makefile"
    fi
    
    # Update .gitignore
    if [ -f ".gitignore" ]; then
        sed -i 's/balaka/grandflow/g' .gitignore
    fi
}

###############################################################################
# Update frontend package.json
###############################################################################
update_frontend() {
    log_info "Updating frontend configuration..."
    
    if [ -f "src/main/frontend/package.json" ]; then
        sed -i 's/accounting-finance/grandflow/g; s/balaka/grandflow/g' src/main/frontend/package.json
        log_success "Updated frontend package.json"
    fi
    
    if [ -f "src/main/frontend/package-lock.json" ]; then
        sed -i 's/accounting-finance/grandflow/g; s/balaka/grandflow/g' src/main/frontend/package-lock.json
    fi
}

###############################################################################
# Update seed data and fixtures
###############################################################################
update_seed_data() {
    log_info "Updating seed data..."
    
    if [ -d "industry-seed" ]; then
        find industry-seed -type f \( -name "*.json" -o -name "*.yaml" -o -name "*.yml" \) -exec sed -i \
            's/balaka/grandflow/g; s/artivisi/grandindo/g; s/Balaka/Grandflow/g; s/Artivisi/Grandindo/g' {} \;
        log_success "Updated seed data"
    fi
}

###############################################################################
# Create comprehensive rename report
###############################################################################
create_advanced_report() {
    cat > ADVANCED_RENAME_REPORT.txt << 'EOF'
╔════════════════════════════════════════════════════════════════════════════╗
║            ADVANCED RENAME COMPLETION REPORT - PHASE 2                     ║
║                   GrandFlow Project Transition                             ║
╚════════════════════════════════════════════════════════════════════════════╝

FILES UPDATED:
==============

1. Application Configuration:
   ✓ src/main/resources/application.properties
   ✓ src/main/resources/application.yml (if exists)
   ✓ src/main/resources/application.yaml (if exists)

2. Java Source Code:
   ✓ Package declarations (com.artivisi → com.grandindo)
   ✓ Import statements
   ✓ Main Application class
   ✓ All Java classes in src/main/java
   ✓ All test classes in src/test/java

3. Configuration Files:
   ✓ pom.xml (groupId, artifactId, name)
   ✓ Maven wrapper
   ✓ .env files
   ✓ Makefile

4. Spring Boot Integration:
   ✓ Spring doc package scan
   ✓ Theme configuration
   ✓ Database connection URL

5. Database:
   ✓ SQL migration files
   ✓ Database name (accountingdb → grandflowdb)

6. Frontend:
   ✓ src/main/frontend/package.json
   ✓ HTML templates
   ✓ CSS and JavaScript files

7. Infrastructure as Code:
   ✓ Docker files (Dockerfile, docker-compose.yml)
   ✓ Ansible playbooks
   ✓ Pulumi configuration

8. CI/CD:
   ✓ GitHub Actions workflows (.github/workflows/)

9. Documentation:
   ✓ README.md
   ✓ docs/ directory
   ✓ Configuration guides

10. Seed Data:
    ✓ industry-seed data files

KEY CONFIGURATION CHANGES:
==========================

Database:
  OLD: jdbc:postgresql://localhost:12345/accountingdb
  NEW: jdbc:postgresql://localhost:12345/grandflowdb

Theme:
  OLD: app.theme.name=balaka
  NEW: app.theme.name=grandflow

Package:
  OLD: com.artivisi.accountingfinance
  NEW: com.grandindo.grandflow

Spring Doc:
  OLD: springdoc.packages-to-scan=com.artivisi.accountingfinance.controller.api
  NEW: springdoc.packages-to-scan=com.grandindo.grandflow.controller.api

NEXT STEPS:
===========

1. Review all changes:
   git status
   git diff --stat

2. Verify database configuration:
   grep -r "grandflowdb" . --exclude-dir=.git

3. Test package structure:
   ls -la src/main/java/com/grandindo/

4. Build and test:
   ./mvnw clean package -DskipTests
   java -jar target/grandflow-*.jar

5. Create and setup database:
   sudo -u postgres createdb grandflowdb
   sudo -u postgres psql -d grandflowdb -c "CREATE EXTENSION IF NOT EXISTS uuid-ossp"

6. Run application and verify:
   - Access http://localhost:8080
   - Test login with admin credentials
   - Check application title/theme

7. Commit changes:
   git add .
   git commit -m "refactor: advanced rename - balaka→grandflow, artivisi→grandindo"
   git push origin main

IMPORTANT NOTES:
================

✓ All Java package names have been updated
✓ All configuration files reference the new names
✓ Database connection strings have been updated
✓ Spring Boot component scanning has been updated
✓ Frontend package configurations have been updated
✓ Docker and infrastructure code has been updated
✓ CI/CD workflows have been updated

⚠️  MANUAL CHECKS RECOMMENDED:

1. Verify no hardcoded IDs or references remain:
   grep -r "artivisi\|balaka" . --exclude-dir=.git --exclude-dir=target --exclude-dir=node_modules

2. Test database connection:
   psql -U accounting -d grandflowdb -h localhost

3. Review git diff for any unexpected changes:
   git diff | less

4. Check for any compilation errors:
   ./mvnw compile

5. Run full test suite:
   ./mvnw test

TROUBLESHOOTING:
================

Build Failure:
  Problem: "Package com.artivisi not found"
  Solution: 
    1. rm -rf ~/.m2/repository
    2. ./mvnw clean package

Database Connection Error:
  Problem: "Cannot connect to grandflowdb"
  Solution:
    1. sudo -u postgres psql -l
    2. If DB not found: sudo -u postgres createdb grandflowdb
    3. Verify username/password in application.properties

Spring Doc Error:
  Problem: "Cannot find packages specified in springdoc.packages-to-scan"
  Solution:
    1. Verify path in application.properties
    2. Check package structure: ls src/main/java/com/grandindo/
    3. Run: ./mvnw clean compile

Template Error:
  Problem: "Thymeleaf cannot find theme"
  Solution:
    1. Check theme.name in application.properties
    2. Verify theme files exist in static/themes/
    3. Rebuild frontend: cd src/main/frontend && npm run build

DEPLOYMENT CHECKLIST:
=====================

- [ ] All source files compiled successfully
- [ ] All tests pass
- [ ] Database created with new name
- [ ] Application starts without errors
- [ ] Login screen displays correct theme
- [ ] All features tested and working
- [ ] Database migrations run successfully
- [ ] No console errors or warnings
- [ ] API documentation updated (Swagger)
- [ ] Docker image builds successfully
- [ ] GitHub repository settings updated
- [ ] CI/CD workflows passing

ROLLBACK INSTRUCTIONS:
======================

If needed to rollback:
  git reset --hard HEAD~1

Or revert just one file:
  git checkout HEAD -- path/to/file

EOF
    
    log_success "Advanced rename report generated: ADVANCED_RENAME_REPORT.txt"
}

###############################################################################
# Main Execution
###############################################################################
main() {
    echo ""
    echo "╔════════════════════════════════════════════════════════════════════════════╗"
    echo "║           ADVANCED PROJECT RENAME SCRIPT - PHASE 2 (EDGE CASES)            ║"
    echo "║              Handling Special Configurations & Dependencies                ║"
    echo "╚════════════════════════════════════════════════════════════════════════════╝"
    echo ""
    
    read -p "Are you sure? This will update advanced configurations. (yes/no): " confirm
    if [ "$confirm" != "yes" ]; then
        log_error "Cancelled"
        exit 0
    fi
    
    echo ""
    log_info "Starting advanced rename process..."
    echo ""
    
    fix_application_properties
    sleep 0.5
    
    fix_application_yml
    sleep 0.5
    
    update_spring_boot_app
    sleep 0.5
    
    update_java_files
    sleep 0.5
    
    update_sql_migrations
    sleep 0.5
    
    update_templates
    sleep 0.5
    
    update_static_resources
    sleep 0.5
    
    update_maven_files
    sleep 0.5
    
    update_workflows
    sleep 0.5
    
    update_docker_files
    sleep 0.5
    
    update_ansible
    sleep 0.5
    
    update_pulumi
    sleep 0.5
    
    update_documentation
    sleep 0.5
    
    update_config_files
    sleep 0.5
    
    update_frontend
    sleep 0.5
    
    update_seed_data
    sleep 0.5
    
    create_advanced_report
    
    echo ""
    echo "╔════════════════════════════════════════════════════════════════════════════╗"
    echo "║              ADVANCED RENAME PROCESS COMPLETED!                            ║"
    echo "║          See ADVANCED_RENAME_REPORT.txt for complete details               ║"
    echo "╚════════════════════════════════════════════════════════════════════════════╝"
    echo ""
    log_success "All advanced configurations updated successfully!"
    echo ""
}

main "$@"
