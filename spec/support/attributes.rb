def movie_attributes(overrides = {})
  {title: "Iron Man",
   rating: "PG-13",
   total_gross: 318412101.00,
   description: "Tony Stark builds an armored suit to fight the throes of evil",
   released_on: "2008-05-02",
   duration: "130 minutes",
  director: "Jon",
  cast: "The award winning cast",
  image_file_name: "ironman.jpg"
  }.merge(overrides)
end

def review_attributes(overrides = {})
  {
    user_id: 1,
    stars: 3,
    comment: "I laughed, I cried, I spilled my popcorn!",
    movie_id: 1
  }.merge(overrides)
end

def user_attributes(overrides = {})
  {
    name: 'Adam',
    email: 'adam@example.com',
    password: 'secret',
    password_confirmation: 'secret',
    admin: false,
  }.merge(overrides)
end

def favourite_attributes(overrides = {})
  {
    user_id: 1,
    movie_id: 1,
  }.merge(overrides)
end
