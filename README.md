# 🚀 Proyecto Docker Multi-Servicios

Bienvenido al repositorio de infraestructura para tu servidor multimedia y de automatización personal. Aquí encontrarás la configuración lista para usar de los servicios más populares, cada uno en su propia carpeta y con su propio `docker-compose.yml` y archivos de configuración.

---

## 📦 Servicios Incluidos

| Icono | Servicio         | Descripción breve                                 | Puerto por defecto |
|:-----:|:-----------------|:--------------------------------------------------|:------------------:|
| 🎬    | **Radarr**       | Descarga y gestiona películas automáticamente     | 7878              |
| 📺    | **Sonarr**       | Descarga y gestiona series automáticamente        | 8989              |
| 🎵    | **Lidarr**       | Descarga y gestiona música automáticamente        | 8686              |
| 📝    | **Bazarr**       | Descarga y gestiona subtítulos                    | 6767              |
| 📚    | **Readarr**      | Descarga y gestiona libros electrónicos           | 8787              |
| 🕵️‍♂️ | **Prowlarr**     | Gestor de indexadores para Sonarr/Radarr/etc      | 9696              |
| 🍿    | **Jellyfin**     | Servidor multimedia libre                         | 8096              |
| 🍿    | **Jellyseerr**   | Solicitudes de contenido para Jellyfin            | 5055              |
| 🎥    | **Plex**         | Servidor multimedia popular                       | 32400             |
| 👁️    | **Overseerr**    | Solicitudes de contenido para Plex/Jellyfin       | 5055              |
| 🛠️    | **Portainer**    | Gestión visual de contenedores Docker             | 9000              |
| 🗂️    | **Filebrowser**  | Navegador de archivos web                         | 8091              |
| 🧲    | **Transmission** | Cliente BitTorrent ligero                         | 9091              |
| 🧲    | **qBittorrent**  | Cliente BitTorrent avanzado                       | 8090              |
| 📖    | **Calibre**      | Gestor y servidor de libros electrónicos          | 8083              |
| 📚    | **Lazylibrarian**| Descarga y gestiona audiolibros y ebooks         | 5299              |
| 🌐    | **Nginx Proxy**  | Proxy inverso y gestor de certificados SSL        | 81, 443, 80       |
| 📦    | **Sabnzbd**      | Cliente NZB para Usenet                           | 8080              |
| 🐘    | **PostgreSQL**   | Base de datos relacional                          | 5432              |
| 🏠    | **Homarr**       | Dashboard personalizable                          | 7575              |

> **Nota:** El servicio `vaultwarden` está excluido del repositorio por motivos técnicos.

---

## 🗂️ Estructura del Repositorio

```
├── radarr/
│   └── docker-compose.yml
│   └── config/
├── sonarr/
│   └── docker-compose.yml
│   └── config/
├── Scripts/
│   └── setup.sh
├── ...
```
Cada carpeta contiene:
- Un archivo `docker-compose.yml` listo para usar.
- Una carpeta `config/` para la configuración persistente del servicio.

### 📜 Scripts de Automatización

La carpeta `Scripts` contiene utilidades para automatizar la configuración y mantenimiento del entorno:

#### setup.sh
Este script automatiza la configuración inicial del entorno Docker con las siguientes funcionalidades:

- **Creación de Estructura de Directorios:**
  - Directorios principales: `config`, `data`, `downloads`, `medias`, `temp`
  - Directorios de medios: `books`, `movies`, `tv`, `music`, `downloads`, `comics`, `audiobooks`
  - Directorios de configuración para cada servicio

- **Configuración del Entorno:**
  - Genera archivo `.env` con variables de entorno básicas
  - Configura zona horaria, UID y GID del usuario
  - Establece la conexión con Docker

- **Verificación de Docker:**
  - Comprueba si Docker está instalado
  - Verifica si el servicio está en ejecución
  - Instala Docker si es necesario
  - Agrega el usuario al grupo docker

- **Configuración de Red:**
  - Crea una red Docker dedicada llamada `mediaservices`
  - Asegura la comunicación entre contenedores

- **Gestión de Permisos:**
  - Configura permisos adecuados para todos los directorios
  - Asegura que el usuario tenga acceso correcto a los archivos

Para usar el script:
```bash
cd Scripts
chmod +x setup.sh
./setup.sh
```

---

## ⚙️ Configuración y Uso de los Servicios

A continuación, se describen los servicios principales, sus variables de entorno y rutas de volúmenes más comunes. Consulta el `docker-compose.yml` de cada carpeta para detalles específicos.

