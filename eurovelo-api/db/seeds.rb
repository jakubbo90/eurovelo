countries = ['Poland', 'Germany', 'Denmark', 'Sweden']
#['Poland', 'Germany', 'Denmark', 'Sweden', 'Finland', 'Russia', 'Estonia', 'Lithuania', 'Latvia']
countries.each do |country|
  Country.find_or_create_by(name: country)
end

regions = [
  {name: 'Pomorskie', country_id: 1}, {name: 'Zachodniopomorskie', country_id: 1}, 
  {name: 'Meckleburg-Vorpommern', country_id: 2}, {name: 'Schleswig-Holstein', country_id: 2},
  {name: 'Sjaelland', country_id: 3}, {name: 'Syddanmark', country_id: 3}, {name: 'Midtjylland', country_id: 3}, {name: 'Hovedstand', country_id: 3}, {name: 'Borholm', country_id: 3},
  {name: 'Norrbotten', country_id: 4}, {name: 'Vasterbotten', country_id: 4}, {name: 'Vasternorrland', country_id: 4}, {name: 'Gavleborg', country_id: 4},
  {name: 'Uppsala', country_id: 4}, {name: 'Stockholm', country_id: 4}, {name: 'Sodermanland', country_id: 4}, {name: 'Ostergotland', country_id: 4},
  {name: 'Kalmar', country_id: 4}, {name: 'Karlskrona', country_id: 4}, {name: 'Skane', country_id: 4}
  # {name: 'Lappi', country_id: 5}, {name: 'Pohjois-Pohjanmaa', country_id: 5}, {name: 'Pohjanmaa', country_id: 5}, {name: 'Satakunta', country_id: 5},
  # {name: 'Keski-Pohjanmaa', country_id: 5}, {name: 'Varsinais-Suomi', country_id: 5}, {name: 'Etelä-Karjala', country_id: 5}, {name: 'Uusimaa', country_id: 5}, {name: 'Kymenlaakso', country_id: 5},
  # {name: 'Leningrad Oblast (Ленингра́дская о́бласть)', country_id: 6}, {name: 'Kaliningrad Oblast (Калинингра́дская о́бласть)', country_id: 6},
  # {name: 'Ida-Viru maakond', country_id: 7}, {name: 'Lääne-Viru maakond', country_id: 7}, {name: 'Harju maakond', country_id: 7}, {name: 'Lääne maakond', country_id: 7}, {name: 'Pärnu maakond', country_id: 7},
  # {name: 'Limbažu rajons', country_id: 8}, {name: 'Rīga un Rīgas rajons', country_id: 8}, {name: 'Tukuma rajons', country_id: 8}, {name: 'Talsu rajons', country_id: 8}, {name: 'Ventspils rajons', country_id: 8}, {name: 'Liepāja un Liepājas reģions', country_id: 8},
  # {name: 'Klaipėda', country_id: 9}, {name: 'Klaipėdos apskritis', country_id: 9}
  ]
regions.each do |region|
  Region.find_or_create_by(region)
end


main_categories = ['Explore', 'Things to do', 'Plan your Trip']

main_categories.each do |category|
  MainCategory.find_or_create_by(name: category)
end

sub_categories = [
  {name: 'World heritage (by UNESCO)', parent_id: 1}, {name: 'Cultural heritage', parent_id: 1}, {name: 'Maritime Culture', parent_id: 1}, {name: 'Natural heritage', parent_id: 1}, 
  {name: 'Rural landscapes', parent_id: 1}, {name: 'Biking around Baltic', parent_id: 1},
  {name: 'Activities', parent_id: 2}, {name: 'Eating and drinking', parent_id: 2}, {name: 'Art and culture', parent_id: 2}, {name: 'Activities for kids', parent_id: 2}, {name: 'Other Activities', parent_id: 2}, 
  {name: 'Touristic information', parent_id: 3}, {name: 'Public transport', parent_id: 3}, {name: 'Accommodation', parent_id: 3}, {name: 'Bicycle rentals', parent_id: 3}, {name: 'Bicycle parking spacer', parent_id: 3}
  ]

sub_categories.each do |sub_category|
  MainCategory.find_or_create_by(sub_category)
end
  
