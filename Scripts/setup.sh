#!/bin/bash

# Script de configuración para el entorno de contenedores en Linux
# Autor: Claude
# Fecha: 2024

# Colores para la salida
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Función para crear directorios
create_directory() {
    if [ ! -d "$1" ]; then
        mkdir -p "$1"
        echo -e "${GREEN}✅ Directorio creado: $1${NC}"
    else
        echo -e "${YELLOW}ℹ️  El directorio ya existe: $1${NC}"
    fi
}

# Función para crear archivo .env
create_env_file() {
    if [ ! -f "$1" ]; then
        echo "$2" > "$1"
        echo -e "${GREEN}✅ Archivo .env creado: $1${NC}"
    else
        echo -e "${YELLOW}ℹ️  El archivo .env ya existe: $1${NC}"
    fi
}

# Verificar si se está ejecutando como root
if [ "$EUID" -eq 0 ]; then
    echo -e "${RED}❌ No ejecutes este script como root${NC}"
    exit 1
fi

# Obtener UID y GID del usuario actual
CURRENT_UID=$(id -u)
CURRENT_GID=$(id -g)

echo -e "\n${CYAN}📁 Creando estructura de directorios...${NC}"

# Directorios principales
create_directory "config"
create_directory "data"
create_directory "downloads"
create_directory "medias"
create_directory "temp"

# Directorios de medios
create_directory "medias/books"
create_directory "medias/movies"
create_directory "medias/tv"
create_directory "medias/music"
create_directory "medias/downloads"
create_directory "medias/comics"
create_directory "medias/audiobooks"

# Directorios de configuración de servicios
create_directory "config/homarr"
create_directory "config/calibre-web"
create_directory "config/qbittorrent"
create_directory "config/radarr"
create_directory "config/sonarr"
create_directory "config/prowlarr"
create_directory "config/sabnzbd"
create_directory "config/lidarr"
create_directory "config/readarr"
create_directory "config/calibre"
create_directory "config/lazylibrarian"

echo -e "\n${CYAN}📝 Creando archivos de configuración...${NC}"

# Archivo .env principal
ENV_CONTENT="# Configuración general
TZ=America/Santiago
PUID=$CURRENT_UID
PGID=$CURRENT_GID

# Configuración de servicios
DOCKER_HOST=unix:///var/run/docker.sock"

create_env_file ".env" "$ENV_CONTENT"

echo -e "\n${CYAN}🐳 Verificando Docker...${NC}"

# Verificar si Docker está instalado
if command -v docker &> /dev/null; then
    echo -e "${GREEN}✅ Docker está instalado${NC}"
    
    # Verificar si Docker está en ejecución
    if systemctl is-active --quiet docker; then
        echo -e "${GREEN}✅ Docker está en ejecución${NC}"
    else
        echo -e "${RED}❌ Docker no está en ejecución${NC}"
        echo -e "${YELLOW}Iniciando Docker...${NC}"
        sudo systemctl start docker
    fi
else
    echo -e "${RED}❌ Docker no está instalado${NC}"
    echo -e "${YELLOW}Instalando Docker...${NC}"
    sudo apt-get update
    sudo apt-get install -y docker.io docker-compose
    sudo usermod -aG docker $USER
    echo -e "${YELLOW}Por favor, cierra sesión y vuelve a iniciar sesión para que los cambios surtan efecto${NC}"
    exit 1
fi

echo -e "\n${CYAN}🌐 Configurando red de Docker...${NC}"

# Crear red de Docker si no existe
if ! docker network ls | grep -q "mediaservices"; then
    docker network create mediaservices
    echo -e "${GREEN}✅ Red 'mediaservices' creada${NC}"
else
    echo -e "${YELLOW}ℹ️  La red 'mediaservices' ya existe${NC}"
fi

echo -e "\n${CYAN}🔒 Configurando permisos...${NC}"

# Configurar permisos
directories=(
    "config"
    "data"
    "downloads"
    "medias"
    "temp"
)

for dir in "${directories[@]}"; do
    if [ -d "$dir" ]; then
        chmod -R 755 "$dir"
        chown -R $CURRENT_UID:$CURRENT_GID "$dir"
        echo -e "${GREEN}✅ Permisos configurados para: $dir${NC}"
    fi
done

echo -e "\n${GREEN}✨ Configuración completada${NC}"
echo -e "\n${CYAN}Para iniciar los contenedores, ejecuta: docker-compose up -d${NC}" 