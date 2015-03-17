# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(username: "rglassett")
User.create(username: "JJ")
User.create(username: "TheNotoriousBoris")
User.create(username: "bananaman")

Contact.create({ user_id: 1, name: "JJ B", email: "brujj77@gmail.com" } ) # => 1
Contact.create({ user_id: 1, name: "Barack Obama", email: "b@whitehouse.com"}) # => 2
Contact.create({ user_id: 2, name: "Boris", email: "boris@goldeneye.com"}) # => 3

ContactShare.create({contact_id: 1, user_id: 2})
ContactShare.create({contact_id: 2, user_id: 3})
ContactShare.create({contact_id: 3, user_id: 1})

ContactGroup.create({user_id: 1})
ContactGroup.create({user_id: 2})

GroupMembership.create({contact_id: 2, group_id: 1})
GroupMembership.create({contact_id: 3, group_id: 1})

GroupMembership.create({contact_id: 2, group_id: 2})
GroupMembership.create({contact_id: 1, group_id: 2})