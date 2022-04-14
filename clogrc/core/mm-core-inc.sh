# ------------------------------------------------------------------------------
# Gitpod / Website Core Functions
#
# Usage
#   source mm-core-inc.sh
# ------------------------------------------------------------------------------
MM_CORE_VERSION=0.2

# set up some colors to make the output pretty
  Cblack="\e[30m" ;    Cred="\e[31m" ;  Cgreen="\e[32m" ;Cyellow="\e[33m";    Cblue="\e[34m"
Cmagenta="\e[35m" ;   Ccyan="\e[36m" ;  Cwhite="\e[37m" ;  Cgray="\e[90m";  CSblack="\e[90m"
   CSred="\e[91m" ; CSgreen="\e[92m" ;CSyellow="\e[93m" ; CSblue="\e[94m";CSmagenta="\e[95m"
  CScyan="\e[96m" ; CSwhite="\e[97m" ;  CSgray="\e[37m"
  Bblack="\e[40m" ;    Bred="\e[41m" ;  Bgreen="\e[42m" ;Byellow="\e[43m";   Bblue="\e[44m"
Bmagenta="\e[45m" ;   Bcyan="\e[46m" ;  Bwhite="\e[47m" ;  Bgray="\e[100m"; BSblack="\e[100m"
   BSred="\e[101m"; BSgreen="\e[102m";BSyellow="\e[103m"; BSblue="\e[104m";BSmagenta="\e[105m"
  BScyan="\e[106m"; BSwhite="\e[107m";  BSgray="\e[47m"
    Coff="\e[0m"  ; cX=$Coff ; cO=$Coff

Ccmd=$cX$Cblue;              cC=$Ccmd
Curl=$cX$Ccyan;              cU=$Curl
Ctxt=$cX$Cblack;             cT=$Ctxt
Cinfo=$cX$Cyellow;           cI=$Cinfo
Cerror=$cX$Cred;             cE=$Cerror
Cwarning=$cX$CSmagenta;      cW=$Cwarning
Cfile=$cX$Cgray;             cF=$Cfile
Cheading=$cX$Cblue$BSyellow; cH=$Cheading

# ------------------------------------------------------------------------------
#define a function to echo a message - color initialised as text

fnEcho() {
  # 1st parameter might by a keyword to control color ERROR / WARNING / INFO then print the rest

# printf '%s\n' "${FUNCNAME[@]}" ; printf '%s\n' "${BASH_LINENO[@]}"
  local csl ; let csl=${#FUNCNAME[@]}-2
  local ln=${BASH_LINENO[$csl]}
  if [ $ln -lt 10  ] ; then ln="0$ln" ;fi
  if [ $ln -lt 100 ] ; then ln="0$ln" ;fi

  case "$1" in
     ABORT)
         shift
         MSG="${Cerror}  ABORT "
       ;;
     "ERROR" | ABORT)
         shift
         MSG="${Cerror}  ERROR "
       ;;
     "WARNING")
       shift
       MSG="${Cwarning}WARNING "
       ;;
     "INFO")
          shift
          MSG="${Cinfo}   INFO "
       ;;
     "SUCCESS")
          shift
          MSG="${Clightgreen}SUCCESS "
       ;;
     "TEXT")
          shift
          MSG="        "
       ;;
     *)
          MSG="        "
       ;;
  esac
echo -e "$cC$ln$cI>>$MSG$cT$@$cX"

}

