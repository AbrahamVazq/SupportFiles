#!/bin/bash

schema=""
bold=$(tput bold)
normal=$(tput sgr0)
confirm=$(cat ~/.xcConfirm.txt)
title=$(cat ~/.xcCreator.txt)

NC='\033[0m' # No Color
RED='\033[0;31m'
GREEN='\033[92m'
RED_SUB='\033[101m'
L_CYAN='\033[96m'
CYAN='\033[46m'
YELLOW='\033[93m'

printf "\n\n\n"
echo -e "${YELLOW}${bold}$title${NC}"
echo ""
echo -e " ·-= Cual ${bold}xcframework ${normal}vamos a generar? =-·

 ${L_CYAN}1) Remesas
 ${L_CYAN}2) Nomina
 ${L_CYAN}3) Autobuses
 ${L_CYAN}4) Seguros
 ${L_CYAN}5) Compras
 ${L_CYAN}6) Pedidos
 ${L_CYAN}7) Compras Reverso${NC}"

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
 
 
 * )
 echo -e "${CYAN}${bold}Pon atencion a las instrucciones todo ciego!!!"
 exit
 ;;

esac

echo "  Creando el xcframework de ${bold}>> ${schema} <<\n"

echo "  Creando el Archive para Simulador\n\n\n"

xcodebuild archive \
 -scheme ${schema} \
 -archivePath ~/${schema}-iphonesimulator.xcarchive \
 -sdk iphonesimulator \
 SKIP_INSTALL=NO

echo "  Creando el Archive para dispositivo fisico\n"

xcodebuild archive \
 -scheme ${schema}  \
 -archivePath ~/${schema}-iphoneos.xcarchive \
 -sdk iphoneos \
 SKIP_INSTALL=NO
 
echo "   Armando el xcframework ... un segundo\n\n\n"

xcodebuild -create-xcframework \
 -framework ~/${schema}-iphonesimulator.xcarchive/Products/Library/Frameworks/${schema}.framework \
 -framework ~/${schema}-iphoneos.xcarchive/Products/Library/Frameworks/${schema}.framework \
 -output ~/Desktop/${schema}.xcframework

echo -e "${GREEN}${bold}$confirm"
open ~/desktop
exit

# TO-DO:
# Iluminar las salidas de ambos esquemas, simulador y iphone
# eliminar los xcodebuild archive de salida despues de abrir el escritorio
# investigar como poder leer las salidas de las consutrcciones para saber si hay errores o no

#
#XC Generator version 0.2, NS-Bionick software.
#Copyright (C) 2022-2023 NS-Bionick Development Team
#

