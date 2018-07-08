# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create([
                {first_name: 'Rubius', last_name: 'Hagrid', email: 'rubius@hogwarts.edu', password: 'harry',
                 contact_phone: '212-555-1212', street_address: 'Hogwarts Cottage 4', city: 'Hogsmeade', state: 'Wales', zip_code: '92501', role: :chef, latitude: 42.38, longitude: -71.2},
                {first_name: 'Severus', last_name: 'Snape', email: 'severus@hogwarts.edu', password: 'harry',
                 contact_phone: '212-555-1213', street_address: 'Basement 1', city: 'Hogsmeade', state: 'Wales', zip_code: '92503', role: :chef, latitude: 42.3736, longitude: -71.1097},
                {first_name: 'Jim', last_name: 'Bernstein', email: 'jim@excelsior.com', password: 'harry',
                 contact_phone: '212-555-1217', street_address: '1000 Massachusetts Ave.', city: 'Cambridge', state: 'MA', zip_code: '02138', role: :client, latitude: 42.375, longitude: -71.12},
                {first_name: 'Kerry', last_name: 'Cerulean', email: 'kerry@tiffin.com', password: 'harry',
                 contact_phone: '212-555-1218', street_address: '2020 Massachusetts Ave.', city: 'Cambridge', state: 'MA', zip_code: '02140', role: :chef, latitude: 42.1, longitude: -71.02},
                {first_name: 'Albus', last_name: 'Dumbledore', email: 'albus@hogwarts.edu', password: 'harry',
                 contact_phone: '212-555-1214', street_address: 'Tower Office 2', city: 'Hogsmeade', state: 'Wales', zip_code: '92504', role: :client, latitude: 42.5, longitude: -70.32},
                {first_name: 'Harry', last_name: 'Potter', email: 'harry@hogwarts.edu', password: 'harry',
                 contact_phone: '212-555-1215', street_address: 'Gryffindor Tower 3', city: 'Hogsmeade', state: 'Wales', zip_code: '92505', role: :client, latitude: 42.55, longitude: -71.343},
                {first_name: 'Ron', last_name: 'Weasley', email: 'ron@hogwarts.edu', password: 'harry',
                 contact_phone: '212-555-1216', street_address: 'Gryffindor Tower 3', city: 'Hogsmeade', state: 'Wales', zip_code: '92506', role: :client, latitude: 42.78, longitude: -69.69}
            ])

Certification.create([{name: 'ServSafe', authority: 'ServSafe', url: "https://www.servsafe.com/ServSafe-Manager/Get-Certified"},
                      {name: 'Kosher', authority: 'OK', url: "http://www.ok.org/"},
                      {name: 'Halal', authority: 'USA Halal Chamber of Commerce', url: "http://www.ushalalcertification.com/"}])

DietaryAccommodation.create([{name: 'vegetarian'}, {name: 'gluten free'}, {name: 'vegan'}, {name: 'kosher'}, {name: 'halal'}])

Cuisine.create([{name: 'Indian'}, {name: 'Chinese'}, {name: 'Mexican'}, {name: 'Italian'}, {name: 'American'}, {name: 'Middle Eastern'}])

Chef.create({user_id: User.find_by_email('rubius@hogwarts.edu').id,
              business_name: "Hagrid's Hot Dog Hut",
              business_description: "We make hot dogs out of all the magical beasts you can imagine!"}) do |chef|
  chef.cuisine << Cuisine.find_by_name('Indian')
  chef.cuisine << Cuisine.find_by_name('Middle Eastern')
  chef.dietary_accommodation << DietaryAccommodation.find_by_name('vegetarian')
  chef.dietary_accommodation << DietaryAccommodation.find_by_name('kosher')
  chef.certification << Certification.find_by_authority('OK')
end

Chef.create([{user_id: User.find_by_email('severus@hogwarts.edu').id, business_name: "Snape's Slightly Poisonous Potions",
              business_description: "Our potions are only slightly poisonous!"},
             {user_id: User.find_by_email('kerry@tiffin.com').id, business_name: "Kerry's Kitchen",
              business_description: "We serve up healthy meals for a variety of tastes and diets."}])

Meal.create([{chef: Chef.first, short_name: 'Chana Masala', description: 'Chickpeas in Masala sauce.'}]) do |meal|
  meal.cuisine << Cuisine.find_by_name('Indian')
  meal.dietary_accommodation << DietaryAccommodation.find_by_name('vegetarian')
end

Meal.create([{chef: Chef.first, short_name: 'Tofu Tacos', description: 'Tofu Tacos just like at Pancho Villa in the Mission.'}]) do |meal|
  meal.cuisine << Cuisine.find_by_name('Mexican')
  meal.dietary_accommodation << DietaryAccommodation.find_by_name('vegetarian')
end

Meal.create([{chef: Chef.first, short_name: 'Matzoh Ball Soup', description: 'Matzoh ball soup, perfect for Passover.  Mazel Tov!'}]) do |meal|
  meal.cuisine << Cuisine.find_by_name('Middle Eastern')
  meal.dietary_accommodation << DietaryAccommodation.find_by_name('kosher')
end