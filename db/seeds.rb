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