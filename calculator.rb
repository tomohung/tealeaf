# calculator app
  
# 1. user input the calculate number and operator
# 2. limit to only "Add", "Substract", "Multiply", "Divide"
# 3. input numbers and operators, do math calculating and output result
# 4. ask if user want do again

require 'pry'

def say(msg)
  puts "=> #{msg}"
end

def output_result(msg)
  puts "@@@@@ #{msg} @@@@@"
  puts "\n"
end

def numeric?(lookAhead)
  lookAhead =~ /[[:digit:]]/
end

def do_calculation
  
  say "Input your first number:"
  first_number = gets.chomp
  return nil, nil if !numeric?(first_number)

  say "Input your operator [+-*/] :"
  operator = gets.chomp
  test_operator = operator =~ /[\+\-\*\/]/ 
  
  return nil, nil if test_operator == false

  say "Input your second number:"
  second_number = gets.chomp
  return nil, nil if !numeric?(second_number) 

  input = "#{first_number} #{operator} #{second_number}"

  case operator
  when "+"
    result = first_number.to_i + second_number.to_i
  when "-"
    result = first_number.to_i - second_number.to_i
  when "*"
    result = first_number.to_i * second_number.to_i
  when "/"
    result = first_number.to_f / second_number.to_i
  end

  return input, result
end

begin
  say "A simple calculator for two number to do [+ - * /] calculation"
  input, result = do_calculation

  if result == nil
    output_result "[Error] In-correct calculation!"
  else
    output_result " #{input} = #{result} "
  end

  say "Want to do calculation again?"
  say "Y) Yes to Continue. N) Any key to Exit."
end while gets.chomp.upcase == 'Y'