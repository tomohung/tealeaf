#scope.rb

arr = [1, 2, 3]
a = 3 #variable is initialize in the outer scope

for i in arr do
  a = 5
end

puts a