sub_sub_categories = [
  {parent_id: 5, names: ['Museum', 'Castle', 'Architectural Monuments', 'Urban heritage', 'Historical treasure', 'Sacred Monument', 'Monument', 'Fortification and military', 'Technical monuments', 'Other cultural heritage object']},
  {parent_id: 6, names: ['Shipwrecks', 'Lighthouses', 'Fishing Harbours', 'Tall And Battle Ships', 'Other maritime culture object']},
  {parent_id: 7, names: ['Coastline', 'Beach', 'National Park', 'Natural Reserve', 'Landscape Park', 'Zoo or botanical garden', 'Vista Point', 'sea sight', 'Lake', 'River', 'Underground route', 'Other natural heritage object']},
  {parent_id: 8, names: ['Village', 'Forest', 'Regional landscapes', 'Other Rural Landspace object ']},
  
  {parent_id: 10, names: ['Bicycling', 'In and on the water', 'Nordic walking', 'Other Activities']},
  {parent_id: 11, names: ['Regional Cusine', 'Restaurant', 'Pub', 'Coffee shop', 'Other eating and drinking object']},
  {parent_id: 12, names: ['Festival', 'Exhibition', 'Event', 'Other art and cultrure object']},
  {parent_id: 13, names: ['Playground', 'Other Activities for kids objects']},
  
  {parent_id: 16, names: ['Train', 'Bus and tram', 'Water transport', 'Other Public transport']},
  {parent_id: 17, names: ['Hotel', 'Motel', 'Guesthouse', 'Camping, campsite', 'Hostel, youth hostel', 'Guest rooms, lodgings', 'Other Accommodation object']}
  ]

sub_sub_categories.each do |sub_sub_category|
  sub_sub_category[:names].each do |name|
    MainCategory.find_or_create_by(parent_id: sub_sub_category[:parent_id], name: name)
  end
end

[1, 2, 3].each do |id|
  MainCategory.find(id).update_attribute(:level, 0)
end

(4..19).to_a.each do |id|
  MainCategory.find(id).update_attribute(:level, 1)
end

main_count = MainCategory.all.count
(20..main_count).to_a.each do |id|
  MainCategory.find(id).update_attribute(:level, 2)
end

trail_categories = ['Bike trails', 'Hiking trails', 'Nordic walking trails', 'Horse trails', 'Canoe trails', 'Cultural trails']

trail_categories.each do |trail|
  TrailCategory.find_or_create_by(name: trail, level: 0)
end

trail_subcategories = ['eurovelo routes', 'regional routes', 'country routes']

trail_subcategories.each do |subtrail|
  TrailCategory.find_or_create_by(name: subtrail, parent_id: TrailCategory.where(name: "Bike trails").take.id, level: 1)  
end

category_descriptions = ["Main Page EV10", "Poland", "Germany", "Denmark", "Sweden", "Explore", "Things to do", "Plan your Trip"]
#["Main Page – opis główny EV10", "Poland", "Germany", "Denmark", "Sweden", "Finland", "Russia", "Estonia", "Latvia", "Lithania", "Explore", "Things to do", "Plan your Trip"]
if Rails.env.production?
  category_descriptions.each do |cat|
    CategoryDescription.new(user_id: 1, name: cat).save(validate: false)
  end
else
  category_descriptions.each do |cat|
    CategoryDescription.new(user_id: 1, name: cat, title: Faker::Lorem.sentence(1), short_desc: Faker::Lorem.sentence(3), long_desc: Faker::Lorem.paragraph(3, false, 4)).save(validate: false)
    p = CategoryDescription.last
    Picture.create(source: Faker::Avatar.image, picturable_type: "CategoryDescription", picturable_id: p.id, main: true)
  end
end

PasswordExpiration.create(expiration_date: Date.today+30.days, period_in_days: 40)

if Rails.env.production?
  u1 = User.create(first_name: "Tomasz", last_name: "Legutko", email: "superadmin@admin.com", password: "Hand2band$", confirmed_at: DateTime.now, role: "super_admin", region_id: rand(1..Region.all.count), company: Faker::Company.name, phone: Faker::PhoneNumber.phone_number)
  u1.add_role "super_admin"
