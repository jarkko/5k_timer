#from results
Runner.order("random()").first(30).each do |runner|
	puts runner.first_name << " " << runner.last_name
end; nil


# Heroku, from registrations
e = Event.last
#leg = e.legs.last
leg = e.legs.where(date: Date.today).last
leg.registrations.order("random()").first(30).each do |reg|
  puts reg.first_name + " " + reg.last_name + ", " + reg.bib_number.to_s
end; nil