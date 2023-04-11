
#!/bin/bash
echo "Hola Mundo"

directorio=$1

if [[ $1 == "" ]]
then
  echo "El Directorio esta vacio"
else
  echo "El Directorio es: $directorio "
fi

