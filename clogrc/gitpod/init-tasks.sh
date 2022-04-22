#   _            __                                                _
#  (_)  _ __    / _|  ___   _ _   ___   __ _   ___   __ _   _ __  (_)
#  | | | '  \  |  _| |___| | '_| / -_) / _` | |___| / _` | | '_ \ | |
#  |_| |_|_|_| |_|         |_|   \___| \__, |       \__,_| | .__/ |_|
#                                      |___/               |_|
source $GITPOD_REPO_ROOT/clogrc/core/mm-core-inc.sh
echo -e "${Cgreen}gitpod$cC INIT$cT tasks starting"
# ------------------------------------------------------------------------------

# place commands here

fnInfo "$cC yarn$cT install dependencies"
yarn

# ------------------------------------------------------------------------------
fnDivider