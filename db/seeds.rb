# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Video.create(title: "Breaking Bad", description: "A chemistry teacher diagnosed with a terminal lung cancer, teams up with his former student, Jesse Pinkman, to cook and sell crystal meth.", small_cover_url: "/tmp/break_bad.jpg", large_cover_url: "/tmp/break_bad_large.jpg")

Video.create(title: "Sherlock", description: "A modern update finds the famous sleuth and his doctor partner solving crime in 21st century London.", small_cover_url: "/tmp/sherlock.jpg", large_cover_url: "/tmp/sherlock_large.jpg")

Video.create(title: "The Matrix", description: "A computer hacker learns from mysterious rebels about the true nature of his reality and his role in the war against its controllers.", small_cover_url: "/tmp/the_matrix.jpg", large_cover_url: "/tmp/the_matrix_large.jpg")

Video.create(title: "The Dark Knight", description: "When the menace known as the Joker wreaks havoc and chaos on the people of Gotham, the caped crusader must come to terms with one of the greatest psychological tests of his ability to fight injustice.", small_cover_url: "/tmp/dark_knight.jpg", large_cover_url: "/tmp/dark_knight_large.jpg")

gemille  = User.create(name: "Gemille Ford", password: "password", email: "gemille@example.com")
Review.create(user_id: gemille.id, video_id: 2, rating: 4, description: "This is an excellent whodunit. Instant classic. Looking forward to next season!")
Review.create(user_id: gemille.id, video_id: 2, rating: 3, description: "There is just too much time in between seasons. Womp!")