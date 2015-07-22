require 'rubygems'
require 'neo4j'

class Person
  include Neo4j::ActiveNode
  property :name
  property :age

end
session = Neo4j::Session.open(:embedded_db, '/server/ruby.db')
session.start
Neo4j::Transaction.run do
  Person.new(:name => "Ian Tracey", :age => 20)
end

