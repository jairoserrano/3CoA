#!/bin/bash
# Desarrollado por:
# Jairo Enrique Serrano Castañeda (jairo@utbvirtual.edu.co)
# Andres Armando Sanchez Martin (computacion@renata.edu.co)
# para uso de la Comunidad Colombiana de Computacion Avanzada - 3CoA   (3CoA@renata.edu.co)
echo ""
echo "*****************************************************************************"
echo "* Inicio el script de ejecucion del protocolo de pruebas de conexion - 3CoA *"
echo "*****************************************************************************"
echo ""
#aplicaciones necesaria para ejecutar el protocolo de pruebas
yum -y install nmap net-tools iputils-tracepath netcat-openbsd 
#lista de nombres de dominio e IPs de las instituciones destino
ce=(	"gc1-ce.renata.edu.co" "186.113.12.24" 
	"gc.ucatolica.edu.co" "200.2.66.32" 
	"gfif.udea.edu.co" "200.24.17.54" 
	"gc1-ce.univalle.edu.co" "181.118.153.207" 
	"c-head.ucaldas.edu.co" "200.21.104.31" 
	"gc1.javerianacali.edu.co" "181.118.149.209" 
	"gc1-ce.uniatlantico.edu.co" "179.0.29.112"
	"grid.unitecnologica.edu.co" "190.26.217.240"
	"ce.autonoma.edu.co" "200.21.104.74"
)
#lista de puertos a probar en las instituciones destino
puertos=("22" "53" "80" "88" "389" "443" "445" "464" "636" "943" "1194" "2119" "2811" "3268" "3269" "8080" "8443" "8649" "9443" "9000" "9999" "20000" "22000" "23000" "25000")
> resultados_`hostname`.txt
echo "-------------------------Resultados `hostname`---------------------------------">> resultados_`hostname`.txt

#Funcion para traceroute por DN e IP
trace(){
	echo "-------------------------Inicio prueba de trazas-------------------------------">> resultados_`hostname`.txt
	for i in ${ce[@]}; 
	do
		echo "-------------------------------------------------------------------------------">> resultados_`hostname`.txt
		echo "traceroute para ${i}">> resultados_`hostname`.txt
	        traceroute ${i}>> resultados_`hostname`.txt
		echo "-------------------------------------------------------------------------------">> resultados_`hostname`.txt
	done
	echo "-------------------------Fin prueba de trazas----------------------------------">> resultados_`hostname`.txt
}

#Funcion para evaluacion de puertos locales
localport(){
	echo "-----------------------Inicio prueba de puertos locales------------------------">> resultados_`hostname`.txt
	echo "-----------------------Puertos en Escucha--------------------------------------">> resultados_`hostname`.txt
	netstat -tupan | grep LISTEN>> resultados_`hostname`.txt
	echo "-----------------------Fin prueba de puertos locales---------------------------">> resultados_`hostname`.txt
}
#Funcion para evaluar los puertos de las instituciones con nmap por DN e IP
externalport (){
	echo "-----------------------Inicio prueba de NMap-----------------------------------">> resultados_`hostname`.txt
	for i in ${ce[@]}; do
		echo "-------------------------------------------------------------------------------">> resultados_`hostname`.txt
		echo "NMap para ${i}"
		nmap "${i}">> resultados_`hostname`.txt
		echo "-------------------------------------------------------------------------------">> resultados_`hostname`.txt
	done
	echo "-------------------------Fin prueba de NMap------------------------------------">> resultados_`hostname`.txt
}
#Funcion para NetCat de los puertos por DN e IP
ports(){
	echo "--------------------------Inicio prueba de NetCat------------------------------">> resultados_`hostname`.txt
	for i in ${ce[@]}; do
		echo "-------------------------------------------------------------------------------">> resultados_`hostname`.txt
		echo "-------------------------- Puertos abiertos para ${i} -------------------------">> resultados_`hostname`.txt
		echo "-------------------------------------------------------------------------------">> resultados_`hostname`.txt
		for j in ${puertos[@]}; 
		do
			echo "------------------------------------puerto ${j}--------------------------------">> resultados_`hostname`.txt
			nc -zv ${i} ${j}>> resultados_`hostname`.txt
		done
		echo "-------------------------------------------------------------------------------">> resultados_`hostname`.txt
	done
	echo "---------------------------Fin prueba de telnet--------------------------------">> resultados_`hostname`.txt
}
trace
localport
externalport
ports

echo ""
echo "******************************************************************************"
echo "* Termino el script de ejecucion del protocolo de pruebas de conexion - 3CoA *"
echo "******************************************************************************"
echo ""
