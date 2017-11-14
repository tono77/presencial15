def words_archivo(archivo)
  words = ""
  file = File.open(archivo, 'r')
  data = file.readlines.map(&:chomp)
  file.close
  words = 0
  data.each {|str| words += str.split.count}
  return words
end

def search_words_archivo(archivo, word)
  coincidencias = 0
  file = File.open(archivo, 'r')
  data = file.readlines.map(&:chomp)
  file.close
  data.each do |str|
    str.split(' ').each  {|palabra| coincidencias += 1 if palabra == word}
  end
  return coincidencias
end


puts "La cantidad total de palabras del archivo es: #{words_archivo("peliculas.txt")}"
p 'Ingresa la palabra a buscar: '
str = gets.chomp
puts "La cantidad total de #{str} en el archivo es: #{search_words_archivo("peliculas.txt", str)}"
