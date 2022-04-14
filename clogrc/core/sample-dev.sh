# usage> dev(sample)
# short> execute dev.sh to build & upload {{REPO}} to dev cache
# long>  execute dev.sh to build & upload {{REPO}} to dev cache. No other option needed. Edit script to configure upload.
#                                    _        
#  ___    __ _   _ __ ___    _ __   | |   ___ 
# / __|  / _` | | '_ ` _ \  | '_ \  | |  / _ \
# \__ \ | (_| | | | | | | | | |_) | | | |  __/
# |___/  \__,_| |_| |_| |_| | .__/  |_|  \___|
#                           |_|               
source $GITPOD_REPO_ROOT/clogrc/core/mm-core-inc.sh
fnInfo "Project(${cH}$(basename $GITPOD_REPO_ROOT)${cT})$cF $(basename $0)"
# ------------------------------------------------------------------------------

BOT=$MM_BOT
BRANCH="dev"

CACHE="s3://mmh-cache"
REPO=$(basename $GITPOD_REPO_ROOT)

SRC=""

OPT="--include \"*\" "
ACTION=Upload

# do preflight checks
source $GITPOD_REPO_ROOT/clogrc/core/s3sync.sh
fValidate
# ------------------------------------------------------------------------------

#define the folders to sync
SYNCS=(
  "$OPT site/$SRC   $CACHE/$BOT/$BRANCH/$REPO/$SRC"
)

# do sync
fSync

