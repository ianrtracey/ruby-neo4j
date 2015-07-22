require 'bundler'
Bundler.setup
require 'neo4j'
#require 'sinatra'
require 'csv'

#set :haml, format: :html5
#set :port, 80 if Sinatra::Base.environment == 'production'


session = Neo4j::Session.open(:server_db, 'http://localhost:7474/', { basic_auth: { username: 'neo4j', password: 'Filly901secure'} })

class Person
  include Neo4j::ActiveNode

  property :name
  property :email
  property :gender
  property :is_az_student
  property :is_hs_student
  property :is_18_years_old
  property :school
  property :needs_travel
  property :first_hackathon
  property :experience
  property :hardware
  property :software
  property :virtual_reality
  property :wearables
  property :health
  property :sustainability
  property :drone_or_robotics
  property :printing
  property :web
  property :ios
  property :android
  property :other
  property :projects
  property :why_hack_arizona
  property :github
  property :linkedin
  property :website
  property :resume
  property :diet
  property :diet_description
end

#p = Person.create(:name => "Ian Tracey", :age => 20)

=begin name,email,male,female,not_male_female,is_az_student,is_hs_student,
	   is_18,school,needs_travel,first_hackathon,experience,hardware,software,
	   vr,wearables,health,sustainability,drone_or_robotics,
	   printing,web,ios,android,other,projects,why_hack_arizona,github,
	   linkedin,website,resume,teammate1,teammate2l,teammate3,tshirt,diet,
	   diet_description,code_of_conduct
=end


data = CSV.read("data/2015_registration.csv", { encoding: "iso-8859-1:UTF-8", headers: true, header_converters: :symbol, converters: :all})
hashed_data = data.map { |d| d.to_hash }
hashed_data.each do |reg|
	  if !reg[:male].nil?
	  	gender = "Male"
	  elsif !reg[:female].nil?
	  	gender = "Female"
	  else
	  	gender = "Not Associated"
	  end
	  if reg[:is_az_student].to_i == 1
	  	is_az_student = true
	  else
	  	is_az_student = false
	  end
	  if reg[:is_hs_student].to_i == 1
	  	is_hs_student = true
	  else
	  	is_hs_student = false
	  end
	  if reg[:first_hackathon].to_i == 1
	  	first_hackathon = true
	  else
	  	first_hackathon = false
	  end
	  if reg[:github] == "http://"
	    github = ""
	  end
	  if reg[:website] == "http://"
	  	website = ""
	  end
	  if reg[:linkedin] == "http://"
	  	linkedin = ""
	  end
	  Person.create(name: reg[:name], email: reg[:email],gender: gender,
	  				is_az_student: reg[:is_az_student], is_hs_student: reg[:is_hs_student],
	  				is_18_years_old: reg[:is_18_years_old], school: reg[:school],
	  				needs_travel: reg[:needs_travel], first_hackathon: reg[:first_hackathon],
	  				experience: reg[:experience], hardware: reg[:hardware], software: reg[:software],
	  				virtual_reality: reg[:vr], wearables: reg[:wearables],
	  				health: reg[:health], sustainability: reg[:sustainability], drone_or_robotics: reg[:drone_or_robotics],
	  				printing: reg[:printing], web: reg[:web], ios: reg[:ios], android: reg[:android],
	  				other: reg[:other], projects: reg[:projects], why_hack_arizona: reg[:why_hack_arizona],
	  				github: reg[:github], linkedin: reg[:linkedin], website: reg[:website],
	  				resume: reg[:resume], diet: reg[:diet], diet_description: reg[:diet_description])
end


