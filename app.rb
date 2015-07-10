require 'bundler'
Bundler.setup
require 'neo4j'
require 'sinatra'

set :haml, format: :html5
set :port, 80 if Sinatra::Base.environment == 'production'


Neo4j::Session.open(:server_db, 'http://localhost:7474/')