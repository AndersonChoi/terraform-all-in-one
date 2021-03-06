#!/usr/bin/env bash

TAG="[$(basename -- "$0")]"
usage="Usage: COMPANY={VALUE} PROJECT={VALUE} EMAIL={VALUE} $0"

COMPANY=${COMPANY:=}
PROJECT=${PROJECT:=}
EMAIL=${EMAIL:=}

company=$(echo ${COMPANY} | tr '[:upper:]' '[:lower:]')
project=$(echo ${PROJECT} |  tr '[:upper:]' '[:lower:]')

function validate {
    if [ "z${PROJECT}" == "z" ] || [ "z${PROJECT}" == "z" ] || [ "z${EMAIL}" == "z" ]; then
        echo ${usage}
        exit 1
    fi

    echo -e "${TAG} PROJECT=${PROJECT} PROJECT=${PROJECT}"
}

echo -e ""
echo -e "${TAG} Generating SSH Key Pair"
ssh-keygen -t rsa -b 4096 -N '' -C "${EMAIL}" -f "key.${project}.${company}.io_rsa"
mv key.${project}.${company}.io_rsa ~/.ssh/
mv key.${project}.${company}.io_rsa.pub ~/.ssh/

echo -e ""
echo -e "${TAG} Listing SSH Key Pair under '~/.ssh/'"
ls ~/.ssh | grep key.${project}.${company}.io_rsa

echo -e ""
echo -e "${TAG} Replace 'company' and 'project' variable.customize.tf"
sed -i.bak "s/  default = \"[a-zA-Z0-9_]*\" # company/  default = \"${company}\" # company/" root-infra/variable.customize.tf
sed -i.bak "s/  default = \"[a-zA-Z0-9_]*\" # project/  default = \"${project}\" # project/" root-infra/variable.customize.tf
rm -rf root-infra/variable.customize.tf.bak
cat root-infra/variable.customize.tf | grep "# company"
cat root-infra/variable.customize.tf | grep "# project"




