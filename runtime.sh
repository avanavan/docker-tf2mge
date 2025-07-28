#!/bin/bash

# Runtime ENV for custom.cfg
touch $HOME/hlserver/tf2/tf/cfg/custom.cfg

CFG="$HOME/hlserver/tf2/tf/cfg/custom.cfg"

echo "// ENV for server.cfg" > ${CFG}
echo "hostname ${HOSTNAME:-Docker MGE Server}" >> ${CFG}
echo "sv_password ${SV_PASSWORD:-DOCKERMGE}" >> ${CFG}
echo "rcon_password ${RCON_PASSWORD:-}" >> ${CFG}
echo "sv_downloadurl ${SV_DOWNLOADURL:-https://fastdl.serveme.tf/}" >> ${CFG}
echo "sbpp_discord_banhook ${SB_WEBHOOK:-}" >> ${CFG}
echo "tv_name ${TV_NAME:-SourceTV}" >> ${CFG}

# Mapcycle for the appointed map
touch $HOME/hlserver/tf2/tf/cfg/mapcycle_mge.cfg
echo "${MGE_MAP:-mge_training_v8_beta4b}" > $HOME/hlserver/tf2/tf/cfg/mapcycle_mge.txt

# Edit databases.cfg
DB_CFG="$HOME/hlserver/tf2/tf/addons/sourcemod/configs/databases.cfg"

if [ -n "$DB_MGE_HOST" ]; then
    MGE_CONFIG="	\"mgemod\"
	{
		\"driver\"			\"default\"
		\"host\"				\"$DB_MGE_HOST\"
		\"database\"			\"${DB_MGE_NAME:-mgemod}\"
		\"user\"				\"${DB_MGE_USR}\"
		\"pass\"				\"${DB_MGE_PW:-}\"
		\"port\"				\"${DB_MGE_PORT:-3306}\"
	}"
else
    MGE_CONFIG="	\"mgemod\"
	{
		\"driver\"			\"sqlite\"
		\"database\"			\"${DB_MGE_NAME:-mgemod}\"
	}"
fi

cat > ${DB_CFG} << EOF
"Databases"
{
	"driver_default"		"mysql"
	
	"default"
	{
		"driver"			"default"
		"host"				"localhost"
		"database"			"sourcemod"
		"user"				"root"
		"pass"				""
		//"timeout"			"0"
		//"port"			"0"
	}
	
	"storage-local"
	{
		"driver"			"sqlite"
		"database"			"sourcemod-local"
	}

	"clientprefs"
	{
		"driver"			"sqlite"
		"host"				"localhost"
		"database"			"clientprefs-sqlite"
		"user"				"root"
		"pass"				""
		//"timeout"			"0"
		//"port"			"0"
	}
	
	"sourcebans"
	{
		"driver"			"default"
		"host"				"${DB_SB_HOST:-localhost}"
		"database"			"${DB_SB_NAME:-sourcebans}"
		"user"				"${DB_SB_USR:-root}"
		"pass"				"${DB_SB_PW:-}"
		"port"				"${DB_SB_PORT:-3306}"
	}
	
$MGE_CONFIG
}
EOF