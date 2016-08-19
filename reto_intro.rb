#valores constantes dentro de la matriz
  #Barco: un barco
  #Nada: espacio vacío
  #Falli: disparo que falló
  #Barco_Hundido: lugar donde se hundió un barco
Barco            = 1
Nada             = 0
Ataque_Fallido   = 2
Barco_Hundido    = 3


#generar una matriz del tamaño: largo x largo, rellena con ceros '0' que representan Nada
def generar_matriz(largo)
  matriz = []
  aux =[]
  for   a in 0..largo-1
    for b in 0..largo-1
      aux[b] = 0
    end
    matriz[a] = aux
    aux=[]
  end
  return matriz
end

def pedir_num_barcos
  system("clear")
  puts "#{Nombre_jugador_1} por favor, indica el número de barcos (entre 4 y 10):"
  num_incorrecto = true
  while (num_incorrecto)
    num_barcos = gets.chomp.to_i
    num_incorrecto = validar_num_barcos(num_barcos)
  end
  return num_barcos
end

def validar_num_barcos(num_barcos)
  if num_barcos < 4 || num_barcos > 10
    system("clear")
    puts "#{Nombre_jugador_1} Por favor... coopera, indica un número que sea mayor o igual a 4 y menor o igual a 10: "
    return true
  else
    return num_incorrecto =false
  end
end

# cuenta la cantidad de algo en la matriz, por ejemplo Barcos, Ataque_Fallidos, Barco_Hundidos
def contar_algo(matriz, algo)
  contador = 0
  for   a in 0..matriz.length-1
    for b in 0..matriz[0].length-1
      if matriz[a][b] == algo
          contador +=1
      end
    end
  end
  return contador
end


=begin
cómo mostrar el tablero:
          1 2 3
        A|?|?|?|
        B|?|H|?|
        C|?|?|F|

este método debe recibir una matriz, y sólo la muestra

ahora, puede hacerse otro método sólo para el decorado, por ejemplo de letras y números

F= falló un disparo
H= hundió un barco
?= posicón no atacada aún
=end

def ataque_efectivo(objetivo)
    if objetivo == Barco
       true
    else
       false
    end
end

def ataque_valido(objetivo)
  if objetivo == Ataque_Fallido  || objetivo == Barco_Hundido
      false
  else
      true
  end
end

def determinar_sustituto_del_objetivo(objetivo)
  case objetivo
    when Barco
      Barco_Hundido
    when Nada
      Ataque_Fallido
  end
# Los sustitutos son lo que se pondrá en la matriz luego de un ataque,
# dependiendo de qué había antes:
#  -de Barco un Barco_Hundido
#  -de Nada  un Ataque_Fallido
end


def poner_algo_en_matriz(matriz,fila, columna, algo)
  matriz[fila][columna] = algo
end

# revisa una posición en la matriz y devuelve su valor
def devolver_posicion_en_matriz(matriz, fila, columna)
 return matriz[fila][columna]
end

# devuelve un array de coordenadas: [fila,columna]
def determinar_coordenadas_dev(fila, columna)
 fila    = determinar_fila(fila)
 columna = determinar_columna(columna)
 return [fila,columna]
end


def validar_fila(fila, modo_ataque)
  if modo_ataque == true
     if fila < "k" || fila > "t" || fila.length > 1
        return false
     else
        return true
     end
  else
     if fila < "a" || fila > "j" || fila.length > 1
        return false
     else
        return true
     end
  end
end


#llamar validar_fila antes
#recibe un string de largo 1
def determinar_fila(fila_recibida, modo_ataque)
  if modo_ataque == true
     letras    = ["k","l","m","n","o","p","q","r","s","t"]
  else
     letras    = ["a","b","c","d","e","f","g","h","i","j"]
  end
 # numericos = [0,1,2,3,4,5,6,7,8,9]
   for i in 0..letras.length-1
     if fila_recibida == letras[i]
        # i representa la fila
        return i
     end
   end
   return nil
end

def determinar_columna(columna)
  return columna-1
end

def validar_columna(columna)
  if columna < 1 || columna > 10
      return false
  else
      return true
  end
end


def pedir_nombre
  puts "Por favor ingresa tu nombre"
  nombre = gets.chomp
  nombre
end

def generar_coordenadas_random(matriz)
   return rand(matriz.length)
end

def mostrar_matriz_dev(matriz)
  for i in 0..matriz.length-1
    for x in 0..matriz[0].length-1
      print "#{matriz[i][x]} "
    end
    puts
  end
  puts"--------------------------"
end


# probar la funcionalidad de la matriz
# bucle infinito
def probar_matriz_dev
  mi_matriz = generar_matriz(10)
  system("clear")
  sigue=true
  while (sigue) do
    puts "contador de barcos = #{contar_barcos(mi_matriz)}"
    puts "dame la columna: del 1 al 10 "
    columna = gets.chomp.to_i
    puts "dame la fila en letras de la a..j: "
    fila=gets.chomp

    array_coordenadas = determinar_coordenadas_dev(fila, columna)
    poner_algo_en_matriz(mi_matriz,array_coordenadas[0], array_coordenadas[1], 1)
    mostrar_matriz_dev(mi_matriz)
    puts  "dime si sigo en minusculas s o n:"
    sigue_= gets.chomp


    if sigue_ == 'n'
      sigue= false
    end
  end
