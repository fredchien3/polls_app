# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

ActiveRecord::Base.transaction do
  User.destroy_all
  Poll.destroy_all
  Question.destroy_all
  AnswerChoice.destroy_all
  Response.destroy_all

  u1 = User.create!(username: 'fredchien3')
  u2 = User.create!(username: 'alio_olio')
  u3 = User.create!(username: 'jorsten_chorn')
  u4 = User.create!(username: 'dorwen_chorn')
  u5 = User.create!(username: 'chorsten_chorn')

  p1 = Poll.create!(title: 'Movies poll', author: u5)

  q1 = Question.create!(text: 'Who is your favorite Marvel superhero?', poll: p1)
  ac1 = AnswerChoice.create!(text: 'Captain America', question: q1)
  ac2 = AnswerChoice.create!(text: 'Iron Man', question: q1)
  ac3 = AnswerChoice.create!(text: 'Thor', question: q1)
  ac4 = AnswerChoice.create!(text: 'Hulk', question: q1)

  q2 = Question.create!(text: 'What is your favorite movie genre?', poll: p1)
  ac5 = AnswerChoice.create!(text: 'Rom Com', question: q2)
  ac6 = AnswerChoice.create!(text: 'Horror', question: q2)
  ac7 = AnswerChoice.create!(text: 'Action', question: q2)
  ac8 = AnswerChoice.create!(text: 'Animation', question: q2)

  r1 = Response.create!(respondent: u1, answer_choice: ac2)
  r2 = Response.create!(respondent: u1, answer_choice: ac7)
  r3 = Response.create!(respondent: u2, answer_choice: ac2)
  r4 = Response.create!(respondent: u2, answer_choice: ac8)
end