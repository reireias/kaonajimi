# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Master::Job.create(name: 'エンジニア')
Master::Division.create(name: 'MIS事業部')
Master::Group.create(name: '調剤支援PF_G', division: Master::Division.take)
User.create(
  master_group: Master::Group.take,
  first_name: 'でも子',
  last_name: '顔馴染',
  nearest_station: 'JR荻窪駅',
  profile_text: '<h1>はじめまして！<h1><p>趣味はサウナです！<p>',
  email: 'sample@example.com',
  password: 'Password',
  password_confirmation: 'Password'
)
UserJob.create(user: User.take, master_job: Master::Job.take)
UserTag.create(title: 'sample', description: 'tag description')
UserTagging.create(user_tag: UserTag.take, user: User.take)
UserTagHistory.create(tag: UserTag.take, user: User.take, status: :add)
UserTagHistory.create(tag: UserTag.take, user: User.take, status: :remove)
