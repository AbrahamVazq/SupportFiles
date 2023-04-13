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

 ${L_CYAN}1) First Option
 2) Second Option
 3) Third Option
 ${NC}"

read xc

case $xc in
# Ej:
#     schema="GSSARemittances"
#     cd ~/Documents/bazSuperApp/Remesas/GSSACoreFrameworks_iOS

 1 )
    schema="Put schema name"
    cd #TODO: Put the path to directory
 ;;
 2 )
    schema="Put schema name"
    cd #TODO: Put the path to directory
 ;;
 3 )
    schema="Put schema name"
    cd #TODO: Put the path to directory
 ;;
 * )
 
 echo -e "${CYAN}${bold}Elige una opción de la Lista."
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
echo ""
echo "  Creando el Archive para Simulador  "

echo -e "${PURPLE}${bold} "

################################# X G G E N E R A T E #################################################

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
         echo "${NC}Armando el xcframework ... un segundo"

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
