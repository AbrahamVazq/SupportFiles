#!/bin/bash

#
#XC Generator version 1.3 , NS-Bionick and RobinTim software.
#Copyright (C) 2022-2023 NS-Bionick Development Team
#

schema=""
bold=$(tput bold)
normal=$(tput sgr0)
confirm=$(cat ~/.xcConfirm.txt)
title=$(cat ~/XCGenLogo.txt)


NC='\033[0m' # No Color
RED='\033[0;31m'
GREEN='\033[92m'
RED_SUB='\033[101m'
L_CYAN='\033[96m'
CYAN='\033[46m'
YELLOW='\033[93m'
PURPLE='\033[35m'
BLUE='\033[34m'

clear

echo -e "${BLUE}$title${NC}"
echo ""
echo -e " ·-= Cual ${bold}xcframework ${normal}vamos a generar? =-·

 ${L_CYAN}1) Remesas
 2) Nomina
 3) Autobuses
 4) Seguros
 5) Compras
 6) Pedidos
 7) Compras Reverso
 8) Chat
 9) Searcher
 10) Helper
 11) Red Social
 12) Syncronize
 13) Multimedia
 14) User Profile
 15) Gifs${NC}"

read xc

case $xc in
 1 )
    schema="GSSARemittances"
    cd ~/Documents/bazSuperApp/Remesas/GSSACoreFrameworks_iOS
 ;;
 2 )
    schema="GSSAPayroll"
    cd ~/Documents/bazSuperApp/Nomina/GSSACoreFrameworks_iOS
 ;;
 3 )
    schema="GSSABusTickets"
    cd ~/Documents/bazSuperApp/Boletos/GSSACoreFrameworks_iOS
 ;;
 4 )
    schema="GSInsurance"
    cd ~/Documents/bazSuperApp/Seguros/GSSACoreFrameworks_iOS
 ;;

 5 )
    schema="EKSAPurchases"
    cd ~/Documents/bazSuperApp/MisCompras/GSSACoreFrameworks_iOS
 ;;
 
 6) schema="GSSAMyOrders"
     cd ~/Documents/bazSuperApp/MisPedidos/GSSACoreFrameworks_iOS
 ;;
 
 7)
    schema="EKSAPurchases"
    cd ~/Documents/bazSuperApp/REVERSE_COMPRAS/GSSACoreFrameworks_iOS
 ;;

 8)
    schema="UPFMChat"
    cd ~/Documents/bazSuperApp/UPAX/Chat/superapp-ios-sdk-chat
 ;;

 9)
    schema="UPFMSearcher"
    cd ~/Documents/bazSuperApp/UPAX/Searcher/superapp-ios-sdk-searcher
 ;;

 10)
    schema="UPFMHelper"
    cd ~/Documents/bazSuperApp/UPAX/Helper/superapp-ios-sdk-helper
 ;;

 11)
    schema="UPFMSocialNetwork"
    cd ~/Documents/bazSuperApp/UPAX/Red\ Social/superapp-ios-sdk-socialnetwork
 ;;

 12)
    schema="UPFMDeviceContacts"
    cd ~/Documents/bazSuperApp/UPAX/Sincronizacion/superapp-ios-sdk-synchronization
 ;;

 13)
    schema="UPFMMultimedia"
    cd ~/Documents/bazSuperApp/UPAX/Multimedia/superapp-ios-sdk-multimedia
 ;;

 14)
    schema="UPFMUserProfile"
    cd ~/Documents/bazSuperApp/UPAX/Profile/superapp-ios-sdk-profile
 ;;

 15)
    schema="UPFMGifs"
    cd ~/Documents/bazSuperApp/UPAX/Multimedios/superapp-ios-sdk-multimedios
 ;;

 * )
 echo -e "${CYAN}${bold}Pon atencion a las instrucciones todo ciego!!!"
 exit
 ;;

esac

if [[ -d ~/Desktop/XCFrameworks_${schema} ]]
then
    if test -e ~/Desktop/XCFrameworks_${schema}/* ; then
       rm -R ~/Desktop/XCFrameworks_${schema}/*
    fi
else
   mkdir ~/Desktop/XCFrameworks_${schema}
fi

echo "  Creando el xcframework de ${bold}>> ${schema} <<"

echo "  Creando el Archive para Simulador  "

echo -e "${PURPLE}${bold} "

######################################################################################################

xcodebuild archive \
 -scheme ${schema} \
 -archivePath ~/${schema}-iphonesimulator.xcarchive \
 -sdk iphonesimulator \
 SKIP_INSTALL=NO  >> ~/${schema}-Simulador.txt


if [[  ! -z $(grep 'SUCCEEDED' ~/${schema}-Simulador.txt ) ]]
then

    rm -R ~/${schema}-*.txt
    echo -e "${NC}"
    echo -e "${BLUE}${bold}"
    echo "  Creando el Archive para dispositivo fisico"

    xcodebuild archive \
    -scheme ${schema} \
    -archivePath ~/${schema}-iphoneos.xcarchive \
    -sdk iphoneos \
    SKIP_INSTALL=NO >> ~/${schema}-Dispositivo.txt

    if [[ ! -z $(grep 'SUCCEEDED' ~/${schema}-Dispositivo.txt ) ]]
    then
         rm -R ~/${schema}-*.txt
         echo "   Armando el xcframework ... un segundo"

         xcodebuild -create-xcframework \
         -framework ~/${schema}-iphonesimulator.xcarchive/Products/Library/Frameworks/${schema}.framework \
         -framework ~/${schema}-iphoneos.xcarchive/Products/Library/Frameworks/${schema}.framework \
         -output ~/Desktop/XCFrameworks_${schema}/${schema}.xcframework

         echo -e "${GREEN}${bold}$confirm"
         open ~/desktop/XCFrameworks_${schema}
         
    else
         echo -e "${CYAN}${bold}ALGO OCURRIO EN GENERACION DE DISPOSITIVO"
         mv ~/${schema}-Dispositivo.txt  ~/${schema}-DispositivoError_$(date +%Y-%m-%d_%H:%M:%S).txt
   fi
else
    echo -e "${CYAN}${bold}ALGO OCURRIO EN GENERACION DE SIMULADOR"
    mv ~/${schema}-Simulador.txt  ~/${schema}-SimuladorError_$(date +%Y-%m-%d_%H:%M:%S).txt
    exit
fi

######################################################################################################

echo -e "Ahora, limpiaremos los archivos incesarios, hasta pronto!"

rm -R ~/${schema}-*.*
exit


# TO-DO:
# Agregar una animacion y saber donde pararla