end


def fila_determinada(mensaje, modo_ataque)
   fila_dada    = pedir_fila(mensaje, modo_ataque)
   return determinar_fila(fila_dada, modo_ataque)
end

def columna_determinada
   columna_dada = pedir_columna
   return determinar_columna(columna_dada)
end

def pedir_algo(mensaje)
  puts "Por favor, ingrese #{mensaje}"
  respuesta = gets.chomp.downcase
  system("clear")
  return respuesta
end

#devuelve una fila segura
def pedir_fila(mensaje, modo_ataque)
  fila_correcta=false

  intentos = 0
  until fila_correcta do
    fila          = pedir_algo("una fila #{mensaje}")
    fila_correcta = validar_fila(fila, modo_ataque)
    intentos += 1

    if intentos > 3
       puts "Conchale coopera, vale..."
       intentos = 0
    end
  end
  return fila
end

def pedir_columna
  columna_correcta=false

  until columna_correcta do
    columna       = pedir_algo("una columna entre 1 y 10.").to_i
    columna_correcta = validar_columna(columna)
  end
  return columna
end

#hay que pasarle la matriz del otro jugador
def jugando_jugador_1(matriz)
    jugador_1_no_ha_fallado = true

    while jugador_1_no_ha_fallado
      jugador_1_no_ha_fallado = turno_jugador_1(matriz)
    end
end


def turno_jugador_1(matriz)
  puts "Tu turno #{Nombre_jugador_1}!"
  #pedir coordenadas
  fila    = fila_determinada(" entre la 'k' y la 't'.", true)
  columna = columna_determinada

  objetivo = devolver_posicion_en_matriz(matriz, fila, columna)
  determinar_ataque(matriz, fila, columna, objetivo)
  informar_ataque(objetivo)
  #si el ataque no fue valido está perdiendo el turno
  if ataque_valido(objetivo) == false
    return true
  end
  return ataque_efectivo(objetivo)
end

def determinar_ataque(matriz, fila, columna, objetivo)
  if ataque_valido(objetivo)
    asignar_ataque_en_matriz(matriz, fila, columna, objetivo)
  end
end

def informar_ataque(objetivo)
  if ataque_valido(objetivo)
      informar_ataque_valido(objetivo)
  else
      informar_ataque_invalido(objetivo)
  end
end


def asignar_ataque_en_matriz(matriz, fila, columna, objetivo)
    sustituto= determinar_sustituto_del_objetivo(objetivo)
    poner_algo_en_matriz(matriz, fila, columna,sustituto)
end

def informar_ataque_invalido(objetivo)
    system("clear")
    print "La posición a la que apuntaste era "
    case objetivo
      when Ataque_Fallido
        puts "una en la que ya habías intentado antes."
      when Barco_Hundido
        puts "un barco hundido."
    end
    puts "Intenta tu disparo de nuevo."
end

def informar_ataque_valido(objetivo)
  case objetivo
    when Barco
      puts "Le diste!, has hundido un barco."
      puts "Tomaste la ventaja. Puedes disparar de nuevo."
    when Nada
      puts "Fallaste, tu disparo se perdío en la nada."
      puts "El enemigo se prepara para disparar."
  end
end

def jugando_jugador_2(matriz)
    jugador_2_no_ha_fallado = true

    while jugador_2_no_ha_fallado
     jugador_2_no_ha_fallado = turno_computadora(matriz)
    end
end

def turno_computadora(matriz)
  fila    = generar_coordenadas_random(matriz)
  columna = generar_coordenadas_random(matriz)

  objetivo = devolver_posicion_en_matriz(matriz, fila, columna)
  determinar_ataque(matriz, fila, columna, objetivo)

  informar_ataque_valido_enemigo(objetivo)

  if ataque_valido(objetivo) == false
    return true
  end
  return ataque_efectivo(objetivo)
end

def informar_ataque_valido_enemigo(objetivo)
  case objetivo
    when Barco
      puts "El ataque enemigo ha alcanzado uno de tus barcos!, el barco se hunde."
      puts "El enemigo tomó la ventaja. Cuidado, se dispone a atacar de nuevo..."
    when Nada
      puts "El enemigo ha intentado atacarte, pero falló, su disparo fue inutil."
  end
end


def juego(matriz_jugador_1,matriz_jugador_2)
  nadie_ha_perdido = true
  while nadie_ha_perdido

    jugando_jugador_1(matriz_jugador_2)
    barcos_jugador_2 =contar_algo(matriz_jugador_2, Barco)

    puts
    mostrar_matriz(matriz_jugador_2, "J", true)
    puts
    puts
    mostrar_matriz(matriz_jugador_1, "@", false)

    jugando_jugador_2(matriz_jugador_1)
    barcos_jugador_1 = contar_algo(matriz_jugador_1, Barco)

    if barcos_jugador_1 == 0 || barcos_jugador_2 == 0
      nadie_ha_perdido = false
      mensaje_final(barcos_jugador_1, barcos_jugador_2)
    end
  end
