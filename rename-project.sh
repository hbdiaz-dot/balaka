#!/bin/bash

###############################################################################
# Project Rename Script
# Renames Balaka application to GrandFlow
# Replaces: balaka → grandflow, artivisi → grandindo
# Usage: ./rename-project.sh
###############################################################################

set -e

# Color output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Counters
REPLACEMENTS=0
FILES_PROCESSED=0

# Logging functions
log_info() {
    echo -e "${BLUE}ℹ ${1}${NC}"
}

log_success() {
    echo -e "${GREEN}✓ ${1}${NC}"
}

log_warning() {
    echo -e "${YELLOW}⚠ ${1}${NC}"
}

log_error() {
    echo -e "${RED}✗ ${1}${NC}"
}

###############################################################################
# Main Replacement Function
###############################################################################
replace_in_file() {
    local file="$1"
    local old_pattern="$2"
    local new_pattern="$3"
    
    if grep -q "$old_pattern" "$file"; then
        sed -i "s/$old_pattern/$new_pattern/g" "$file"
        ((REPLACEMENTS++))
        return 0
    fi
    return 1
}

###############################################################################
# Rename Files and Directories
###############################################################################
rename_files_and_dirs() {
    log_info "Renaming files and directories..."
    
    # Rename directories
    find . -type d -name "*balaka*" ! -path "./.git/*" ! -path "./.github/*" -print0 | while read -d '' dir; do
        newdir="${dir/balaka/grandflow}"
        if [ "$dir" != "$newdir" ]; then
            mv "$dir" "$newdir"
            log_success "Renamed directory: $dir → $newdir"
            ((FILES_PROCESSED++))
        fi
    done
    
    find . -type d -name "*artivisi*" ! -path "./.git/*" ! -path "./.github/*" -print0 | while read -d '' dir; do
        newdir="${dir/artivisi/grandindo}"
        if [ "$dir" != "$newdir" ]; then
            mv "$dir" "$newdir"
            log_success "Renamed directory: $dir → $newdir"
            ((FILES_PROCESSED++))
        fi
    done
    
    # Rename files
    find . -type f -name "*balaka*" ! -path "./.git/*" ! -path "./.github/*" -print0 | while read -d '' file; do
        newfile="${file/balaka/grandflow}"
        if [ "$file" != "$newfile" ]; then
            mv "$file" "$newfile"
            log_success "Renamed file: $file → $newfile"
            ((FILES_PROCESSED++))
        fi
    done
    
    find . -type f -name "*artivisi*" ! -path "./.git/*" ! -path "./.github/*" -print0 | while read -d '' file; do
        newfile="${file/artivisi/grandindo}"
        if [ "$file" != "$newfile" ]; then
            mv "$file" "$newfile"
            log_success "Renamed file: $file → $newfile"
            ((FILES_PROCESSED++))
        fi
    done
}

###############################################################################
# Replace Content in Files
###############################################################################
replace_content() {
    log_info "Replacing content in files..."
    
    # Define file patterns to search (exclude binary and git files)
    local file_patterns=(
        "*.xml"
        "*.yml"
        "*.yaml"
        "*.json"
        "*.java"
        "*.kt"
        "*.gradle"
        "*.properties"
        "*.sql"
        "*.html"
        "*.css"
        "*.js"
        "*.ts"
        "*.md"
        "*.sh"
        "*.sql"
        "Dockerfile*"
        "Makefile"
        ".github/workflows/*"
    )
    
    local exclude_patterns=(
        ".git"
        "node_modules"
        "target"
        ".gradle"
        "build"
        "dist"
    )
    
    # Build find command with exclusions
    local find_cmd="find . -type f"
    for pattern in "${exclude_patterns[@]}"; do
        find_cmd="$find_cmd ! -path '*/$pattern/*' ! -path '*/.git/*'"
    done
    
    # Replace "balaka" with "grandflow" (case-insensitive and variations)
    log_info "Replacing 'balaka' references..."
    
    # Exact matches
    eval "$find_cmd" -print0 | xargs -0 sed -i 's/balaka/grandflow/g' 2>/dev/null || true
    eval "$find_cmd" -print0 | xargs -0 sed -i 's/Balaka/Grandflow/g' 2>/dev/null || true
    eval "$find_cmd" -print0 | xargs -0 sed -i 's/BALAKA/GRANDFLOW/g' 2>/dev/null || true
    
    log_info "Replacing 'artivisi' references..."
    
    # Exact matches
    eval "$find_cmd" -print0 | xargs -0 sed -i 's/artivisi/grandindo/g' 2>/dev/null || true
    eval "$find_cmd" -print0 | xargs -0 sed -i 's/Artivisi/Grandindo/g' 2>/dev/null || true
    eval "$find_cmd" -print0 | xargs -0 sed -i 's/ARTIVISI/GRANDINDO/g' 2>/dev/null || true
    
    log_success "Content replacement completed"
}

