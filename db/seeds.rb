# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

unless Rails.env == 'production'
  #Create basic user in non-production environments
  genesisUser = User.find_or_initialize_by(email: 'gametracker@example.com')
  genesisUser.password = 'gametracker'
  genesisUser.password_confirmation = 'gametracker'
  genesisUser.save!
end