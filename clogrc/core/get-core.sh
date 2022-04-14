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

OPT="--include \"*\" --delete"
ACTION="Delete-Orpahns-Download"

# do preflight checks
source $GITPOD_REPO_ROOT/clogrc/core/s3sync.sh
fValidate
# ------------------------------------------------------------------------------

#define the folders to sync
SYNCS=(
  "$OPT  $CACHE/$BOT/$BRANCH/$REPO/clogrc/core     $DST/clogrc/core"
  "$OPT  $CACHE/$BOT/$BRANCH/$REPO/code/core       $DST/code/core"
  "$OPT  $CACHE/$BOT/$BRANCH/$REPO/content/core    $DST/content/core"
  "$OPT  $CACHE/$BOT/$BRANCH/$REPO/r/c             $DST/r/c"
)

# do sync
fSync
