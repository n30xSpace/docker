# LazyLibrarian

LazyLibrarian es una aplicación para gestionar la descarga automática de libros electrónicos y audiolibros, y facilitar su organización en bibliotecas.

## Información de acceso

- **URL**: http://localhost:5299
- **Puerto**: 5299

## Configuración

Para configurar LazyLibrarian:

1. Accede a la interfaz web a través de http://localhost:5299
2. Configura los siguientes ajustes:
   - **Descargador**: Conecta con qBittorrent o SABnzbd
   - **Indexador**: Configura Prowlarr como fuente de indexación
   - **Carpeta de libros**: Apunta a `/media/books` o `/medias/books`
   - **Integración con Calibre**: Configura la conexión al servidor de Calibre en `calibre:8080`

## Integración con otros servicios

LazyLibrarian está configurado para trabajar con:
- Prowlarr (indexación)
- qBittorrent (descargas torrent)
- SABnzbd (descargas usenet)
- Calibre (gestión de biblioteca)
- Readarr (gestión de libros)

## Funcionalidades principales

- Búsqueda y descarga automática de libros
- Organización de biblioteca digital
- Sincronización con Goodreads
- Importación automática a Calibre
- Notificaciones de nuevos lanzamientos

## Volúmenes

- `/config` - Almacena datos de configuración
- `/media` y `/medias` - Carpetas para almacenar archivos de libros
- `/data` - Datos compartidos con otros contenedores
- `/downloads` - Directorio donde qBittorrent coloca las descargas

## Red

LazyLibrarian está configurado para usar la red `mediaservices` para comunicarse con los demás contenedores del sistema. 