# Lidarr

Lidarr es un administrador de colecciones de música y descargas automáticas para la distribución de archivos de música.

## Información de acceso

- **URL**: http://localhost:8686
- **Puerto**: 8686

## Configuración

Para configurar Lidarr:

1. Accede a la interfaz web a través de la URL mencionada arriba
2. Configura los siguientes ajustes:
   - **Descargador**: Conecta con qBittorrent o SABnzbd
   - **Indexador**: Configura Prowlarr como fuente de indexación
   - **Carpeta de medios**: Apunta a `/media` o `/medias` según tus preferencias
   - **Perfil de calidad**: Configura según tus necesidades de calidad de audio

## Integración con otros servicios

Lidarr está configurado para trabajar con:
- Prowlarr (indexación)
- qBittorrent (descargas torrent)
- SABnzbd (descargas usenet)

## Volúmenes

- `/config` - Almacena datos de configuración
- `/media` y `/medias` - Carpetas para almacenar archivos de música
- `/data` - Datos compartidos con otros contenedores

## Red

Lidarr está configurado para usar la red `mediaservices` para comunicarse con los demás contenedores del sistema. 