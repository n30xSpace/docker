# Calibre

Calibre es una aplicación para gestionar bibliotecas de libros electrónicos, convertir formatos y sincronizar con dispositivos de lectura.

## Información de acceso

- **URL Interfaz Web**: http://localhost:8083
- **URL Servidor de Contenido**: http://localhost:8084
- **Puertos**: 
  - 8083: Interfaz web de Calibre
  - 8084: Servidor de contenido Calibre

## Configuración

Para configurar Calibre:

1. Accede a la interfaz web a través de http://localhost:8083
2. Configura la biblioteca de libros para que apunte a `/media/books` o `/medias/books`
3. Para una mejor integración con Readarr, configura el servidor de contenido (puerto 8084)

## Integración con otros servicios

Calibre está configurado para trabajar con:
- Readarr (gestión automática de libros)
- qBittorrent (descargas de torrents)

## Funcionalidades principales

- Gestión de biblioteca de libros electrónicos
- Conversión entre formatos (EPUB, MOBI, PDF, etc.)
- Edición de metadatos
- Servidor de contenido para acceder a tus libros desde cualquier dispositivo

## Volúmenes

- `/config` - Almacena datos de configuración
- `/media` y `/medias` - Carpetas para almacenar archivos de libros
- `/data` - Datos compartidos con otros contenedores

## Red

Calibre está configurado para usar la red `mediaservices` para comunicarse con los demás contenedores del sistema. 