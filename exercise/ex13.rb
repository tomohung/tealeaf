contact_data = [["joe@email.com", "123 Main st.", "555-123-4567"],
            ["sally@email.com", "404 Not Found Dr.", "123-234-3454"]]

contacts = {"Joe Smith" => {}, "Sally Johnson" => {}}

contact_data.each do |data|

  contacts.each do |k, v|
    name = k.split
    if data[0].upcase.start_with?(name[0].upcase)
      contacts[k][:email] = data[0]
      contacts[k][:address] = data[1]
      contacts[k][:phone] = data[2]
    end
  end
end


puts contacts["Joe Smith"][:email]
puts contacts["Sally Johnson"][:phone]
