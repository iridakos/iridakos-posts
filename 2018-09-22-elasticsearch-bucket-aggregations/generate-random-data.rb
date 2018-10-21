require 'json'

cities = ['Athens', 'London', 'Berlin', 'Tokyo', 'New York', 'Amsterdam', 'Oslo', 'Paris', 'Barchelona', 'Madrid', 'Prague', 'Warsaw', 'Budapest', 'San Franscisco', 'Melbourne', 'Chicago']
occupations = ['Hairdresser', 'Clinical Laboratory Technician', 'Fitness Trainer', 'Reporter', 'Marketing Manager', 'Microbiologist', 'Farmer', 'Librarian', 'Historian', 'Software Developer', 'Dancer', 'Statistician', 'Artist', 'Dentist', 'Photographer', 'Maintenance & Repair Worker', 'Environmental scientist', 'Editor']
pet_kinds = ['Cat', 'Dog', 'Bird', 'Rabbit', 'Hamster']
pet_names = ['Irida', 'Phoebe', 'Rosie', 'Morgan', 'Henry', 'Grace', 'Frankie', 'Joey', 'Monica', 'Sophia', 'Hourhouris', 'Tsirko', 'Casper', 'Nino', 'Cedar', 'Charlotte']
office_types = ['primary', 'secondary']
citizen_ages = [20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80]
pet_ages = (1..15).to_a

city_offices = []

cities.each do |city|
  Random.rand(4..8).times do |office_index|
    city_office = { city: city,
                    office_type: office_types.sample,
                    citizens: [] }

    Random.rand(20..50).times do |citizen_index|
      citizen = {
        occupation: occupations.sample,
        age: citizen_ages.sample,
        pets: []
      }

      citizen_pet_names = pet_names.dup

      Random.rand(1..5).times do |pet_index|
        pet_name = citizen_pet_names.sample
        citizen_pet_names.delete(pet_name)

        pet = {
          kind: pet_kinds.sample,
          name: pet_name,
          age: pet_ages.sample
        }

        citizen[:pets] << pet
      end

      city_office[:citizens] << citizen
    end

    city_offices << city_office
  end
end

File.open("sample-data.json", 'w') do |file|
  city_offices.each do |city_office|
    file.puts({ "index": { "_index": "city_offices", "_type": "_doc" } }.to_json)
    file.puts city_office.to_json
  end
end