else
  if User.all.count < 2
    u1 = User.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: "superadmin@admin.com", password: "Hand2band$", confirmed_at: DateTime.now, role: "super_admin", region_id: rand(1..Region.all.count), company: Faker::Company.name, phone: Faker::PhoneNumber.phone_number)
    u1.add_role "super_admin"
    u2 = User.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: "localadmin@admin.com", password: "Hand2band$", confirmed_at: DateTime.now, role: "local_admin", region_id: rand(1..Region.all.count), company: Faker::Company.name, phone: Faker::PhoneNumber.phone_number, parent_id: 1)
    u2.add_role "local_admin"
    u3 = User.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: "author@admin.com", password: "Hand2band$", confirmed_at: DateTime.now, role: "author", region_id: rand(1..Region.all.count), company: Faker::Company.name, phone: Faker::PhoneNumber.phone_number, parent_id: 1)
    u3.add_role "author"
    u4 = User.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: "local1admin@admin.com", password: "Hand2band$", confirmed_at: DateTime.now, role: "local_admin", region_id: 2, company: Faker::Company.name, phone: Faker::PhoneNumber.phone_number, parent_id: 1)
    u4.add_role "local_admin"
    u5 = User.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: "author1@admin.com", password: "Hand2band$", confirmed_at: DateTime.now, role: "author", region_id: 2, company: Faker::Company.name, phone: Faker::PhoneNumber.phone_number, parent_id: 1)
    u5.add_role "author"
    u6 = User.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: "local2admin@admin.com", password: "Hand2band$", confirmed_at: DateTime.now, role: "local_admin", region_id: 3, company: Faker::Company.name, phone: Faker::PhoneNumber.phone_number, parent_id: 1)
    u6.add_role "local_admin"
    u7 = User.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: "author2@admin.com", password: "Hand2band$", confirmed_at: DateTime.now, role: "author", region_id: 3, company: Faker::Company.name, phone: Faker::PhoneNumber.phone_number, parent_id: 1)
    u7.add_role "author"
  end
  
  if Place.all.count < 1
    35.times do |i|
      user = User.find(rand(1..User.all.count))
      Place.new(name: Faker::University.name, short_desc: Faker::Lorem.sentence(3), long_desc: Faker::Lorem.paragraph(3, false, 4), latitude: rand(11.2...76.9), 
      longitude: rand(11.2...76.9), region_id: user.region_id, category_id: rand(20..main_count), user_id: user.id, author: user.first_name + ' ' + user.last_name, created_at: rand(10.days).seconds.ago, updated_at: rand(10.days).seconds.ago).save(validate: false)
      
      p = Place.last
      Video.create(title: Faker::Movie.quote, link: Faker::Internet.url, videoable_type: "Place", videoable_id: p.id)
      Identity.create(link: Faker::Internet.url, provider: "Facebook", place_id: p.id)
      Address.create(street: Faker::Address.street_name, street_number: Faker::Address.building_number, city: Faker::Address.city, postcode: Faker::Address.postcode, phone: Faker::PhoneNumber.phone_number, 
        cellphone: Faker::PhoneNumber.cell_phone, email: Faker::Internet.email, link: Faker::Internet.url, addressable_type: "Place", addressable_id: p.id)
      Picture.create(source: Faker::Avatar.image, picturable_type: "Place", picturable_id: p.id, main: true)
    end
  end  
  if Alert.all.count < 2
    35.times do |i|
      user = User.find(rand(1..User.all.count))
      Alert.new(user_id: user.id, author: user.first_name + ' ' + user.last_name, region_id: user.region_id, name: Faker::Commerce.department, description: Faker::Lorem.sentence(3), latitude: rand(11.2...76.9), 
      longitude: rand(11.2...76.9), time_from: (Date.today - 5.days), time_to: (Date.today + 5.days), created_at: rand(10.days).seconds.ago, updated_at: rand(10.days).seconds.ago).save(validate: false)
      p = Alert.last
      Address.create(city: Faker::Address.city, addressable_type: "Alert", addressable_id: p.id)
      Picture.create(source: Faker::Avatar.image, picturable_type: "Alert", picturable_id: p.id, main: true)
    end
  end
  
  if Trail.all.count < 2
    35.times do |i|
      user = User.find(rand(1..User.all.count))
      Trail.new(user_id: user.id, author: user.first_name + ' ' + user.last_name, name: Faker::Commerce.department, short_desc: Faker::Lorem.sentence(3), long_desc: Faker::Lorem.paragraph(3, false, 4), 
      distance: rand(11.2...876.9), created_at: rand(10.days).seconds.ago, updated_at: rand(10.days).seconds.ago, category_id: TrailCategory.all.pluck(:id).sample, region_id: user.region_id).save(validate: false)
      p = Trail.last
      Video.create(title: Faker::Movie.quote, link: Faker::Internet.url, videoable_type: "Trail", videoable_id: p.id)
      Picture.create(source: Faker::Avatar.image, picturable_type: "Trail", picturable_id: p.id, main: true)
    end
  end

  Place.all.each do |place|
    if !place.main_category.parent.parent.nil?
      PlaceCategory.find_or_create_by(place_id: place.id, category_id: place.main_category.parent.parent.id)
    else
      PlaceCategory.find_or_create_by(place_id: place.id, category_id: place.main_category.parent.id)
    end
  end
  
  unless Rails.env.production?
    Picture.update_all(main: true)
  end
end