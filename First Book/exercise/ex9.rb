h = {a: 1, b: 2, c: 3, d: 4}

puts h[:b]

h[:e] = 5

puts h[:e]

# h.select! { |k, v| v >= 3.5 }

h.delete_if {|k, v| v < 3.5 }

puts h