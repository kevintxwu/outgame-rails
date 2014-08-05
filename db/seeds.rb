def create_events
  Event.create! name: 'Non-elimination Tour...',
                description: 'This is a tournament of 30 people and it will be really cool and fun! Trust me you\'ll like it.',
                event_type: 'Netrunner', 
                date: '2014-09-22',
                bracket: 'Non-elimination',
                image: 'netrunner.jpg'

  Event.create! name: 'Weekly Draft',
                description: 'Duels of the Planeswalkers Magic The Gathering draft for up to 16 people.',
                event_type: 'Magic The Gathering',
                date: '2014-09-25',
                bracket: 'Non-elimination',
                image: 'mtg.jpg'

  Event.create! name: 'Tournament',
                description: 'This is a tournament limited to 16 people. Now that you\'ve all gotten used to the game let\'s see who\'s...',
                event_type: 'Netrunner',
                date: '2014-10-02',
                bracket: 'Non-elimination',
                image: 'netrunner.jpg'

end

def create_users(event)
  event.users = 1.upto(7).map do |n|
    Player.create!  name: "Player #{n}",
                    password: 'password',
                    email: "player#{n}@outgame.org"
  end
end


create_events
create_users(Event.last)
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

