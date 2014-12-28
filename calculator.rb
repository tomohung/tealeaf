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

def do_calculation(first_number, operator, second_number)

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
end

def check_input_number?(str)
  check = str =~ /[[:digit:]]/
  if check
    return true
  else
    say "Input Error"
    return false
  end
end

say "A simple calculator for two number to do [+ - * /] calculation"

begin

  begin
    say "Input your first number:"
    first_number = gets.chomp
  end until check_input_number?(first_number)

  begin
    say "Input your operator [+-*/] :"
    operator = gets.chomp
    test_operator = operator =~ /[\+\-\*\/]/ 
    say "Input Error" if !test_operator 
  end until test_operator 
  
  begin 
    say "Input your second number:"
    second_number = gets.chomp
  end until check_input_number?(second_number)

  input = "#{first_number} #{operator} #{second_number}"

  result = do_calculation(first_number, operator, second_number)

  output_result " #{input} = #{result} "

  say "Want to do calculation again?"
  say "Y) Yes to Continue. N) Any key to Exit."
end while gets.chomp.upcase == 'Y'