
a = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]


a.push(11)

a.unshift(0)

a.pop
a.push(3)

#before modified
puts "before modified"
a.each { |i| puts i }

#modifed
puts "after modified"
a.uniq! 

a.each { |i| puts i }