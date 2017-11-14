def escribir_index(st1, st2)
  file = File.open('index.html', 'w')
  file.puts("<HTML>")
  file.puts("<BODY>")
  file.puts("<p>#{st1}</p>")
  file.puts("<p>#{st2}</p>")
  file.puts("</BODY>")
  file.puts("</HTML>")
  file.close
end

puts 'ingresa st1: '
st1 = gets.chomp
puts 'ingresa st2: '
st2 = gets.chomp
escribir_index(st1, st2)
