#!/bin/bash

# Script para iniciar los servicios en el orden correcto
# Autor: Claude
# Fecha: 2024

# Colores para la salida
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Función para verificar si un servicio está listo
wait_for_service() {
    local service=$1
    local port=$2
    local max_attempts=30
    local attempt=1

    echo -e "${CYAN}⏳ Esperando a que $service esté listo...${NC}"
    
    while [ $attempt -le $max_attempts ]; do
        if curl -s "http://localhost:$port" > /dev/null; then
            echo -e "${GREEN}✅ $service está listo${NC}"
            return 0
        fi
        echo -e "${YELLOW}Intento $attempt de $max_attempts...${NC}"
        sleep 10
        attempt=$((attempt + 1))
    done
    
    echo -e "${RED}❌ $service no está respondiendo después de $max_attempts intentos${NC}"
    return 1
}

# Función para verificar si PostgreSQL está listo
wait_for_postgres() {
    local max_attempts=30
    local attempt=1

    echo -e "${CYAN}⏳ Esperando a que PostgreSQL esté listo...${NC}"
    
    while [ $attempt -le $max_attempts ]; do
        if docker exec postgres pg_isready -h localhost -p 5432 > /dev/null 2>&1; then
            echo -e "${GREEN}✅ PostgreSQL está listo${NC}"
            return 0
        fi
        echo -e "${YELLOW}Intento $attempt de $max_attempts...${NC}"
        sleep 10
        attempt=$((attempt + 1))
    done
    
    echo -e "${RED}❌ PostgreSQL no está respondiendo después de $max_attempts intentos${NC}"
    return 1
}

# Función para iniciar un servicio
start_service() {
    local service=$1
    local port=$2
    
    echo -e "\n${CYAN}🚀 Iniciando $service...${NC}"
    cd "$service" || exit 1
    
    if [ -f "docker-compose.yml" ]; then
        docker compose up -d
        if [ $? -eq 0 ]; then
            echo -e "${GREEN}✅ $service iniciado correctamente${NC}"
            if [ -n "$port" ]; then
                wait_for_service "$service" "$port"
            fi
        else
            echo -e "${RED}❌ Error al iniciar $service${NC}"
            exit 1
        fi
    else
        echo -e "${RED}❌ No se encontró docker-compose.yml en $service${NC}"
        exit 1
    fi
    
    cd ..
}

# Verificar si se está ejecutando como root
if [ "$EUID" -eq 0 ]; then
    echo -e "${RED}❌ No ejecutes este script como root${NC}"
    exit 1
fi

# Verificar si Docker está instalado y en ejecución
if ! command -v docker &> /dev/null; then
    echo -e "${RED}❌ Docker no está instalado${NC}"
    exit 1
fi

if ! systemctl is-active --quiet docker; then
    echo -e "${RED}❌ Docker no está en ejecución${NC}"
    echo -e "${YELLOW}Iniciando Docker...${NC}"
    sudo systemctl start docker
fi

# Crear red de Docker si no existe
if ! docker network ls | grep -q "mediaservices"; then
    echo -e "${CYAN}🌐 Creando red Docker 'mediaservices'...${NC}"
    docker network create mediaservices
fi

# Iniciar PostgreSQL primero
echo -e "\n${CYAN}🐘 Iniciando PostgreSQL...${NC}"
cd postgresql || exit 1
docker compose up -d
cd ..

# Esperar a que PostgreSQL esté listo
wait_for_postgres

# Definir el orden de inicio de los servicios
declare -A services=(
    ["nginx-proxy-manager"]="81"
    ["prowlarr"]="9696"
    ["sabnzbd"]="8080"
    ["qbittorrent"]="8090"
    ["transmission"]="9091"
    ["radarr"]="7878"
    ["sonarr"]="8989"
    ["lidarr"]="8686"
    ["readarr"]="8787"
    ["bazarr"]="6767"
    ["jellyfin"]="8096"
    ["jellyseerr"]="5055"
    ["plex"]="32400"
    ["overseerr"]="5055"
    ["portainer"]="9000"
    ["filebrowser"]="8091"
    ["calibre"]="8083"
    ["lazylibrarian"]="5299"
    ["homarr"]="7575"
    ["vaultwarden"]="8081"
    ["n8n"]="5678"
)

# Iniciar servicios en orden
for service in "${!services[@]}"; do
    if [ -d "$service" ]; then
        start_service "$service" "${services[$service]}"
    else
        echo -e "${YELLOW}⚠️  El directorio $service no existe, omitiendo...${NC}"
    fi
done

echo -e "\n${GREEN}✨ Todos los servicios han sido iniciados${NC}"
echo -e "\n${CYAN}📋 Resumen de servicios:${NC}"
echo -e "🎬 Radarr: http://localhost:7878"
echo -e "📺 Sonarr: http://localhost:8989"
echo -e "🎵 Lidarr: http://localhost:8686"
echo -e "📝 Bazarr: http://localhost:6767"
echo -e "📚 Readarr: http://localhost:8787"
echo -e "🕵️‍♂️ Prowlarr: http://localhost:9696"
echo -e "🍿 Jellyfin: http://localhost:8096"
echo -e "🍿 Jellyseerr: http://localhost:5055"
echo -e "🎥 Plex: http://localhost:32400"
echo -e "👁️ Overseerr: http://localhost:5055"
echo -e "🛠️ Portainer: http://localhost:9000"
echo -e "🗂️ Filebrowser: http://localhost:8091"
echo -e "📖 Calibre: http://localhost:8083"
echo -e "📚 Lazylibrarian: http://localhost:5299"
echo -e "🏠 Homarr: http://localhost:7575"
echo -e "🔐 Vaultwarden: http://localhost:8081"
echo -e "🔄 n8n: http://localhost:5678" 