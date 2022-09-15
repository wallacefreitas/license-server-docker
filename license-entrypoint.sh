#!/bin/bash

if [ -d "totvs/license/" ]
then
    cd totvs/license/bin/appserver
else
    mkdir -p totvs/license_install/

    cd totvs/license_install/

    wget ftp://ftp.totvs.com.br/hlcloud/Instaladores/LicenseServerVirtual/x64/Linux/license-3.4.1.tar.gz
    tar xvf license-3.4.1.tar.gz -C /totvs

    cd ..
    mv Installer\ Linux\ x64/ license
    cd ../totvs/license

    bash install

    cd ../license/bin/appserver

    echo "
        [licenseserver]
        TotvsId=
        LsEnv=3
        LsAlias=
        LocalId=
    " >> licenseserverinstall.ini

    lsof -t -i:5555 | xargs kill -9
fi

cd totvs/license/bin/appserver
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:.

ulimit -s 1024
ulimit -n 65536

chmod +x appsrvlinux
./appsrvlinux

exec bash