Community.destroy_all
User.destroy_all

puts "CREATE GENDERS"
%W( Female Male ).each do |name|
	Gender.create(name: name)
end

puts "CREATE ORIENTATIONS"
lgbtq = Orientation.create(name: "LGBTQ")
%W( Heterosexual Gay Lesbian Bisexual Transsexual ).each do |name|
	orientation = Orientation.create(name: name)
	# lgbtq.communities << orientation unless lgbtq.communities.include?(orientation)
end

puts "CREATE RELIGIONS"
%W( Christian Muslim Hindu Buddhist Sikh Jewish Baha'i Atheist Agnostic ).each do |name|
	Religion.create(name: name)
end

puts "CREATE EMPLOYERS"
%W( Google Apple Facebook Twitter LinkedIn Github #{'Major League Baseball'} #{'New York Yankees'} #{'Teach for America'} #{'KIPP Public Charter Schools'} IBM ).each do |name|
	Employer.create(name: name)
end

puts "CREATE USERS"
100.times do
	user = User.create(
		email: Faker::Internet.email,
		password: Devise.friendly_token,
		name: Faker::Name.first_name + " " + Faker::Name.last_name,
		communities: [Gender.all.sample, Orientation.all.sample, Religion.all.sample, Employer.all.sample]
	)
end