# ------------------------------------------------------------------------------
#define an abort function
fnAbort() {
  #param $1 = message
  #find the calling function in the call stack (csl)
  #this is the (call stack length-1) minus another 1 because its zero based
  local csl ; let csl=${#FUNCNAME[@]}-2
  fnEcho  "ABORT" "${Cerror}Abort called from ${cX}${FUNCNAME[csl]}${Cerror} at line${cX} ${BASH_LINENO[csl]}"
  exit -1
}

# ------------------------------------------------------------------------------
# Helper functions for woarnings etc
fnOk() {
  fnEcho  SUCCESS "$@"
}

fnInfo() {
  fnEcho  INFO "$@"
}

fnText() {
  fnEcho  TEXT "$@"
}

fnWarning() {
  fnEcho  WARNING "$@"
}

fnError() {
  fnEcho  ERROR "$@"
}

fnDivider(){
  fnInfo "$cI==== ==== ==== ==== ==== ==== ==== ==== ==== ==== ==== ==== ==== ==== ==== ===="
}

# ------------------------------------------------------------------------------
# add a parameter for verbose mose e.g. fn_test_colors "verbose"
fnColors() {
 #echo "All variables starting with C:${!C*}"
 echo -e "key>>       $cC Ccmd $cU Curl $cT Ctxt $cI Cinfo $cE Cerror $cW Cwarning $CF Cfile $cT script v$cI$MM_LX_FUNCTIONS_VERSION"
 if [ $1 ] ; then
   fnError errors are$Cred red
   fnWarning warnings are$Clightmagenta pink
   fnOk success in$Clightgreen lightgreen
   fnText plain text is$Clightyellow lightyellow
   fnInfo info meesages are$Cdarkgray darkgray
   fnEcho "files are in$Cwhite white $Coff""
   fnEcho "command lines are in$Cgreen green $Coff""
   fnEcho "urls are in$Ccyan cyan $Coff"
 fi
}

# ------------------------------------------------------------------------------
#define a routine to safely make a user folder
fnMakeFolder() {
  #param $1 = folder to make
  if [ -z $1 ] ; then
    fnAbort "makeFolder${Ctxt} requires a valid folder name${cX}"
	fi
  real_user=$(whoami)
	if [ ! -d $1 ] ; then
		mkdir $1
    fnOk "   $1 ${Cgreen} changing permissions to ${cX} drw-------"
    chmod 700 $1
  	if [ ! -d $1 ] ; then
      fnAbort "Cannot mkdir $1 (as $real_user)"
    else
      fnOk "   $1 ${Cgreen} created succesfully  (as $Cinfo$real_user)${cX}"
		fi
  else
    fnOk "   ${Cfile}$1 ${Cgreen} already exists ${cX}"
	fi
  return 1
}

# ------------------------------------------------------------------------------
fnWget() {
  if [ -z $1 ] ; then
    fnAbort "fn_wget ERROR: missing local_name${Ctxt} usage: fn_wget tmp/file https://url/thing.sh"
	fi
  if [ -z $2 ] ; then
    fnAbort "fn_wget ERROR: missing source url${Ctxt} usage: fn_wget tmp/file https://url/thing.sh"
	fi
  #use curl to fetch the file. Fail if 404 error
  CURL_TEXT=$(curl --fail --silent --show-error $2 > $1)
  CURL_STATUS=$?

  if [[ $cURL_STATUS -eq 0 ]] ; then
    fnOk "get $Cfile $1$Ctxt from ${Ccyan}$2"
  else
    fnError "get $Cfile $1$Ctxt from ${Ccyan}$2"
  fi
  #  echo ... curl returned $gotit
  #gotit=$(curl  $2 > $1)

  if [[ "$2" == *.sh ]] ; then
    chmod +x $1
    fnOk "make$Cfile $1$Ctxt executable"
  fi
}

# ------------------------------------------------------------------------------
function fnGetStack () {
   STACK=""
   local i message="${1:-""}"
   local stack_size=${#FUNCNAME[@]}
   # to avoid noise we start with 1 to skip the get_stack function
   for (( i=1; i<$stack_size; i++ )); do
      local func="${FUNCNAME[$i]}"
      [ x$func = x ] && func=MAIN
      local linen="${BASH_LINENO[$(( i - 1 ))]}"
      local src="${BASH_SOURCE[$i]}"
      [ x"$src" = x ] && src=non_file_source

      STACK+=$'\n'"   at: "$func" "$src" "$linen
   done
   STACK="${message}${STACK}"
}

# ------------------------------------------------------------------------------
# Display a usage message
#   $1 - a title
#   $2 - the usage string
#   $3 - a description
function fnUsage(){
    echo -e "$cT\nMrMXF $cI$1$cT module$cX"
    echo -e "$cI========================================$cX"
    echo -e "$cI $ $cC$2$cX"
    echo -e " "
    if [ "$3" ] ; then
       echo -e "$cT$3$cX"
    fi
}
