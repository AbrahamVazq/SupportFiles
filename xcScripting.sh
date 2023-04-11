
#!/bin/bash
echo "Hola Mundo"

echo -e "\033[750mTexto con tamaño 20\033[0m"

directorio=$1

if [[ $1 == "" ]]
then
  echo "El Directorio esta vacio"
else
  echo "El Directorio es: $directorio"
  echo "$directorio"  > ~/Directorios.txt
fi

# animacion() {
#   local delay=0.1
#   local chars="/-\|"

#   while true; do
#     for (( i=0; i<${#chars}; i++ )); do
#       echo -en "${chars:$i:1}" "\r"
#       sleep $delay
#     done
#   done
# }

# animacion


# animacion() {
#   local width=50
#   local chars="=>"
#   local percent=0

#   while [ $percent -lt 100 ]; do
#     ((percent++))
#     ((pos = percent * width / 100))
#     echo -en "\r["
#     for ((i=1; i<=width; i++)); do
#       if [ $i -le $pos ]; then
#         echo -en "${chars:0:1}"
#       else
#         echo -en " "
#       fi
#     done
#     echo -en "] $percent%"
#     sleep 0.1
#   done
# }

# animacion() {
#   local delay=0.5

#   while true; do
#     echo -en "\e[5m.\e[25m"
#     sleep $delay
#   done
# }


animacion() {
  local delay=0.1
  local position=0
  local direction=1
  local char="*"

  while true; do
    # Mueve el cursor a la posición actual
    echo -en "\x1B[${position}G"
    # Imprime el carácter
    echo -n "${char}"
    # Espera un momento
    sleep $delay
    # Mueve el cursor a la posición anterior y borra el carácter anterior
    echo -en "\x1B[${position}G"
    echo -n " "
    # Cambia la dirección si llega al límite
    if [ $position -eq 0 ] || [ $position -eq 5 ]; then
      direction=$((direction * -1))
    fi
    # Incrementa o decrementa la posición según la dirección
    position=$((position + direction))
  done
}


animacion

# validar que si el directorio existe, pero no hay archivos, no mandar error


mostrar_archivo() {
  echo "Contenido del archivo $directorio:"
  cat $directorio
}

mostrar_archivo $directorio