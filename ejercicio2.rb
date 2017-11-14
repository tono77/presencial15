def lineas_archivo()
  file = File.open('peliculas.txt', 'r')
  products = file.readlines
  file.close
  products.length
end



puts "El número de películas es #{lineas_archivo()}"