###############################################################################
# Special Cases and Package Renames
###############################################################################
rename_packages() {
    log_info "Renaming Java packages..."
    
    # Rename com.artivisi to com.grandindo
    if [ -d "src/main/java/com/artivisi" ]; then
        mv src/main/java/com/artivisi src/main/java/com/grandindo
        log_success "Renamed package: com.artivisi → com.grandindo"
    fi
    
    if [ -d "src/test/java/com/artivisi" ]; then
        mv src/test/java/com/artivisi src/test/java/com/grandindo
        log_success "Renamed package: com.artivisi → com.grandindo"
    fi
}

###############################################################################
# Update Application Properties
###############################################################################
update_app_properties() {
    log_info "Updating application properties..."
    
    local props_files=(
        "src/main/resources/application.yml"
        "src/main/resources/application.yaml"
        "src/main/resources/application.properties"
    )
    
    for props_file in "${props_files[@]}"; do
        if [ -f "$props_file" ]; then
            sed -i 's/balaka/grandflow/g' "$props_file"
            sed -i 's/artivisi/grandindo/g' "$props_file"
            log_success "Updated: $props_file"
        fi
    done
}

###############################################################################
# Update Database Names
###############################################################################
update_db_names() {
    log_info "Updating database-related references..."
    
    # Find and replace in SQL migration files
    find . -name "*.sql" ! -path "./.git/*" -exec sed -i 's/balaka/grandflow/g; s/artivisi/grandindo/g' {} \;
    
    # Update database connection strings
    if [ -f "src/main/resources/application.yml" ]; then
        sed -i 's/accountingdb/grandflowdb/g' src/main/resources/application.yml
        log_success "Updated database name: accountingdb → grandflowdb"
    fi
}

###############################################################################
# Update GitHub References
###############################################################################
update_github_refs() {
    log_info "Updating GitHub references..."
    
    # Update README and documentation files
    find . -name "*.md" ! -path "./.git/*" -exec sed -i \
        's|artivisi/balaka|grandindo/grandflow|g; \
         s|artivisi\.com|grandindo\.com|g' {} \;
    
    log_success "Updated GitHub references in markdown files"
}

###############################################################################
# Verify Changes
###############################################################################
verify_changes() {
    log_info "Verifying changes..."
    echo ""
    
    local remaining_balaka=$(grep -r "balaka" --exclude-dir=.git --exclude-dir=node_modules --exclude-dir=target --exclude-dir=.gradle --exclude-dir=build . 2>/dev/null | wc -l)
    local remaining_artivisi=$(grep -r "artivisi" --exclude-dir=.git --exclude-dir=node_modules --exclude-dir=target --exclude-dir=.gradle --exclude-dir=build . 2>/dev/null | wc -l)
    
    if [ "$remaining_balaka" -gt 0 ]; then
        log_warning "Found $remaining_balaka remaining references to 'balaka'"
        log_info "Remaining 'balaka' references:"
        grep -r "balaka" --exclude-dir=.git --exclude-dir=node_modules --exclude-dir=target --exclude-dir=.gradle --exclude-dir=build . 2>/dev/null | head -5
        echo ""
    else
        log_success "No remaining 'balaka' references found"
    fi
    
    if [ "$remaining_artivisi" -gt 0 ]; then
        log_warning "Found $remaining_artivisi remaining references to 'artivisi'"
        log_info "Remaining 'artivisi' references:"
        grep -r "artivisi" --exclude-dir=.git --exclude-dir=node_modules --exclude-dir=target --exclude-dir=.gradle --exclude-dir=build . 2>/dev/null | head -5
        echo ""
    else
        log_success "No remaining 'artivisi' references found"
    fi
}

