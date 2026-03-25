#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

echo -e "${CYAN}=== Elementor MCP — Déploiement WordPress ===${NC}"
echo ""

# 1. Start containers
echo -e "${GREEN}[1/4] Démarrage des conteneurs Docker...${NC}"
docker compose up -d

# 2. Wait for WordPress to be ready
echo -e "${GREEN}[2/4] Attente que WordPress soit prêt...${NC}"
MAX_WAIT=120
WAITED=0
until docker compose exec -T wordpress curl -sf http://localhost/wp-login.php > /dev/null 2>&1; do
  if [ $WAITED -ge $MAX_WAIT ]; then
    echo "Timeout: WordPress n'est pas prêt après ${MAX_WAIT}s"
    exit 1
  fi
  echo "  En attente... (${WAITED}s)"
  sleep 5
  WAITED=$((WAITED + 5))
done

echo ""
echo -e "${GREEN}[3/4] WordPress est prêt !${NC}"
echo ""
echo -e "${YELLOW}=== ÉTAPES MANUELLES REQUISES ===${NC}"
echo ""
echo -e "${CYAN}A) Finaliser l'installation WordPress :${NC}"
echo "   → Ouvrir http://localhost:8080"
echo "   → Choisir langue, nom du site, identifiants admin"
echo ""
echo -e "${CYAN}B) Installer le plugin Elementor :${NC}"
echo "   → Admin → Extensions → Ajouter"
echo "   → Rechercher 'Elementor' → Installer → Activer"
echo ""
echo -e "${CYAN}C) Créer un Application Password :${NC}"
echo "   → Admin → Utilisateurs → Votre profil"
echo "   → Section 'Mots de passe d'application'"
echo "   → Nommer-le 'MCP' → Cliquer 'Ajouter'"
echo "   → COPIER le mot de passe généré (affiché une seule fois !)"
echo ""
echo -e "${CYAN}D) Configurer le MCP Elementor :${NC}"
echo "   → Éditer le fichier mcp-config.json avec vos identifiants"
echo "   → Copier la config dans ~/.claude/claude_desktop_config.json"
echo "   → Ou utiliser : npx -y @smithery/cli install @aguaitech/Elementor-MCP --client claude"
echo ""
echo -e "${GREEN}[4/4] Services disponibles :${NC}"
echo "   WordPress  : http://localhost:8080"
echo "   phpMyAdmin : http://localhost:8081"
echo ""
echo -e "${GREEN}Terminé !${NC}"
