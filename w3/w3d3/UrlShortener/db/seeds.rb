# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(email: 'rglassett@gmail.com')
User.create(email: 'caslyn@gmail.com')
User.create(email: 'ned@appacademy.io')
User.create(email: 'cj@appacademy.io')
User.create(email: 'chuck@norris.edu')

ShortenedUrl.create_for_user_and_long_url!(User.first, 'http://ryanglassett.io')
ShortenedUrl.create_for_user_and_long_url!(User.all[1], 'http://caslyn.io')
ShortenedUrl.create_for_user_and_long_url!(User.all[2], 'http://chucknorris.io')
ShortenedUrl.create_for_user_and_long_url!(User.all[4], 'http://cjsloveshack.net')
# ShortenedUrl.create_for_user_and_long_url!(User.all[4], 'http://cjsoveshack.net')
# ShortenedUrl.create_for_user_and_long_url!(User.all[4], 'http://cjsveshack.net')
# ShortenedUrl.create_for_user_and_long_url!(User.all[4], 'http://cjseshack.net')
# ShortenedUrl.create_for_user_and_long_url!(User.all[4], 'http://cjsshack.net')
# ShortenedUrl.create_for_user_and_long_url!(User.all[4], 'http://cjshack.net')
# ShortenedUrl.create_for_user_and_long_url!(User.all[4], 'http://cjsack.net')
# ShortenedUrl.create_for_user_and_long_url!(User.all[4], 'http://cjsck.net')
# ShortenedUrl.create_for_user_and_long_url!(User.all[4], 'http://cjsk.net')

Visit.create(visitor_id: 1, url_id: 1)
Visit.create(visitor_id: 2, url_id: 1)
Visit.create(visitor_id: 5, url_id: 2)
Visit.create(visitor_id: 3, url_id: 1)
Visit.create(visitor_id: 1, url_id: 2)
Visit.create(visitor_id: 4, url_id: 1)
Visit.create(visitor_id: 1, url_id: 2)
Visit.create(visitor_id: 5, url_id: 2)
Visit.create(visitor_id: 2, url_id: 2)

TagTopic.create(tag_topic: 'Sports')
TagTopic.create(tag_topic: 'News')
TagTopic.create(tag_topic: 'Entertainment')
TagTopic.create(tag_topic: 'Weather')
TagTopic.create(tag_topic: 'Foreign Policy')
TagTopic.create(tag_topic: 'Time Wasting')
TagTopic.create(tag_topic: 'Chuck Norris')

Tagging.create(url_id: 3, tag_topic_id: 7)
Tagging.create(url_id: 1, tag_topic_id: 6)
Tagging.create(url_id: 3, tag_topic_id: 2)
Tagging.create(url_id: 3, tag_topic_id: 4)
Tagging.create(url_id: 2, tag_topic_id: 5)
Tagging.create(url_id: 2, tag_topic_id: 6)
Tagging.create(url_id: 2, tag_topic_id: 1)