end

def mensaje_final(barcos_jugador_1, barcos_jugador_2)
  system("clear")
  puts "Terminó el juego!"
  if     barcos_jugador_1 == 0 && barcos_jugador_2 == 0
   puts "Hubo un empate!"
  elsif barcos_jugador_1 == 0
   puts "Perdiste el juego"
  else
   puts "Ganaste!"
  end
end

#        *funciones para mostrar el tablero
def mostrar_matriz(matriz, fila_letra, oculto)
# recibe fila_letra como punto de inicio de las letras
# para las filas '@' para comenzar desde 'A' y 'J'
# para comenzar desde 'K'
  espacios=" "*20

  if oculto == true
    imprimir_leyenda_1
    puts "  *Has hundido #{contar_algo(matriz,Barco_Hundido)} de los barcos enemigos,"
    puts "   hay todavía al menos #{contar_algo(matriz,Barco )}"
  end

  print_cintillo_numerico(matriz.length)
  for i in 0..matriz.length-1
    print "#{espacios}#{fila_letra=fila_letra.next}"
    print "|"
    for x in 0..matriz[0].length-1
      if oculto== true
        print "#{ocultar_informacion(matriz[i][x])}|"
      else
        print "#{mostrar_informacion(matriz[i][x])}|"
      end
    end
    print fila_letra
    puts


  end
  print_cintillo_numerico(matriz.length)

  if oculto == false
    imprimir_leyenda_2
    puts "  *El enemigo ha hundido #{contar_algo(matriz,Barco_Hundido)} de tus barcos,"
    puts "   aun cuentas con #{contar_algo(matriz,Barco)} de ellos. "
  end
end

def print_cintillo_numerico(largo)
  espacios=" "*20
  print " #{espacios}_"

  for i in 0..largo-1
    print "#{i}_"
  end
  puts
end

def ocultar_informacion(objetivo)
  case objetivo
    when Barco, Nada
      return "?"
    when Ataque_Fallido
      return "X"
    when Barco_Hundido
      return "H"
    end
end

def imprimir_leyenda_1
  puts "  Leyenda:"
  puts "  X  = ataque fallido"
  puts "  ?  = zona desconocida"
  puts "  H  = barco hundido"
end

def imprimir_leyenda_2
  puts "  Leyenda:"
  puts "  B    = barco"
  puts "  ' '  = zona vacía"
end

def mostrar_informacion(objetivo)
  case objetivo
    when Barco
      return "B"
    when Nada
      return "_"
    when Ataque_Fallido
      return "X"
    when Barco_Hundido
      return "H"
    end
end



#        *funciones relativas al inicio del juego

def inicio
  #la matriz_jugador_1 es dondel el jugador 1 pondrá sus barcos
  #pero el jugador 1 atacará la matriz_jugador_2, que es donde el
  #jugador 2 pondrá sus barcos

  matriz_jugador_1 = generar_matriz(10)
  matriz_jugador_2 = generar_matriz(10)


  num_barcos = pedir_num_barcos

  poner_barcos_random(matriz_jugador_2, num_barcos)


  poner_barcos_como_sea(matriz_jugador_1, num_barcos, pedir_como_poner_barcos)

  juego(matriz_jugador_1, matriz_jugador_2)
end

def poner_barcos_como_sea(matriz, num_barcos, respuesta)
  if respuesta == "s"
    poner_barcos_random(matriz, num_barcos)
    puts "Se han puesto los barcos de modo aleatorio."
    mostrar_matriz(matriz, "@", false)

  else
    poner_barcos(matriz, num_barcos)
    puts "Todos tus barcos están ordenados como lo pediste."
  end
end

def pedir_como_poner_barcos
  system("clear")
  puts "Quieres poner tus barcos aleatoriamente? s/n"
  system("stty raw -echo")
  respuesta = STDIN.getc
  system("stty -raw echo")
  return respuesta
end

def poner_barcos(matriz, num_barcos)
  barcos_restantes = num_barcos

  while barcos_restantes > 0

   #pedir coordenadas
   fila    = fila_determinada( "entre la 'a' y la 'j'.", false)
   columna = columna_determinada

   if devolver_posicion_en_matriz(matriz, fila, columna) == Nada
      poner_algo_en_matriz(matriz, fila, columna, Barco)
      mostrar_matriz(matriz, "@", false)
      barcos_restantes-=1

   else
      system("clear")
      puts "Posición ocupada, intenta en otra posición"

   end
  end
end

def poner_barcos_random(matriz, num_barcos)
  barcos_restantes = num_barcos

  while barcos_restantes > 0
   # no pedir sino poner
   fila    = generar_coordenadas_random(matriz)
   columna = generar_coordenadas_random(matriz)

   if devolver_posicion_en_matriz(matriz, fila, columna) == Nada
      poner_algo_en_matriz(matriz, fila, columna, Barco)
      barcos_restantes-=1
   end
  end
end
#                          ****MAIN****

  system("clear")
  puts "Bienvenido al juego!"
  Nombre_jugador_1 = pedir_nombre
  inicio
