#!/bin/bash

#
#  Archivo con el código asociado a la gestión de Disco
#

informacion_inicial_discos()
{    
	clear
	echo "----------------------------------------------------------------"    
	echo "----------------------------------------------------------------" 	
   echo -e " \t [t] Ha seleccionado la opción GESTIONAR DISCO de 10G"
   echo -e " \t [e] Volver al menú de inicio"	
   echo "----------------------------------------------------------------" 	 
   echo "----------------------------------------------------------------" 
	
	echo -e "\n"
	echo -e "Selecciona una opcion"
	read opcion
}



gestionar_discos()
{    
echo "Buscando disposito a montar"
    fdisk -l | grep /dev/sdb > /dev/null 2>&1
if [ $? -gt 0 ];
then
   echo No existe el dispositivo a montar
   exit 2
fi

echo "Verificar si hay tamaño suficiente"
size=`fdisk -l | grep sdb | tr -s ' ' | cut -d ' ' -f 3`

if [ $size -le 5 ]; then
   echo El disco debe ser mayor que 5
   exit 3
fi

umount /dev/sdb1 > /dev/null 2>&1
fdisk /dev/sdb > /dev/null 2>&1 <<EOF
d
1
w
EOF

umount /dev/sdb2 > /dev/null 2>&1
fdisk /dev/sdb > /dev/null 2>&1 <<EOF
d
2
w
EOF

echo "Creamos las particiones"
fdisk /dev/sdb > /dev/null 2>&1 <<EOF
n
p


+5G
n
p



w
EOF


fdisk -l | grep "/dev/sdb1"
if [ $? -ne 0 ]
then
	echo "No se ha encontrado la particion /dev/sdb1"
	exit 5
fi

echo "ENHORABUENA, has creado correctamente la particion /dev/sdb1"


fdisk -l | grep "/dev/sdb2"
if [ $? -ne 0 ]
then
	echo "No se ha encontrado la particion /dev/sdb2"
	exit 5
fi

echo "ENHORABUENA, has creado correctamente la particion /dev/sdb2"

echo "Creamos las capetas, le damos formato y los montamos"
#Creamos las carpetas de montaje
mkdir -p /mnt/disco_1 > /dev/null 2>&1
mkdir -p /mnt/disco_2 > /dev/null 2>&1

#Formateamos las particiones y las montamos
mkfs.ext4 /dev/sdb1 > /dev/null 2>&1
mkfs.ext4 /dev/sdb2 > /dev/null 2>&1

mount -t ext4 /dev/sdb1 /mnt/disco_1 > /dev/null 2>&1
mount -t ext4 /dev/sdb2 /mnt/disco_2 > /dev/null 2>&1
    
}

menu_procesos()
while !([ "$opcion" = 'e' ])
do
	informacion_inicial_procesos

	case $opcion in
			t)
				gestionar_discos
			;;
	
			e)
				volver_al_menu
			;;
			esac

done 

