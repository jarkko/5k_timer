# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_result_timer_session',
  :secret      => 'cf02448e2567594b02fd3b5682168f2ca1c5715c4ff035e18291d1273117562db6154a0ed268e9e1ebbafb48e8d7078c9eb1aaee37c4a06d1955421761d31bd2'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
