# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(user_name: 'Ryan')
User.create(user_name: 'Corey')
User.create(user_name: 'Jeff')
User.create(user_name: 'Will')
User.create(user_name: 'Tommy Lee Jones')

Poll.create(title: "Candy Curiosity", author_id: 5)

Question.create(
  text: "How many licks does it take to get to the center of a Tootsie-Pop(tm)?",
  poll_id: 1
)

AnswerChoice.create(text: 'One...', question_id: 1)
AnswerChoice.create(text: 'Two...', question_id: 1)
AnswerChoice.create(text: 'Three!', question_id: 1)

Response.create(answer_choice_id: 1, user_id: 1)
Response.create(answer_choice_id: 1, user_id: 2)
Response.create(answer_choice_id: 2, user_id: 3)
Response.create(answer_choice_id: 3, user_id: 4)
Response.create(answer_choice_id: 3, user_id: 5)