Event.destroy_all
User.destroy_all
RegisteredApplication.destroy_all 

admin = User.new(
  name:     'Admin User',
  email:    'admin@example.com',
  password: 'helloworld'
)
admin.skip_confirmation!
admin.save!

member = User.new(
  name:     'Member User',
  email:    'member@example.com',
  password: 'helloworld'
)
member.skip_confirmation!
member.save!

brad = User.new(
  name:     'brad',
  email:    'bradley.s.gohman@gmail.com',
  password: 'helloworld'
)
brad.skip_confirmation!
brad.save!


app1 = RegisteredApplication.create!(name: "bloccit", url: "https://bgohman-bloccit.herokuapp.com/", user_id: brad.id)
app2 = RegisteredApplication.create!(name: "blocmarks", url: "https://bgohman-blocmarks.herokuapp.com/", user_id: brad.id)
app3 = RegisteredApplication.create!(name: "blocipedia", url: "https://bgohman-blocipedia.herokuapp.com/", user_id: brad.id)
apps = RegisteredApplication.all

events = []
6.times do
  require 'Faker'
  events << Faker::Lorem.word
end

100.times do
  require 'Faker'
  Event.create!(
    name: events.sample,
    registered_application: apps.sample,
    created_at: Faker::Time.between(60.days.ago, Time.now, :all)
    )
end

 puts "Seed finished"
 puts "#{RegisteredApplication.count} applications created"
 puts "#{User.count} users created"
 puts "#{Event.count} events created"