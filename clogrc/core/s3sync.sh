# The interactive s3 sync up/download script
# https://awscli.amazonaws.com/v2/documentation/api/latest/reference/s3/index.html

# $ACTION - verb to be presented to the user [ Sync | Upload | Download]
# $BOT    - Name of the BOT from the environment
# BRANCH  - [ dev | staging | main ]
# OPT     - any valid string for s3 sync
#         - e.g. '--exclude="*" --include="*.txt" '

# $AWS_ACCESS_KEY_ID     - set in the environemnt
# $AWS_SECRET_ACCESS_KEY - set in the environemnt

fValidate() {
# Check the BOT Name for the credentials
if [[ $ACTION == "" ]] ; then ACTION="Sync"; fi

# Check the BOT Name for the credentials
if [[ $BOT == "" ]] ; then echo -e "${cE}ERROR$cI env variable  MM_BOT=(${cC}$BOT$cI) must be a valid bot name$cX"  ; exit 1; fi

# Check credentials

if [[ $AWS_ACCESS_KEY_ID == "" ]]     ; then echo -e "${cE}ERROR$cI env variable ${cC}AWS_ACCESS_KEY_ID$cI must be set$cX"     ; exit 1 ; fi
if [[ $AWS_SECRET_ACCESS_KEY == "" ]] ; then echo -e "${cE}ERROR$cI env variable ${cC}AWS_SECRET_ACCESS_KEY$cI must be set$cX" ; exit 1 ; fi 

# Update the BRANCH if needed - ignore errors
case "$BRANCH" in

  "dev" | "staging" | "main")
    # pass through
    ;;

  *)
    fnAbort "${cT}variable \$BRANCH must be one of [ dev | staging | main ].$cX"
    ;;
esac

# Check the user is happy
while true; do
  echo -e -n "${cT}$ACTION(${cI}$SRC${cT}) branch(${cI}$BRANCH${cT}) with bot(${cI}$BOT${cT}).$cX ? yes | no | test [${cC}ynt$cX] "
  read response
  case $response in
    [Yy]* ) echo -e "${cT}${ACTION}ing...$cX" ; break;;
    [Nn]* ) fnAbort "Exit - user abort" ;;
    [Tt]* ) OPT="$OPT --dryrun" ; echo -e "${cW}Dry Run Test...$cX"; break;;
    * ) fnWarning "${cE}Please enter$cC y$cE or$cC n$cE or$cC t$cE.${cX}";;
  esac
done
}

fSync() {
    # iterate through SYNCS - print & execute
    for d in "${!SYNCS[@]}"; do
    SYNC=${SYNCS[$d]}
    echo -e "${cC}aws s3 sync $SYNC$cX"
    aws s3 sync $SYNC
    done
}

fSyncCore(){
  CoreOpt="--include \"*\""
  fnInfo "Get Core scripts     clogrc/core"
  aws s3 sync $CoreOpt s3://mmh-cache/bot-bdh/main/wmcb-core/clogrc/core  clogrc/core

  fnInfo "Get Core Markdown    content/core"
  aws s3 sync $CoreOpt s3://mmh-cache/bot-bdh/main/wmcb-core/content/core content/core

  fnInfo "Get Core Page Code   code/core"
  aws s3 sync $CoreOpt s3://mmh-cache/bot-bdh/main/wmcb-core/code/core    code/core 

  fnInfo "Get Core resources   r/c"
  aws s3 sync $CoreOpt s3://mmh-cache/bot-bdh/main/wmcb-core/r/c          r/c
}