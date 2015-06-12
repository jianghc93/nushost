# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Event.create(title: 'NUS Host Launch Party',
             host: 'FatBoys',
             description: 'Open Party to celebrate the completion of Orbital Milestone 1',
             summary: 'Orbital milestone party',
             date: Date.new(2015, 6, 14),
             time: Time.current())