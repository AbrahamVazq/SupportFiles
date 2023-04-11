
#!/bin/bash
echo "Hola Mundo"

directorio=$1

if [[ $1 == "" ]]
then
  echo "El Directorio esta vacio"
else
  echo "El Directorio es: $directorio"
  echo "$directorio"  > ~/Directorios.txt
fi



# validar que si el directorio existe, pero no hay archivos, no mandar error


mostrar_archivo() {
  echo "Contenido del archivo $directorio:"
  cat $directorio
}

mostrar_archivo $directorio