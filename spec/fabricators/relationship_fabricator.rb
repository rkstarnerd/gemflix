Fabricator(:relationship) do
  follower { Faker::Name.name }
  leader   { Faker::Name.name }    
end