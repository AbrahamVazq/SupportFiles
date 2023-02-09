#!/bin/bash

schema=""
bold=$(tput bold)
normal=$(tput sgr0)

echo " ·-= Cual ${bold}xcframework ${normal}vamos a generar? =-·

 1) Remesas
 2) Nomina
 3) Autobuses
 4) Seguros
 5) Mis Compras
 6) Mis Pedidos"

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
    schema="GSInsurance"
    cd ~/Documents/bazSuperApp/Seguros/GSSACoreFrameworks_iOS
 ;;
  6 )
    schema="GSInsurance"
    cd ~/Documents/bazSuperApp/Seguros/GSSACoreFrameworks_iOS
 ;;
 
 * )
 echo "${bold}Pon atencion a las instrucciones todo ciego!!!"
 exit
 ;;

esac

echo "\n\nCreando el xcframework de ${bold}>> ${schema} <<\n"

echo "\n\n\n\nCreando el Archive para Simulador\n\n\n"

xcodebuild archive \
 -scheme ${schema} \
 -archivePath ~/${schema}-iphonesimulator.xcarchive \
 -sdk iphonesimulator \
 SKIP_INSTALL=NO

echo "\n\nCreando el Archive para dispositivo fisico\n"

xcodebuild archive \
 -scheme ${schema}  \
 -archivePath ~/${schema}-iphoneos.xcarchive \
 -sdk iphoneos \
 SKIP_INSTALL=NO
 
echo "\n\n\n\nArmando el xcframework ... un segundo\n\n\n"

xcodebuild -create-xcframework \
 -framework ~/${schema}-iphonesimulator.xcarchive/Products/Library/Frameworks/${schema}.framework \
 -framework ~/${schema}-iphoneos.xcarchive/Products/Library/Frameworks/${schema}.framework \
 -output ~/Desktop/${schema}.xcframework

#cat ~/.xcConfirm.txt
exit
