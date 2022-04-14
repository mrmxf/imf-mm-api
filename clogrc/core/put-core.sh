#> get core code & resources for cuttlebelle

source $GITPOD_REPO_ROOT/clogrc/core/mm-core-inc.sh
fnInfo "Project(${cH}$(basename $GITPOD_REPO_ROOT)${cT})$cF clogrc/core/get-core.sh$cX"
# ------------------------------------------------------------------------------

BOT="bot-bdh"
BRANCH="main"

CACHE="s3://mmh-cache"
REPO="wmcb-core"

SRC="code & resources"
DST="$GITPOD_REPO_ROOT"

# put / upload does not to delete
OPT="--include \"*\" --delete"
ACTION="No-Delete-Upload"

# do preflight checks
source $GITPOD_REPO_ROOT/clogrc/core/s3sync.sh
fValidate
# ------------------------------------------------------------------------------

#define the folders to sync
SYNCS=(
  "$OPT    $DST/clogrc/core   $CACHE/$BOT/$BRANCH/$REPO/clogrc/core "
  "$OPT    $DST/code/core     $CACHE/$BOT/$BRANCH/$REPO/code/core   "  
  "$OPT    $DST/content/core  $CACHE/$BOT/$BRANCH/$REPO/content/core"  
  "$OPT    $DST/r/c           $CACHE/$BOT/$BRANCH/$REPO/r/c         " 
)

# do sync
fSync