###############################################################################
# Create Summary Report
###############################################################################
create_summary() {
    cat > RENAME_SUMMARY.txt << 'EOF'
╔════════════════════════════════════════════════════════════════════════════╗
║                   PROJECT RENAME COMPLETION REPORT                         ║
║                   Balaka → GrandFlow                                        ║
║                   Artivisi → Grandindo                                      ║
╚════════════════════════════════════════════════════════════════════════════╝

CHANGES MADE:
=============

1. Package Names:
   - com.artivisi → com.grandindo

2. Application Name:
   - balaka → grandflow

3. Company Name:
   - artivisi → grandindo

4. Database Name:
   - accountingdb → grandflowdb

5. Configuration Files Updated:
   - pom.xml
   - application.yml/yaml/properties
   - All Java source files
   - All configuration files
   - Documentation files

NEXT STEPS:
===========

1. Review changes:
   git status
   git diff

2. Update GitHub repository:
   - Fork URL might need updating
   - Update repository name in GitHub web interface

3. Rebuild application:
   ./mvnw clean install

4. Test application:
   java -jar target/grandflow-*.jar

5. Update documentation:
   - Check README.md
   - Update URLs and references
   - Update installation guides

6. Database migration:
   - Backup existing database
   - Create new database with new name
   - Update connection strings

7. Commit and push changes:
   git add .
   git commit -m "refactor: rename project balaka→grandflow, artivisi→grandindo"
   git push

IMPORTANT REMINDERS:
====================

- Review all changes carefully before committing
- Test the application thoroughly
- Update docker-compose files if using Docker
- Update CI/CD workflows
- Update any hardcoded URLs or API endpoints
- Update brand/logo references if applicable
- Test database migrations
- Verify all import statements are correct

EOF
    
    log_success "Summary report created: RENAME_SUMMARY.txt"
}

###############################################################################
# Main Execution
###############################################################################
main() {
    echo ""
    echo "╔════════════════════════════════════════════════════════════════════════════╗"
    echo "║              PROJECT RENAME SCRIPT - BALAKA TO GRANDFLOW                   ║"
    echo "║              ARTIVISI TO GRANDINDO                                         ║"
    echo "╚════════════════════════════════════════════════════════════════════════════╝"
    echo ""
    
    log_warning "This script will rename your project. Please ensure you have backed up your repository first!"
    echo ""
    read -p "Are you sure you want to proceed? (yes/no): " confirm
    
    if [ "$confirm" != "yes" ]; then
        log_error "Rename cancelled by user"
        exit 0
    fi
    
    echo ""
    log_info "Starting project rename process..."
    echo ""
    
    # Execute rename operations
    rename_files_and_dirs
    sleep 1
    
    replace_content
    sleep 1
    
    rename_packages
    sleep 1
    
    update_app_properties
    sleep 1
    
    update_db_names
    sleep 1
    
    update_github_refs
    sleep 1
    
    verify_changes
    sleep 1
    
    create_summary
    
    echo ""
    echo "╔════════════════════════════════════════════════════════════════════════════╗"
    echo "║                       RENAME PROCESS COMPLETED!                            ║"
    echo "║                 Please review RENAME_SUMMARY.txt for details               ║"
    echo "╚════════════════════════════════════════════════════════════════════════════╝"
    echo ""
    log_success "Project rename process completed successfully!"
    echo ""
}

# Run main function
main "$@"
