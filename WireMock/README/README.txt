Para correr WireMock :

java -jar wiremock-jre8-standalone-2.35.0.jar  --port XXXX  --verbose

ej: 

java -jar wiremock-jre8-standalone-2.35.0.jar --port 9999 --verbose



Descubra el ID de proceso (PID) que ocupa el número de puerto (por ejemplo, 5955) que desea liberar

sudo lsof -i :9999


Elimine el proceso que actualmente utiliza el puerto utilizando su PID

sudo kill -9 PID


en el proyecto, cambiar la IP, a la IP de la maquina mas el puerto que configuramos, con el protocolo http

http:0.0.0.0:XXXX

ej: 

http://192.168.0.199:9999


http://192.168.0.199:9999


https://apigateway.superappbaz.com