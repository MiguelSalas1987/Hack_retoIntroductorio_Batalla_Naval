#valores dentro de la matriz
  #Barco: un barco
  #Nada: espacio vacío
  #Falli: disparo que falló
  #Barco_Hundido: lugar donde se hundió un barco
Barco            = 1
Nada             = 0
Ataque_Fallido   = 2
Barco_Hundido    = 3

#hay que verificar antes de poner el barco
def poner_barcos_random(matriz, num_barcos)
  barcos_restantes = num_barcos
  mostrar_tablero  = false

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

#num_barcos = pedir_num_barcos()
#puts "num_barcos:#{num_barcos}"


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


def ataque_fallido(matriz, fila, columna)
    if matriz[fila][columna] == Barco
       false
    else
       true
    end
end

def ataque_valido(matriz, fila, columna)
  if matriz[fila][columna] == Ataque_Fallido  || matriz[fila][columna] == Barco_Hundido
      false
  else
      true
  end
end

def poner_algo_en_matriz(matriz,fila, columna, algo)
  matriz[fila][columna] = algo
end

# revisa una posción en la matriz y devuelve
def devolver_posicion_en_matriz(matriz, fila, columna)
 return matriz[fila][columna]
end

# devuelve un array de coordenadas: [fila,columna]
def determinar_coordenadas(fila, columna)
 fila    = determinar_fila(fila)
 columna = determinar_columna(columna)
 return [fila,columna]
end


def validar_fila(fila)
   if fila < "a" || fila > "j" || fila.length > 1
      return false
   else
      return true
   end
end


#llamar validar_fila antes
#recibe un string de largo 1
def determinar_fila(fila_recibida)
  letras    = ["a","b","c","d","e","f","g","h","i","j"]
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

#validación pendiente
#atención: no debe recibir un numero mayor a 10
def validar_columna(columna)
  if columna < 1 || columna > 10
      return false
  else
      return true
  end
end


def pedir_nombre
  puts "Por favor ingrese su nombre"
  nombre = gets.chomp
  nombre
end

def generar_coordenadas_random(matriz)
  rand(matriz.length)
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
# bucle infini
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

    array_coordenadas = determinar_coordenadas(fila, columna)
    poner_algo_en_matriz(mi_matriz,array_coordenadas[0], array_coordenadas[1], 1)
    mostrar_matriz_dev(mi_matriz)
    puts  "dime si sigo en minusculas s o n:"
    sigue_= gets.chomp


    if sigue_ == 'n'
      sigue= false
    end
  end
#hace lo que tiene que hacer
end

def poner_barcos(matriz, num_barcos)
  barcos_restantes = num_barcos
  mostrar_tablero  = false
  while barcos_restantes > 0

   #pedir coordenadas
   fila    = fila_determinada
   columna = columna_determinada

   if devolver_posicion_en_matriz(matriz, fila, columna) == Nada
      poner_algo_en_matriz(matriz, fila, columna, Barco)
      barcos_restantes-=1
      mostrar_tablero = true
   else
      system("clear")
      puts "Posición ocupada, intenta en otra posición"
      mostrar_tablero = false
   end

   if mostrar_tablero
     system("clear")
     puts "Tus barcos: "
     puts
     mostrar_matriz_dev(matriz)
   end
  end
end

def fila_determinada
   fila_dada    = pedir_fila
   return determinar_fila(fila_dada)
end

def columna_determinada
   columna_dada = pedir_columna
   return determinar_columna(columna_dada)
end

def pedir_algo(mensaje)
  puts "Por favor, ingrese #{mensaje}"
  respuesta = gets.chomp.downcase
  return respuesta
end

#devuelve una fila segura
def pedir_fila
  fila_correcta=false

  intentos = 0
  until fila_correcta do
    fila          = pedir_algo("una fila entre a y j.")
    fila_correcta = validar_fila(fila)
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
  #pedir coordenadas
  fila    = fila_determinada
  columna = columna_determinada

  #esto es lo que devovería al final
  return ataque_fallo(matriz, fila, columna)
end

def jugando_jugador_2(matriz)
    jugador_2_no_ha_fallado = true

    while jugador_2_no_ha_fallado
      turno_computadora(matriz)
    end
end

def juego(matriz_jugador_1,matriz_jugador_2)
  nadie_ha_perdido = true
  while nadie_ha_perdido

    jugando_jugador_1(matriz_jugador_2)
    barcos_jugador_2 =contar_algo(matriz_jugador_2, Barco)

    jugando_jugador_2(matriz_jugador_1)
    barcos_jugador_1 = contar_algo(matriz_jugador_1, Barco)

    if barcos_jugador_1 == 0 || barcos_jugador_2 == 0
      nadie_ha_perdido = false
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




#------------------------------------------------------
#def inicio_dev
  system("clear")
  puts "Bienvenido al juego!"

  #la matriz_jugador_1 es dondel el jugador 1 pondrá sus barcos
  #pero el jugador 1 atacará la matriz_jugador_2 que es donde el
  #jugador 2 pondrá sus barcos
  matriz_jugador_1 = generar_matriz(10)
  matriz_jugador_2 = generar_matriz(10)

  Nombre_jugador_1 = pedir_nombre

  num_barcos = pedir_num_barcos
  puts "hola"
  poner_barcos_random(matriz_jugador_2, num_barcos)
  puts "hey"
  system("clear")
  puts "Quieres poner tus barcos aleatoriamente? s/n"
  system("stty raw -echo")
  respuesta = STDIN.getc
  system("stty -raw echo")
  if respuesta == "s"
    poner_barcos_random(matriz_jugador_1, num_barcos)
    system("clear")
    puts "Los ceros representan nada, los 1 representan barcos"
    puts
    mostrar_matriz_dev(matriz_jugador_1)
  else
    poner_barcos(matriz_jugador_1, num_barcos)
    puts "pusiste todos tus barcos"
  end
#end

#inicio_dev




=begin

=end
