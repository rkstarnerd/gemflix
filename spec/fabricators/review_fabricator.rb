Fabricator(:review) do
  rating { (1..5).to_a.sample }
  description { Faker::Lorem.paragraph(1) }
end