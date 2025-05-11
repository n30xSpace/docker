# Readarr

Readarr es un administrador de colecciones de libros electrónicos y audiolibros que permite la descarga automática de archivos.

## Información de acceso

- **URL**: http://localhost:8787
- **Puerto**: 8787

## Configuración

Para configurar Readarr:

1. Accede a la interfaz web a través de la URL mencionada arriba
2. Configura los siguientes ajustes:
   - **Descargador**: Conecta con qBittorrent o SABnzbd
   - **Indexador**: Configura Prowlarr como fuente de indexación
   - **Carpeta de medios**: Apunta a `/media` o `/medias` según tus preferencias
   - **Perfil de calidad**: Configura según tus necesidades de calidad para libros

## Integración con otros servicios

Readarr está configurado para trabajar con:
- Prowlarr (indexación)
- qBittorrent (descargas torrent)
- SABnzbd (descargas usenet)

## Volúmenes

- `/config` - Almacena datos de configuración
- `/media` y `/medias` - Carpetas para almacenar archivos de libros
- `/data` - Datos compartidos con otros contenedores

## Red

Readarr está configurado para usar la red `mediaservices` para comunicarse con los demás contenedores del sistema. 