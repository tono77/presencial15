def pausa()
  puts "\n\nPresiona cualquier tecla para continuar....."
  gets.chomp
end


def read_file(file)
  file = File.open(file, 'r')
  data = file.readlines.map(&:chomp)
  file.close
  hash = {}
  data.each do |linea|
     arr = linea.split(", ")
     key = arr.shift
     hash[key] =  arr.map { |e| e != 'NR' ? e.to_i : 'NR'}
  end
  return hash
end


def total_prod(hash)
  total = {}
  hash.each do |producto, stock|
    suma = 0
    stock.each {|valor| suma += valor.to_i}
    total[producto] = suma
  end
  return total
end


def prod_x_tienda(hash)
  inventario =[]
  hash.each_value {|stock| inventario.push(stock)}
  inventario = inventario.transpose
end


def total_prod_tienda(hash)
  total = []
  prod_x_tienda(hash).each do |tienda|
    subtotal = 0
    tienda.each {|prod| prod != 'NR' ? subtotal += prod.to_i : 0}
    total.push(subtotal)
  end
  return total
end


def prod_NR(hash)
  total = []
  prod_x_tienda(hash).each do |tienda|
    subtotal = 0
    tienda.each {|prod| prod == 'NR' ? subtotal += 1 : 0}
    total.push(subtotal)
  end
  return total
end


def productos_bajo_stock(hash, umbral)
  productos = total_prod(hash)
  productos.reject! {|key, value| value.to_i > umbral}
  return productos
end


def ingresar_producto(str, archivo)
  begin
    file = File.open(archivo, 'a')
    file.puts "#{str}"
    file.close
  rescue
    return false
  else
    return true
  end
end

opt = 0
until opt == 6
  puts "\n\nIngresa una opcion [1-5], [6] para salir:"
  puts '[1] Cantidad de productos existentes'
  puts '[2] Buscar producto x nombre'
  puts '[3] Productos no registrados'
  puts '[4] Productos bajo stock'
  puts '[5] Registrar un nuevo producto'
  puts "[6] Salir\n\n"
  print ">"


  opt = gets.chomp.to_i
  hash = read_file('inventario.txt')

  case opt
    when 1
      opt2 = 0
      until opt2 == 4
        puts "\n\nCantidad de productos existentes"
        puts '[1] Existencia por productos'
        puts '[2] Existencia total por tienda'
        puts '[3] Existencia total en todas las tiendas'
        puts '[4] Volver al menú anterior'
        print ">"

        opt2 = gets.chomp.to_i

        case opt2
          when 1
            puts "Total de productos #{total_prod(hash)}"
            pausa()

          when 2
            puts "Total de productos por tienda #{total_prod_tienda(hash)}"
            pausa()
          when 3
            puts "Existencia total en todas las tiendas #{total_prod_tienda(hash).sum}"
            pausa()
          when 4
            break
          else
            puts 'La opción que ingresaste no es válida'
            pausa()
        end
      end

    when 2
      puts "Ingresa el nombre del producto:"
      print '>'
      prod = gets.chomp
      puts "El total de #{prod} es #{total_prod(hash)[prod]}"
      pausa()
    when 3
      puts "El total de productos No Registrados (NR) por tienda es: #{prod_NR(hash)}"
      pausa()
    when 4
      puts "Ingresa el umbral de stock:"
      print '>'
      umbral = gets.chomp.to_i
      puts "Los productos bajo el umbral son #{productos_bajo_stock(hash, umbral)}"
      pausa()
    when 5
      puts "Ingresa Producto"
      prod = gets.chomp
      puts "Ingresa Valor Bodega 1"
      vb1 = gets.chomp
      puts "Ingresa Valor Bodega 2"
      vb2 = gets.chomp
      puts "Ingresa Valor Bodega 3"
      vb3 = gets.chomp
      prod = prod + ', ' + vb1 + ', ' + vb2 + ', ' + vb3
      puts ingresar_producto(prod, 'inventario.txt') ? 'Producto ingresado' : 'No fue posible ingresar el producto'
      pausa()
    when 6
      puts "designed in Labs"
      break
    else
      puts 'La opción que ingresaste no es válida'
      pausa()
    end
end
