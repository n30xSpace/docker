# Sistema de Contenedores Docker - Instrucciones

## Estructura Actualizada

Se ha organizado el proyecto con una carpeta `Scripts` que contiene todos los scripts necesarios para gestionar los contenedores:

```
./
├── contenedores.bat         # Ejecuta el menú principal en Windows (cmd)
├── contenedores.sh          # Ejecuta el menú principal en Linux (bash)
├── contenedores.ps1         # Ejecuta el menú principal en PowerShell
│
├── Scripts/
│   ├── entry.bat            # Menú principal (cmd)
│   ├── entry.sh             # Menú principal (bash)
│   ├── entry.ps1            # Menú principal (PowerShell)
│   ├── launcher.bat         # Menú interactivo detallado (cmd)
│   ├── launcher.sh          # Menú interactivo detallado (bash)
│   ├── launcher.ps1         # Menú interactivo detallado (PowerShell)
│   ├── start-all.bat        # Iniciar todos los servicios (cmd)
│   ├── start-all.sh         # Iniciar todos los servicios (bash)
│   ├── start-all.ps1        # Iniciar todos los servicios (PowerShell)
│   ├── stop-all.bat         # Detener todos los servicios (cmd)
│   ├── stop-all.sh          # Detener todos los servicios (bash)
│   ├── stop-all.ps1         # Detener todos los servicios (PowerShell)
│   ├── clean-docker.bat     # Eliminar todo Docker (cmd)
│   ├── clean-docker.sh      # Eliminar todo Docker (bash)
│   ├── clean-docker.ps1     # Eliminar todo Docker (PowerShell)
│   ├── setup.sh             # Configuración inicial (Linux)
│   └── fix_env_files.ps1    # Corregir archivos .env (PowerShell)
│
├── n8n/                     # Automatización de flujos de trabajo
├── nginx-proxy-manager/     # Gestión de proxies inversos
├── pihole/                  # Bloqueador de anuncios DNS
├── postgresql/              # Base de datos
└── ... (otros directorios de servicios)
```

## Instrucciones de Uso

### Menú Principal

**En Windows (CMD):**
```
contenedores.bat
```

**En Windows (PowerShell):**
```powershell
.\contenedores.ps1
```

**En Linux:**
```bash
chmod +x contenedores.sh    # Solo la primera vez
./contenedores.sh
```

Desde el menú principal puedes:
1. Iniciar todos los servicios
2. Detener todos los servicios
3. Acceder al menú interactivo completo
4. Limpiar Docker completamente

### Para Iniciar Todos los Servicios Directamente

**En Windows (CMD):**
```
cd Scripts
start-all.bat
```

**En Windows (PowerShell):**
```powershell
cd Scripts
.\start-all.ps1
```

**En Linux:**
```bash
chmod +x Scripts/*.sh      # Solo la primera vez
cd Scripts
./start-all.sh
```

### Para Detener Todos los Servicios Directamente

**En Windows (CMD):**
```
cd Scripts
stop-all.bat
```

**En Windows (PowerShell):**
```powershell
cd Scripts
.\stop-all.ps1
```

**En Linux:**
```bash
cd Scripts
./stop-all.sh
```

### Para Limpiar Completamente Docker

Si necesitas eliminar todos los contenedores, imágenes y volúmenes:

**En Windows (CMD):**
```
cd Scripts
clean-docker.bat
```

**En Windows (PowerShell):**
```powershell
cd Scripts
.\clean-docker.ps1
```

**En Linux:**
```bash
cd Scripts
./clean-docker.sh
```

¡ADVERTENCIA! Esto eliminará TODOS los datos almacenados en los volúmenes Docker.

## Solución de Problemas

### Problemas con archivos .env

Si encuentras errores relacionados con caracteres extraños en archivos .env:

```powershell
cd Scripts
.\fix_env_files.ps1
```

### Política de Ejecución de PowerShell

Si tienes problemas para ejecutar scripts PowerShell, es posible que necesites cambiar la política de ejecución:

```powershell
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process
```

### Nginx Proxy Manager con PostgreSQL

Todos los servicios que requieren base de datos están configurados para usar PostgreSQL. Para Nginx Proxy Manager:

1. Asegúrate de iniciar PostgreSQL primero (se hace automáticamente con los scripts de inicio)
2. La base de datos "npm" se crea automáticamente cuando PostgreSQL inicia por primera vez

## Acceso a los Servicios

| Servicio          | URL de acceso                 | Credenciales predeterminadas  |
|-------------------|-------------------------------|-------------------------------|
| Nginx Proxy Manager | http://localhost:9081       | admin@example.com / changeme  |
| Portainer         | http://localhost:9000         | Crear en primer inicio        |
| Jellyfin          | http://localhost:8096         | Crear en primer inicio        |
| Plex              | http://localhost:32400/web    | Requiere cuenta de Plex       |
| Homarr            | http://localhost:7575         | No requiere                   |
| File Browser      | http://localhost:8090         | admin / admin                 |
| Vaultwarden       | http://localhost:8000         | Crear en primer inicio        | 
| PiHole            | http://localhost:8082         | pihole123                     |

## Configuración de PiHole como servidor DHCP

PiHole puede funcionar como servidor DHCP para tu red local, permitiéndote:
1. Asignar direcciones IP a los dispositivos de tu red
2. Aplicar bloqueo de anuncios automáticamente a todos los dispositivos
3. Resolver nombres locales

### Configuración Automática

La forma más sencilla es usar el script de configuración automático:

```powershell
cd Scripts
.\configurar-dhcp-pihole-auto.ps1
```

Este script configura:
- Rango de IPs: 192.168.18.100 - 192.168.18.200
- Router/Gateway: 192.168.18.1
- Dominio local: galax.local
- Tiempo de concesión: 24 horas

### Acceder a dominios desde la red local

Para que los dominios configurados en NGINX Proxy Manager sean accesibles desde la red local:

1. Asegúrate de que PiHole esté correctamente configurado como servidor DNS en tu red
2. Para cada dominio (como homarr.galax.com), ejecuta el script correspondiente:

```powershell
cd Scripts
.\configurar-dominio-npm.ps1 -domainName "homarr.galax.com" -containerName "homarr" -containerPort 7575
```

Esto configurará:
1. El dominio en NGINX Proxy Manager
2. Añadirá la entrada necesaria en PiHole para resolver el dominio localmente

### Notas importantes para DHCP

Para que PiHole funcione correctamente como servidor DHCP:

1. Desactiva el servidor DHCP en tu router
2. Asegúrate de que PiHole tenga una IP estática (recomendado 192.168.18.2)
3. Si los dispositivos no reciben direcciones IP, puedes necesitar editar manualmente el archivo `pihole/docker-compose.yml` y cambiar a `network_mode: "host"`
4. Reinicia los dispositivos de tu red para que obtengan nuevas direcciones IP del servidor PiHole 