FactoryGirl.define do
  factory :user do
    name     "Testing User"
    email    "user@example.com"
    role     "admin"
    password "foobar"
    password_confirmation "foobar"
    status   true
  end


  # factory :location do
  #   address     "3rd Cross Road, Bangalore, Karnataka, India"
  #   topic_id "41"
  #   latitude "12.9715987"
  #   longitude "77.5945627"
  # end
end
