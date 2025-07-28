# docker-tf2mge

A Dockerised Team Fortress 2 MGE server with some plugins. This image is recommended with [containrrr/watchtower](https://github.com/containrrr/watchtower) to automatically update the image with the image repository.

> It is recommended to run with docker compose.

### Simple Run

```bash
docker run -d \
  --name tf2-mge-server \
  --net=host \
  -e HOSTNAME="My MGE Server" \
  -e RCON_PASSWORD="changeme123" \
  -e SV_PASSWORD="dockermge" \
  avanavan/docker-tf2mge:latest
```

## Configuration

### Database Configuration (Optional)

For MGE stats and SourceBans integration:

```bash
# Basic
HOSTNAME=Docker MGE Server
MGE_MAP=mge_training_v8_beta4b
SV_PASSWORD=dockermge
RCON_PASSWORD=changeme123
SV_DOWNLOADURL=https://fastdl.serveme.tf/
TV_NAME=DockerTV

# MGE Database (leave DB_MGE_HOST empty for SQLite)
DB_MGE_HOST="abc-db.com"
DB_MGE_NAME="mgemod"
DB_MGE_USR="username"
DB_MGE_PW="password"

# SourceBans Database (Optional)
DB_SB_HOST="abc-db.com"
DB_SB_NAME="sourcebans"
DB_SB_USR="username"
DB_SB_PW="password"
SB_WEBHOOK=
```

## Ports

- **27015/udp & tcp**: Game server
- **27020/udp**: SourceTV

## Included Plugins

- **SourceMod** 
- **MetaMod**
- **MGEmod** - [sapphonie/MGEMod](https://github.com/sapphonie/MGEMod)
- **tf2-comp-fixes** - [ldesgoui/tf2-comp-fixes](https://github.com/ldesgoui/tf2-comp-fixes)
- **sourcebans-pp** - [sbpp/sourcebans-pp](https://github.com/sbpp/sourcebans-pp)
- **StAC-tf2** - [sapphonie/StAC-tf2](https://github.com/sapphonie/StAC-tf2)

## Auto-Updates

By default, the container itself will not autoupdate. Since srcds will attempt to redownload the missing maps which will drastically increase the container size. 

Therefore, I have included Watchtower to poll for update each hour. The image will be updated when the image has been updated.