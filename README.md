# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

# Running a race

* (Empty database -> delete db/development.sqlite3, rake db:create, rake db:migrate)

* Import runners from registrations

	heroku run rails c (navigeist-events)
	
	bundle exec rails c
	
	runner_sync.rb mukaan juoksijat kantaan
	
* bundle exec rails s -b 0.0.0.0

	start timer @ localhost:3000/timers
	
	take times
	
	insert names @ ip:3000/timers/1/results
	
* bundle exec rails c
  - results_sync mukaan

* random_runners mukaan arvontoja