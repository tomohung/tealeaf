# calculator app
  
# 1. user input the calculate number and operator
# 2. limit to only "Add", "Substract", "Multiply", "Divide"
# 3. split numbers and operators, do math calculating and output result
# 4. ask if user want do again

def say(msg)
  puts "=> #{msg}"
end

def do_calculation(str)
  result = check_calculation_valid(str)
  return result if result == nil

  result = do_operator()

end

def check_calculation_valid(str)

end

def do_operator()

end

begin
  say "A calculator for +-*/"
  say "Input your calculation and press [ENTER] key:"
  result = do_calculation(gets.chomp)

  if result == nil
    say "[Error] In-correct calculation!"
  else
    say "Result = #{result}"
  end

  prints "\n"
  say "Want to do calculation again?"
  say "Y) Continue. N) Exit."
end while gets.chomp.upcase == 'Y'