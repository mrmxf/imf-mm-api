# usage> stage
# short> execute stage.sh to build & upload {{REPO}} to staging
# long>  execute stage.sh to build & upload {{REPO}} to staging. No other option needed. Edit script to configure upload.

source $GITPOD_REPO_ROOT/clogrc/core/mm-core-inc.sh
fnInfo "Project(${cH}$(basename $GITPOD_REPO_ROOT)${cT})$cF $(basename $0)"
# ------------------------------------------------------------------------------

BOT=$MM_BOT
BRANCH="staging"

CACHE="s3://mmh-cache"
REPO=$(basename $GITPOD_REPO_ROOT)

SRC="someFolder"

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

