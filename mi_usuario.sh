#!/bin/bash

#
#  Archivo con el código asociado a la gestión de Usuarios
#


informacion_inicial_usuarios()
{    
    	
   clear
	echo "----------------------------------------------------------------"    
	echo "----------------------------------------------------------------" 	
   echo -e " \t [r] Ha seleccionado la opción GESTIONAR USUARIOS"
   echo -e " \t [e] Volver al menú de inicio"
   echo "----------------------------------------------------------------" 	 
   echo "----------------------------------------------------------------" 
    
	echo -e "\n"
	echo -e "Selecciona una opcion"
	read opcion

}



gestionar_usuarios()
{    
proceso=1
echo "Añade el número de usuarios a crear"
read NO
while [ $proceso -le $NO ]; do

echo "Agregue username" $proceso
read username
echo "El nombre del username es ---->  " $username
echo "Pon el nombre completo al username"
read nombre
echo "Ademas, añade su apellido a " $nombre
read apellido

login=`echo $username`
fase1=`echo $nombre` 
fase2=`echo $apellido` 
fases=`echo "coment1, coment2"`
useradd -d /home/$username -m -s /bin/bash -c $fases $username > /dev/null 2&>1

echo "$username" $proceso "Creado" 
let proceso=proceso+1
done
}

menu_procesos()
while !([ "$opcion" = 'e' ])
do
	informacion_inicial_procesos

	case $opcion in
			r)
				gestionar_usuarios
			;;

			e)
				volver_al_menu
			;;
			esac

done 





