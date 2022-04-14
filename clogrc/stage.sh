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

SRC=""

OPT="--include \"*\" --delete"
ACTION=Upload

# do preflight checks
source $GITPOD_REPO_ROOT/clogrc/core/s3sync.sh
fValidate
# ------------------------------------------------------------------------------

#define the folders to sync
SYNCS=(
  "$OPT __test__ $CACHE/$BOT/$BRANCH/$REPO/__test__"
  "$OPT api      $CACHE/$BOT/$BRANCH/$REPO/api"
  "$OPT config   $CACHE/$BOT/$BRANCH/$REPO/sample-config"
  "$OPT db       $CACHE/$BOT/$BRANCH/$REPO/sample-db"
  "$OPT docs     $CACHE/$BOT/$BRANCH/$REPO/docs"
  "$OPT src      $CACHE/$BOT/$BRANCH/$REPO/src"
)

# do sync
fSync
aws s3 cp package.json $CACHE/$BOT/$BRANCH/$REPO/package.json
aws s3 cp README.md    $CACHE/$BOT/$BRANCH/$REPO/README.md