### 🎬 Radarr
- **URL:** http://localhost:7878
- **Variables de entorno:**
  - `PUID`, `PGID`, `TZ`, `RADARR_BRANCH`, `RADARR_PORT`
- **Volúmenes recomendados:**
  - `./config:/config`
  - `../media:/media`
  - `../media/movies:/movies`
  - `../media/descargas/radarr:/downloads/radarr`

### 📺 Sonarr
- **URL:** http://localhost:8989
- **Variables de entorno:**
  - `PUID`, `PGID`, `TZ`, `SONARR_BRANCH`, `SONARR_PORT`
- **Volúmenes recomendados:**
  - `./config:/config`
  - `../media:/media`
  - `../media/series:/tv`
  - `../media/descargas/sonarr:/downloads/sonarr`

### 🎵 Lidarr
- **URL:** http://localhost:8686
- **Variables de entorno:**
  - `PUID`, `PGID`, `TZ`, `LIDARR_BRANCH`, `LIDARR_PORT`
- **Volúmenes recomendados:**
  - `./config:/config`
  - `../media:/media`
  - `../media/music:/music`
  - `../media/descargas/lidarr:/downloads/lidarr`

### 📝 Bazarr
- **URL:** http://localhost:6767
- **Variables de entorno:**
  - `PUID`, `PGID`, `TZ`, `BAZARR_PORT`
- **Volúmenes recomendados:**
  - `./config:/config`
  - `../media:/media`

### 🕵️‍♂️ Prowlarr
- **URL:** http://localhost:9696
- **Variables de entorno:**
  - `PUID`, `PGID`, `TZ`, `PROWLARR_PORT`
- **Volúmenes recomendados:**
  - `./config:/config`

### 🍿 Jellyfin
- **URL:** http://localhost:8096
- **Variables de entorno:**
  - `PUID`, `PGID`, `TZ`
- **Volúmenes recomendados:**
  - `./config:/config`
  - `../media:/media`

### 🧲 Transmission
- **URL:** http://localhost:9091
- **Variables de entorno:**
  - `PUID`, `PGID`, `TZ`, `TRANSMISSION_WEB_HOME`
- **Volúmenes recomendados:**
  - `./config:/config`
  - `../media/descargas:/downloads`

### 🧲 qBittorrent
- **URL:** http://localhost:8090
- **Variables de entorno:**
  - `PUID`, `PGID`, `TZ`, `WEBUI_PORT`
- **Volúmenes recomendados:**
  - `./config:/config`
  - `../media/descargas:/downloads`

### 🛠️ Portainer
- **URL:** http://localhost:9000
- **Volúmenes recomendados:**
  - `/var/run/docker.sock:/var/run/docker.sock`
  - `./data:/data`

### 🗂️ Filebrowser
- **URL:** http://localhost:8091
- **Volúmenes recomendados:**
  - `../media:/srv`

### 🌐 Nginx Proxy Manager
- **URL:** http://localhost:81
- **Volúmenes recomendados:**
  - `./data:/data`
  - `./letsencrypt:/etc/letsencrypt`

### 🐘 PostgreSQL
- **Puerto:** 5432
- **Variables de entorno:**
  - `POSTGRES_USER`, `POSTGRES_PASSWORD`, `POSTGRES_DB`
- **Volúmenes recomendados:**
  - `./data:/var/lib/postgresql/data`

---

## ▶️ Cómo usar este repositorio

1. **Clona el repositorio:**
   ```bash
   git clone https://github.com/n30xSpace/docker.git
   cd docker
   ```
2. **Entra en la carpeta del servicio que quieras levantar:**
   ```bash
   cd radarr
   docker compose up -d
   ```
3. **Repite el proceso para cada servicio que desees.
4.** Personaliza los archivos `docker-compose.yml` y las variables de entorno según tus necesidades.

---

## 📝 Notas y Buenas Prácticas

- Los archivos pesados, multimedia y datos temporales están excluidos del repositorio.
- El servicio `vaultwarden` no está incluido por ser un submódulo o contener su propio repositorio.
- Revisa el archivo `.gitignore` para ver las exclusiones.
- Haz backup regular de tus carpetas `config/`.
- Consulta la documentación oficial de cada contenedor para más detalles y personalización.

---

## 🔗 Recursos útiles

- [Documentación oficial de Docker](https://docs.docker.com/)
- [Awesome-Selfhosted](https://github.com/awesome-selfhosted/awesome-selfhosted)
- [Guía de Docker Compose](https://docs.docker.com/compose/)

---

¿Dudas o sugerencias? ¡Abre un issue o contacta al mantenedor! 