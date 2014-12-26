arr = ['snow', 'winter', 'ice', 'slippery', 'salted roads', 'white trees']

arr2 = Array.new(arr)

puts "arr"
puts arr
arr.delete_if { |word| word.start_with?("s")}
puts arr

arr2.delete_if { |word| word.start_with?("w" ,"s")}
puts "arr2"
puts arr2