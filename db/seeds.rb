# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#

user = User.find_or_create_by!( email: 'john.doe@example.com') do |user|
  user.password =  'changeme123'
  user.password_confirmation = 'changeme123'
end

tracker = user.trackers.find_or_create_by!(name: 'Body Measurements')

%W(arms calves chest forearms height hips neck shoulders thighs waist weight bodyfat).each do |type|
  tracker.measurement_types.find_or_create_by!(name: type)
end
