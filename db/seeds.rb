# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.destroy_all()
Profile.destroy_all()
Like.destroy_all()
Message.destroy_all()

PHOTOS = ['http://i.imgur.com/sciSQG3.jpg', 'http://i.imgur.com/BhqqCZG.jpg', 'http://i.imgur.com/FL1hyX8.jpg',
'http://i.imgur.com/OcrRV00.jpg', 'http://i.imgur.com/Fed3Qmu.jpg', 'http://i.imgur.com/BUPVDoX.jpg',
'http://i.imgur.com/PPAArko.jpg', 'http://i.imgur.com/uU2oxH1.jpg', 'http://i.imgur.com/TkdCEZB.jpg',
'http://i.imgur.com/SdCtKB8.jpg']

STYLES = ['Boxer', 'Wrestler', 'MMA Fighter', 'Other']

WEIGHT_CLASSES = ['Featherweight', 'Lightweight', 'Middleweight', 'Heavyweight']

BODY_TYPES = ['Tank', 'Flimsy', 'Built', 'Stacked', 'Jacked', 'Yoked']

GENDERS = ['Male', 'Female', 'Other']

User.create!(email: 'rhonda.rousey@strikeforce.net', username: 'rhonda.rousey', password: 'rhondapassword')

21.times do
	User.create!(email: Faker::Internet.email,
							 username: Faker::Internet.user_name, 
							 password: Faker::Internet.password)
end

22.times do |i|
	Profile.create!(user_id: User.all[i].id,
									self_summary: Faker::Lorem.paragraph,
									good_at: Faker::Lorem.paragraph,
									message_if: Faker::Lorem.paragraph,
									style: STYLES.sample,
									body_type: BODY_TYPES.sample,
									height: rand(200),
									weight: rand(200),
									weight_class: WEIGHT_CLASSES.sample,
									gender: GENDERS.sample,
									photo_url: PHOTOS.sample,
									birth_date: Faker::Time.between(60.years.ago, 20.years.ago).to_date,
									looking_for_wrestler: (rand(2) > 0),
									looking_for_boxer: (rand(2) > 0),
									looking_for_mma_fighter: (rand(2) > 0),
									looking_for_other_styles: (rand(2) > 0),
									looking_for_men: (rand(2) > 0),
									looking_for_women: (rand(2) > 0),
									looking_for_sparring_partner: (rand(2) > 0),
									looking_for_opponent: (rand(2) > 0)
									)
end

50.times do
	liker_id = User.all[rand(21)].id
	likee_id = User.all[rand(21)].id
	if !Like.find_by(liker_id: liker_id, likee_id: likee_id)
		Like.create!(liker_id: liker_id, likee_id: likee_id)
	end
end

150.times do
	Message.create!(sender_id: User.all[rand(21)].id, 
									recipient_id: User.all[rand(21)].id,
									body: Faker::Lorem.paragraph)
end