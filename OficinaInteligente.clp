;;; Hechos estaticos;
	(deffacts Habitaciones
	  (Habitacion Recepcion)    ;;;;  Receptión es una habitación
	  (Habitacion Pasillo)
	  (Habitacion Oficina1)
	  (Habitacion Oficina2)
	  (Habitacion Oficina3)
	  (Habitacion Oficina4)
	  (Habitacion Oficina5)
	  (Habitacion OficinaDoble)
	  (Habitacion Gerencia)
	  (Habitacion Papeleria)
	  (Habitacion Aseos)
	  (Habitacion AseoHombres)
	  (Habitacion AseoMujeres)
  )
  
  (deffacts Puertas
	  (Puerta Recepcion Pasillo)    ;;;; Hay una puerta que comunica Recepción con Pasillo
	  (Puerta Pasillo Oficina1)
	  (Puerta Pasillo Oficina2)
	  (Puerta Pasillo Oficina3)
	  (Puerta Pasillo Oficina4)
	  (Puerta Pasillo Oficina5)
	  (Puerta Pasillo Gerencia)
	  (Puerta Pasillo OficinaDoble)
	  (Puerta Pasillo Papeleria)
  )
  
  (deffacts Empleados
	  (Empleado G1 Oficina1)          ;;;;; El empleado G1 atiende en la Oficina 1
	  (Empleado G2 Oficina2)
	  (Empleado G3 Oficina3)
	  (Empleado G4 Oficina4)
	  (Empleado G5 Oficina5)
	  (Empleado E1 OficinaDoble)
	  (Empleado E2 OficinaDoble)
	  (Empleado Recepcionista Recepcion)
	  (Empleado Director Gerencia)
  )
  
   (deffacts Codificacion
		(Code TG "Tramites Generales")
		(Code TE "Tramites Especiales")
   )
	
  (deffacts Tareas
	  (Tarea G1 TG)                   ;;;;; El empleado G1 atiende Trámites Generales
	  (Tarea G2 TG)
	  (Tarea G3 TG)
	  (Tarea G4 TG)
	  (Tarea G5 TG)
	  (Tarea E1 TE)                   ;;;;; El empleado E1 atiende Trámites Especiales
	  (Tarea E2 TE)
	  (Tarea Director TESP)
  )
  
  
  (deffacts Inicializacion
	  (Personas 0)                    ;;; Inicialmente hay 0 personas en las oficinas
	  (Usuarios TG 0)                 ;;; Inicialmente hay 0 Usuarios de trámites generales
	  (UltimoUsuarioAtendido TG 0)    ;;; Inicialmente se han atendido 0 usuarios de tramites generales 
	  (Usuarios TE 0)
	  (UltimoUsuarioAtendido TE 0)
	  (Empleados 0)                   ;;; Inicialmente hay 0 empleados en las oficinas
	  (Ejecutar)
	  
	  (empleadosActivos TG 0)
	  (empleadosActivos TE 0)
	  (empleadosActivos TESP 0)
	  (TranscurridoAnterior 0)
	  
	  (TramitesRealizados TG 0)
	  (TramitesRealizados TE 0)
	  (MinutosEspera TG 0)
	  (MinutosEspera TE 0)
	  (MinutosGestion TG 0)
	  (MinutosGestion TE 0)
	  
	  (TramitesDiarios G1 0)
	  (TramitesDiarios G2 0)
	  (TramitesDiarios G3 0)
	  (TramitesDiarios G4 0)
	  (TramitesDiarios G5 0)
	  (TramitesDiarios E1 0)
	  (TramitesDiarios E2 0)
	  
	  (TiempoTotal G1 0)
	  (TiempoTotal G2 0)
	  (TiempoTotal G3 0)
	  (TiempoTotal G4 0)
	  (TiempoTotal G5 0)
	  (TiempoTotal E1 0)
	  (TiempoTotal E2 0)
	  
	  (Estado 1 noLlegado)
	  (Estado 2 atendiendo)
	  (Estado 3 disponible)
	  (Estado 4 descansando)
	  
	  (Situacion G1 1)
	  (Situacion G2 1)
	  (Situacion G3 1)
	  (Situacion G4 1)
	  (Situacion G5 1)
	  (Situacion E2 1)
	  (Situacion E1 1)
	  (Situacion Director 1)
	  
	  (Personas Oficina1 0)
	  (Personas Oficina2 0)
	  (Personas Oficina3 0)
	  (Personas Oficina4 0)
	  (Personas Oficina5 0)
	  (Personas OficinaDoble 0)
	  (Personas Gerencia 0)
	  (Personas Papeleria 0)
	  (Personas Aseos 0)
	  (Personas AseoHombres 0)
	  (Personas AseoMujeres 0)
	  (Personas Recepcion 0)
	  (Personas Pasillo 0)
	  
	  (Luz Oficina1 OFF)
	  (Luz Oficina2 OFF)
	  (Luz Oficina3 OFF)
	  (Luz Oficina4 OFF)
	  (Luz Oficina5 OFF)
	  (Luz OficinaDoble OFF)
	  (Luz Gerencia OFF)
	  (Luz Papeleria OFF)
	  
  )
  
	  
	;Cargamos fichero de constantes
	(defrule cargarconstantes
		(declare (salience 10000))	; salience mayor, prioridad mayor
		=>
		(load-facts Constantes.txt)
	)
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;REGLAS PRACTICA;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;; PASO1 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;respuestas ante los hechos (Solicitud ?tipotramite) y (Disponible ?emp);;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;; 1A ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	(defrule EncolarUsuario
		?g <- (Solicitud ?tipotramite)
		?f <- (Usuarios ?tipotramite ?n)
		=>
		(assert (Usuario ?tipotramite (+ ?n 1))
				(Usuarios ?tipotramite (+ ?n 1))
				(esperando ?tipotramite (+ ?n 1) ?*transcurrido*))
		(printout t "USUARIO: Su turno es " ?tipotramite " " (+ ?n 1)  crlf)
		(retract ?f ?g)
	)

	;;;;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;;;;;;;;;;;;;;;;;;;; 1B ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	;asigna empleado, contabilizando tramites y tiempo invertido.
	(defrule AsignarEmpleado
		(declare (salience 9005))
		?g <- (Disponible ?emp)
		(Tarea ?emp ?tipotramite)
		(Empleado ?emp ?ofic)
		?f <- (UltimoUsuarioAtendido ?tipotramite ?atendidos)
		
		?us<-(Usuario ?tipotramite ?x)
		(Usuarios ?tipotramite ?total)
		(test (< ?atendidos ?total))
		?esp<-(esperando ?tipotramite ?id ?ti)
		(test (= ?id (+ ?atendidos 1)))

		?me<-(MinutosEspera ?tipotramite ?val_me)

		?sit <- (Situacion ?emp 3)
		=>
		(bind ?a (+ ?atendidos 1))
		(assert (Asignado ?emp ?tipotramite ?a))
		(assert (cuando_asignado ?emp ?tipotramite ?a ?*transcurrido*))
		(assert (UltimoUsuarioAtendido ?tipotramite ?a))
		(printout t "USUARIO: " ?tipotramite ?a ", por favor pase a " ?ofic " le atendera " ?emp crlf)
		(retract ?f ?g ?esp ?me ?us ?sit )
		(assert (MinutosEspera ?tipotramite (+ ?val_me (minuto-segundos(- ?*transcurrido* ?ti)))))
		
		(assert (Situacion ?emp 2))
		
		;(assert (SeguireR (read)))
	)

	(defrule RegistrarCaso
		(Disponible ?emp)
		?f <- (Asignado ?emp ?tipotramite ?id)
		?c_a<-(cuando_asignado ?emp ?tipotramite ?id ?t)
		?trs<-(TramitesRealizados ?tipotramite ?tr)
		(Empleado ?emp ?ofic)
		
		?mg <- (MinutosGestion ?tipotramite ?val_mg)
		?td <- (TramitesDiarios ?emp ?val_td)
		?tt <- (TiempoTotal ?emp ?val_tt)
		
		?sit <- (Situacion ?emp ?val_sit)
		=>
		(retract ?f ?trs ?mg ?td ?sit ?c_a ?tt)
		(assert (TramitesRealizados ?tipotramite (+ ?tr 1)))
		(assert (Tramitado ?emp ?tipotramite ?id))
		(assert (MinutosGestion ?tipotramite (+ ?val_mg (minuto-segundos(- ?*transcurrido* ?t)))))
		(assert (TramitesDiarios ?emp (+ ?val_td 1)))
		(assert (TiempoTotal ?emp (+ ?val_tt (minuto-segundos(- ?*transcurrido* ?t)))))
		(assert (Situacion ?emp 3))
		(printout t "tramite diario, sale usuario.. " ?emp " " ?id 	crlf)
		;(assert (SeguireR (read)))
	)
	
	;(defrule disponible_noUsuarios
	;	?g <- (Disponible ?emp)
	;	?f <- (Asignado ?emp ?tipotramite ?id)
		
	;)

	;;;;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;;;;;;;;;;;;;;;;;;;; 1C ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


	(defrule NoposibleEncolarUsuario
		(declare (salience 20))
		?g <- (Solicitud ?tipotramite)
		(Usuarios ?tipotramite ?n)
		(UltimoUsuarioAtendido ?tipotramite ?atendidos)
		(TiempoMedioGestion ?tipotramite ?m)
		(FinalJornada ?h)
		(test (> (* (- ?n ?atendidos) ?m) (mrest ?h)))
		(Code  ?tipotramite ?texto)
		=>
		(printout t "AVISO: por hoy no podremos atender mas. " ?texto crlf)
		(bind ?a (- ?n ?atendidos))
		(printout t "Hay ya  " ?a " personas esperando y se cierra a las " ?h "h. No nos dara tiempo a atenderle." crlf)
		(retract ?g)
	)


	;;;;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; PASO2 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;;;;;;;;;;;;;;;;;;;;;;;;CONTROL DE CALIDAD DE SERVICIO;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	;Cuando un empleado ficha, se guarda la hora de entrada, comprueba si se ha retrasado
	(defrule fichando_entrada
		?f<-(Ficha ?emp)
		(not (entra ?emp ?t))
		(not (sale ?emp ?t_s))
		(Tarea ?emp ?tt)
		?eas<-(empleadosActivos ?tt ?ea)
		?sit <- (Situacion ?emp 1)
		=>
		;(printout t "ENTRA " ?emp 	crlf)
		;(assert (SeguireR (read)))
		(retract ?f ?eas ?sit)
		(assert (entra ?emp ?*transcurrido*))
		(assert (empleadosActivos ?tt (+ ?ea 1)))
		(assert (Situacion ?emp 3))
	)

	;Cuando un empleado ficha saliendo, y ya habia entrado se guarda la hora de salida
	;el empleado al salir, apaga luz de oficina
	(defrule fichando_salida
		?f<-(Ficha ?emp)
		?e<-(entra ?emp ?hora)
		(Tarea ?emp ?tt)
		(Empleado ?emp ?hab)
		?eas<-(empleadosActivos ?tt ?ea)
		?per<-(Personas ?hab ?n_per)
		
		?sit <- (Situacion ?emp ?val_sit)
		=>
		
		(assert (sale ?emp ?*transcurrido*))
		(retract ?f ?eas ?e ?sit ?per)
		
		(assert (empleadosActivos ?tt (- ?ea 1)))
		(assert (Situacion ?emp 4))
		(assert (Personas ?hab (- ?n_per 1)))
		
		(printout t "SALE " ?emp " DESCANSANDO " 	crlf)
		;(assert (SeguireR (read)))
	)
	
	;Si ficha cuando estaba atendiendo, anotamos el tramite
	(defrule sale_atendiendo
		(Situacion ?emp 4)
		(Asignado ?emp ?tipotramite ?a)
		(not (Tramitado ?emp ?tipotramite ?a))
		
		?c_a<-(cuando_asignado ?emp ?tipotramite ?id ?t)
		?trs<-(TramitesRealizados ?tipotramite ?tr)
		(Empleado ?emp ?ofic)
		
		?mg <- (MinutosGestion ?tipotramite ?val_mg)
		?td <- (TramitesDiarios ?emp ?val_td)
		?tt <- (TiempoTotal ?emp ?val_tt)
		
		=>
		
		(printout t "SALE " ?emp " atendiendo a " ?tipotramite ?a	crlf)
		;(assert (SeguireR (read)))
		
		(retract ?trs ?mg ?td ?c_a ?tt)
		(assert (TramitesRealizados ?tipotramite (+ ?tr 1)))
		(assert (Tramitado ?emp ?tipotramite ?id))
		(assert (MinutosGestion ?tipotramite (+ ?val_mg (minuto-segundos(- ?*transcurrido* ?t)))))
		(assert (TramitesDiarios ?emp (+ ?val_td 1)))
		(assert (TiempoTotal ?emp (+ ?val_tt (minuto-segundos(- ?*transcurrido* ?t)))))
		
		(assert (saliendo_usuario ?ofic))
	)
	
	(defrule saliendo_fichando_usuario
		(declare (salience 9000))
		?sa<-(saliendo_usuario ?hab)
		?se<-(Sensor_puerta ?hab)
		=>
		(printout t "Se quedo usuario dentro de " ?hab " al fichar su empleado atendiendo"	crlf)
		;(assert (SeguireR (read)))
		(retract ?sa ?se)
	)
	

	;Actualizamos el tiempo transcurrido para volver a comprobar las cosas
	(defrule time_to_check
		(hora_actual ?ha)
		(ComienzoAtencion ?cj)
		(FinalJornada ?fj) 
		(test (>= ?ha ?cj))
		(test (<= ?ha ?fj))

		?t <-(TranscurridoAnterior ?ta)
		(test (> (- ?*transcurrido* ?ta) 120))

		=>
		;(printout t "checking.. " 	crlf)
		;(assert (SeguireR (read)))
		(retract ?t)
		(assert (TranscurridoAnterior ?*transcurrido*))
	)
	
	(defrule no_more_check
		(hora_actual ?ha)
		(FinalJornada ?fj) 
		(test (>= ?ha ?fj))

		?t <-(TranscurridoAnterior ?ta)

		=>
		(retract ?t)
	)


	;;; 2A ;; 2B ;; Menos de N  empleados atendiendo tramites;;;;;;;;;;;;;;;;;

	(defrule no_emp_disponibles
		(hora_actual ?ha)
		(ComienzoAtencion ?cj)
		(test (>= ?ha ?cj))

		(empleadosActivos ?tt ?n)
		(MinimoEmpleadosActivos ?tt ?min)
		(test (< ?n ?min))

		;si han pasado 2 minutos desde la ultima cuenta
		(TranscurridoAnterior ?ta)
		(test (> (- ?*transcurrido* ?ta) 119))
		=>
		(printout t "AVISO: Hay menos de " ?min " empleados " ?tt " disponibles! (" ?n ") "  ?*transcurrido* " " ?ta 	crlf)
		;(assert (SeguireR (read)))
	)


	;;;2C;;;;;;; Usuario esperando mas de la cuenta ;;;;;;;;;;;;;;;;;

	(defrule comp_espera
		(hora_actual ?ha)
		(ComienzoAtencion ?cj)
		(test (>= ?ha ?cj))

		;si han pasado 2 minutos desde la ultima cuenta
		(TranscurridoAnterior ?ta)
		(test (> (- ?*transcurrido* ?ta) 119))

		(esperando ?tt ?id ?esp)
		(MaximoEsperaParaSerAtendido ?tt ?max)
		(test (>= (minuto-segundos(- ?*transcurrido* ?esp)) ?max))

		=>
		(printout t "EL USUARIO: " ?tt ?id " esta esperando mas de la cuenta! " ?*transcurrido* " " ?ta  crlf)
		;(assert (SeguireR (read)))
	)

	;;;2D;;;;;;; Usuario tardando en un tramite ;;;;;;;;;;;;;;;;;

	(defrule tard_tram
		(hora_actual ?ha)
		(ComienzoAtencion ?cj)
		(test (>= ?ha ?cj))

		;si han pasado 2 minutos desde la ultima cuenta
		(TranscurridoAnterior ?ta)
		(test (> (- ?*transcurrido* ?ta) 119))

		?c_a<-(cuando_asignado ?emp ?tipotramite ?id ?t)
		(MaximoTiempoGestion ?tipotramite ?max)
		(test (>= (minuto-segundos(- ?*transcurrido* ?t)) ?max))

		=>
		(printout t "EL EMPLEADO " ?emp " esta tardando demasiado con el usuario "  ?tipotramite ?id crlf)
		;(assert (SeguireR (read)))
	)



	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; PASO3 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;;;;;;;;;;;;;;;;;;;;;;;;CONTROL DE RENDIMIENTO;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	;;;3A;;;;;;; RETRASO MAYOR AL PERMITIDO ;;;;;;;;;;;;;;;;;

	(defrule demasiado_retraso
		(entra ?emp ?t_des)
		(TiempoMaximoRetraso ?val_ret)
		(ComienzoJornada ?val_cj)

		(test (and (>= ?*hora* ?val_cj)
						(> ?*minutos* ?val_ret)
				)
		)
		(not (retrasado ?emp))
		=>
		(printout t "EL EMPLEADO: " ?emp " se ha retrasado "  crlf)
		;(assert (SeguireR (read)))
	)


	;;;3B;;;;;;; DESCANSANDO DEMASIADO ;;;;;;;;;;;;;;;;;

	(defrule reentrada
		?f<-(Ficha ?emp)
		?s<-(sale ?emp ?t_s)
		(Tarea ?emp ?tt)
		?eas<-(empleadosActivos ?tt ?ea)
		
		=>
		(printout t "EL EMPLEADO " ?emp " ha vuelto del descanso. " crlf)
		;(assert (SeguireR (read)))
		(retract ?f ?s ?eas ?sit ?desc)
		(assert (entra ?emp ?*transcurrido*))
		(assert (empleadosActivos ?tt (+ ?ea 1)))
		
		(assert (Situacion ?emp 3))
		(assert (descanso ?emp))
	)
	
	;Cuando un empleado ficha entrando, una vez habia salido se guarda la hora de entrada
	(defrule demasiado_descanso
		(declare (salience 50))
		?f<-(Ficha ?emp)
		?s<-(sale ?emp ?t_s)
		(Tarea ?emp ?tt)
		(TiempoMaximoDescanso ?rt)
		?eas<-(empleadosActivos ?tt ?ea)

		(test (>= (minuto-segundos(- ?*transcurrido* ?t_s)) ?rt))
		
		?sit <- (Situacion ?emp 4)
		=>
		(printout t "EL EMPLEADO " ?emp " ha vuelto del descanso, descansado demasiado. " crlf)
		;(assert (SeguireR (read)))
		(retract ?f ?s ?eas ?sit)
		(assert (entra ?emp ?*transcurrido*))
		(assert (empleadosActivos ?tt (+ ?ea 1)))
		(assert (retrasado ?emp))
		
		(assert (Situacion ?emp 3))
	)
	
	;;;3C;;;;;;; POCOS TRAMITES DIARIOS ;;;;;;;;;;;;;;;;;
	(defrule tram_diarios_noSupered
		
		(FinalJornada ?fj)
		(hora_actual ?ha)
		(test (>= ?ha ?fj))
		
		(sale Director ?t)
	
		(MinimoTramitesPorDia ?tt ?min_t)
		
		(TramitesDiarios ?emp ?val_trams)
		(not (imprimido ?emp))
		(Tarea ?emp ?tt)
		
		(test (< ?val_trams ?min_t))
		
		
		=>
		(printout t "EL EMPLEADO " ?emp " ha realizado POCOS tramites. (" ?val_trams ") " crlf)
		;(assert (SeguireR (read)))
		(assert (imprimido ?emp))
	)
	
	;;; 3D ;;;;;;; SITUACION EMPLEADO ;;;;;;;;;;;;;;;;;
	(defrule situacionEmpleado
		?sab<-(saberSituacion ?emp)
		(Estado ?tipoe ?descripcion)
		(Situacion ?emp ?tipoe)
		=>
		(retract ?sab)
		(printout t "EL EMPLEADO " ?emp " esta en el estado " ?descripcion crlf)
		;(assert (SeguireR (read)))
	)
	
	;;FALTA EL FINAL DEL EJERICIO 3
	
		;;;;;;;contar e informes;;;;;

	(defrule informe1
		;(not (imprimido ?t))
		?tre<-(TramitesRealizados ?tt ?tr)
		?ming<-(MinutosGestion ?tt ?val_mg)
		?mine<-(MinutosEspera ?tt ?val_me)

		(FinalJornada ?fj)
		(hora_actual ?ha)
		(test (>= ?ha ?fj))
		
		(sale Director ?t)

		=>
		(retract ?tre ?ming ?mine)
		(assert (imprimido ?*transcurrido*))
		(printout t "IMPRIMIENDO INFORME 1.. " crlf)
		(bind ?med_esp (/ ?val_me ?tr))
		(bind ?med_gest (/ ?val_mg ?tr))
		(printout t "Tramites " ?tt " realizados: " ?tr crlf)
		(printout t "Tiempo medio de espera : " ?tt ": " ?med_esp crlf)
		(printout t "Tiempo medio de tramites : " ?tt ": " ?med_gest crlf)
		;(assert (SeguireR (read)))
	)
	
	(defrule informe2
		;(not (imprimido ?t))
		?td<-(TramitesDiarios ?emp ?valtd)
		?tto<-(TiempoTotal ?emp ?val_tt)
		(test (> ?valtd 0))
		
		(FinalJornada ?fj)
		(hora_actual ?ha)
		(test (>= ?ha ?fj))
		
		(sale Director ?t)
		=>
		(retract ?td ?tto)
		(assert (imprimido ?*transcurrido*))
		(printout t "IMPRIMIENDO INFORME 2.. " crlf)
		(bind ?med_ti (/ ?val_tt ?valtd))
		(printout t "Tramites " ?emp " realizados: " ?valtd crlf)
		(printout t "Tiempo total empleado por" ?emp ": " ?val_tt crlf)
		(printout t "Tiempo medio de " ?emp ": " ?med_ti crlf)
		;(assert (SeguireR (read)))
	)
	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; PASO 4 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;CONTROL DE LUCES;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
		
	;;;; DETECTAR PRIMERA ENTRADA OFICINA
	(defrule primera_entrada_segura
		(declare (salience 9010))
		?per<-(Personas ?hab 0)

		(Empleado ?emp ?hab)
		(not (sale ?emp ?t))		
		
		?pu<-(Sensor_puerta ?hab)
		
		?luz<-(Luz ?hab OFF)
		
		(not (saliendo_usuario ?hab))
		=>
		(retract ?per ?luz ?pu )
		(assert (Personas ?hab 1))
		(assert (Luz ?hab ON))
		
		(printout t "ENTRAN Y ENCIENDE LUZ de " ?hab crlf)
		;(assert (SeguireR (read)))
	)
	
	;Entrada del empleado doble oficina, una vez esta ya la luz encendida
	(defrule entrada_doble
		(declare (salience 9000))
		?pu<-(Sensor_puerta ?hab & OficinaDoble)
		(Empleado ?emp ?hab)
		(Empleado ?emp2 ?hab)
		(entra ?emp ?ti)
		(entra ?emp2 ?ti2)
		
		(test (< ?ti ?ti2))
		
		(not (sale ?emp ?ti))
		
		(Situacion ?emp 3)
		?per<-(Personas ?hab 1)
		
		(Luz ?hab ON)
		=>
		(retract ?per ?pu)
		(assert (Personas ?hab 2))
		
		(printout t "ENTRA el otro empleado a " ?hab " " crlf)
		;(assert (SeguireR (read)))
	)
	
	
	;;;; LUZ ENCENDIDA/APAGADA
	
	;;APAGAR LUZ cuando no haya nadie dentro
	(defrule apaga_luz
		?per<-(Personas ?hab ?num_per)
		(test (= ?num_per 0))
		
		?luz<-(Luz ?hab ON)
		=>
		(retract ?luz)
		(printout t "APAGANDO LUZ DE " ?hab crlf)
		;(assert (SeguireR (read)))
		(assert (Luz ?hab OFF))
	)
	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; PASO 5 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;CONTROL DE ANOMALIAS;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
	;Oficina vacía sin justificacion
	
	(defrule oficinas_vacias
		(FinalJornada ?fj)
		(sale ?emp ?t)
		(descansado ?emp)
		(hora_actual ?ha)
		
		(test (>= ?ha ?fj))
		=>
		(retract ?fj)
		(printout t "Oficina vacia sin justificacion de " ?emp  ?hab crlf)
	)
	
	;ususario no responde a la llamada
	
	(defrule usuario_noResponde
		(Asignado ?emp ?tipotramite ?a)
		(cuando_asignado ?emp ?tipotramite ?id ?t)
		(Empleado ?emp ?hab)
		(not (Sensor_puerta ?hab))
		
		?t <-(TranscurridoAnterior ?ta)
		(test (> (- ?*transcurrido* ?ta) 120))
		(not (Tramitado ?emp ?tipotramite ?id))
		
		=>
		
		(printout t "EL USUARIO " ?tipotramite ?id " no acude a la llamada." crlf)
		
	)
	
	
	
	
	
	
	
	
	