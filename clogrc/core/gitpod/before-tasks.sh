#                                    _        
#  ___    __ _   _ __ ___    _ __   | |   ___ 
# / __|  / _` | | '_ ` _ \  | '_ \  | |  / _ \
# \__ \ | (_| | | | | | | | | |_) | | | |  __/
# |___/  \__,_| |_| |_| |_| | .__/  |_|  \___|
#                           |_|               
source $GITPOD_REPO_ROOT/clogrc/core/mm-core-inc.sh
echo -e "${Cgreen}gitpod$cC BEFORE$cT tasks starting"
# ------------------------------------------------------------------------------

fnInfo "$cC yarn$cT global path"
PATH="$PATH:$(yarn global bin)"
echo "PATH=\"$PATH\"" >> ~/.bashrc

fnInfo "$cC  zmp$cT update"
sudo wget --quiet --output-document=/usr/local/bin/zmp  https://mrmxf.com/get/zmp  ; sudo chmod +x /usr/local/bin/zmp

fnInfo "$cC clog$cT update"
sudo wget --quiet --output-document=/usr/local/bin/clog https://mrmxf.com/get/clog ; sudo chmod +x /usr/local/bin/clog

fnInfo "$cC  aws$cT cli install"
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "/tmp/awscliv2.zip"
unzip -q -o /tmp/awscliv2.zip -d /tmp
sudo /tmp/aws/install

# ------------------------------------------------------------------------------
fnDivider