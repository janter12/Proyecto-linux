#!/bin/bash

#
#  Archivo con el código asociado a la gestión de procesos
#


Menu_de_procesos()
{    
	clear
	echo "----------------------------------------------------------------"    
	echo "----------------------------------------------------------------" 	
  echo -e "\t Mostrar menu de procesos"
  echo "----------------------------------------------------------------"
  echo "----------------------------------------------------------------"
  echo -e " \t [c] Ha seleccionado la opción GESTIONAR PROCESOS"	
  echo -e " \t [f] Ha seleccionado la opción GESTIONAR PROPIEDADES"
  echo -e " \t [l] Ha seleccionado la opción GESTIONAR PROCESOS EN SEGUNDO PLANO"
  echo -e " \t [e] Volver al menú de inicio"
   echo "----------------------------------------------------------------"
  
	echo -e "\n"
	echo -e "Selecciona una opcion"
	read opcion

}


gestionar_procesos()
{    
    	
    echo "Aquí iría código para la gestión de disco"
    
echo "Mostramos los procesos"
ps aux

echo "dame un PID"
read pid

echo "Mostramos señales"
kill -l

echo "dame una señal"
read senal
kill $pid $senal
}

gestionar_propiedades()
{
echo "Listamos procesos"
ps la

echo "Proceso el cual se quiere cambiar la prioridad "
read proceso

echo "Prioridad a dar"
read prioridad

echo "cambio de prioridad al proceso"
renice $prioridad $proceso 

if [$? -eq 0]
then
	echo "Has cambiado la prioridad"
	ps -eo stat,pcpu,pid,user,fname,nice

else
	echo "No has cambiado la prioridad"
fi 
}

gestionar_segundo_plano()
{
sleep 100 & sleep 101 &
echo "Mostramos los procesos en segundo plano"
jobs

echo "Pasar a primer plano el proceso a elegir:"
read proc

fg %$proc

jobs
echo "Proceso pasado a primer plano"
read enter
}

volver_al_menu()
{
clear
echo "Has seleccionado volver al menu"
killall sleep &
}

menu_procesos()
while !([ "$opcion" = 'e' ])
do
	Menu_de_procesos

	case $opcion in
			c)
				gestionar_procesos
			;;
	
			f)
				gestionar_propiedades
			;;

			l)
				gestionar_segundo_plano
			;;

			e)
				volver_al_menu
			;;
			esac

done 





