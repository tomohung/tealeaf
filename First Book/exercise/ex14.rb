contact_data = [["joe@email.com", "123 Main st.", "555-123-4567"],
            ["sally@email.com", "404 Not Found Dr.", "123-234-3454"]]

contacts = {"Joe Smith" => {}, "Sally Johnson" => {}}
fields = [:email, :address, :phone]


contacts.each do |k, v|
  contact_data.each do |data|

    name = k.split
    if data[0].upcase.start_with?(name[0].upcase)
      fields.each_with_index { |field, i| v[field] = data[i] }
    end
  end
end


puts contacts

