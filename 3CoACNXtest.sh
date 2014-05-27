#!/bin/bash

ceip=( 
	"186.113.12.24" "200.2.66.32" "200.24.17.54" 
	"200.21.104.31" "181.118.149.196" "181.118.153.207" 
	)
cen=( 
	"gc1-ce.renata.edu.co" "gc.ucatolica.edu.co" "gfif.udea.edu.co"
	"c-head.ucaldas.edu.co" "gc1.javerianacali.edu.co"
	)
puertos=(
	"22" "53" "80" "88" "389" "443" "445" "464" "636" "943" "1194" "2119"
	"2811" "3268" "3269" "8080" "8443" "8649" "9443" "9000" "9999" "20000"
	"22000" "23000" "25000"
	)

#Tracepath para los CE
trace_cen (){
	echo "----- Resultados `hostname` ------ "

	#Tracepath para los CE por nombres de dominio
	for i in ${cen[@]}; do
		echo "------------------------------------------"
		echo "tracepath para ${i}"
	        tracepath ${i}
		echo "------------------------------------------"
	done
}

#Tracepath para los CE por IPs
trace_ceip (){
	for i in ${ceip[@]}; do
		echo "------------------------------------------"
		echo "tracepath para ${i}"
		tracepath "${i}"
		echo "------------------------------------------"
	done
}

#NMap para los CE por IPs
nmap_cen (){
	for i in ${cen[@]}; do
		echo "------------------------------------------"
		echo "nmap para ${i}"
		nmap "${i}"
		echo "------------------------------------------"
	done
}

#NMap para los CE por IPs
nmap_ceip (){
	for i in ${ceip[@]}; do
		echo "------------------------------------------"
		echo "nmap para ${i}"
		nmap "${i}"
		echo "------------------------------------------"
	done
}

#Conexiones y puertos por IPs
nc_ip (){
	for i in ${ceip[@]}; do
		echo "------------------------------------------"
		echo "------ Puertos abiertos para ${i} --------" 
		echo "------------------------------------------"
		for j in ${puertos[@]}; do
			nc -zv ${i} ${j}
		done
		echo "------------------------------------------"
	done
}

trace_cen
trace_ceip
nmap_cen
nmap_ceip
nc_ip

