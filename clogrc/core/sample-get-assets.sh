# usage> assets(sample)
# short> get assets so yarn run watch displays correctly
#  long> download assets from s3 so yarn run watch displays correctly. Includes core css, js, and images as well as bulky media
#                                    _        
#  ___    __ _   _ __ ___    _ __   | |   ___ 
# / __|  / _` | | '_ ` _ \  | '_ \  | |  / _ \
# \__ \ | (_| | | | | | | | | |_) | | | |  __/
# |___/  \__,_| |_| |_| |_| | .__/  |_|  \___|
#                           |_|               

source $GITPOD_REPO_ROOT/clogrc/core/mm-core-inc.sh
fnInfo "Project(${cH}$(basename $GITPOD_REPO_ROOT)${cT})$cF $(basename $0)"
# ------------------------------------------------------------------------------

source $GITPOD_REPO_ROOT/clogrc/core/get-core.sh
fnInfo "Project(${cH}$(basename $GITPOD_REPO_ROOT)${cT})$cF $(basename $0)"

BOT="hbot-bd-dev"
BRANCH="staging"

CACHE="s3://mmh-cache"
REPO="wmcb-shorts"

SRC="core & shorts assets"
DST="site/"

OPT="--include \"*\" "
ACTION=Download

# do preflight checks
source $GITPOD_REPO_ROOT/clogrc/core/s3sync.sh
fValidate
# ------------------------------------------------------------------------------

#define the folders to sync
SYNCS=(
  "$OPT  $CACHE/$BOT/ch-web/shorts/r       $DST/shorts/r"
  "$OPT  $CACHE/$BOT/ch-web/app            $DST/app"
  "$OPT  $CACHE/$BOT/cbw-shorts/shorts/r   $DST/shorts/r "
  "$OPT  $CACHE/$BOT/cbw-shorts/shorts/r   $DST/shorts/r "
)

# do sync
fSync
