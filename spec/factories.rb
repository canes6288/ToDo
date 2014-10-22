FactoryGirl.define do
  factory :task do
    # Factory only needs what is required by your model for each task
    title   "Walk the dog"
  end

  sequence :name do |n|
    "Name#{n}"
  end

  sequence :email do |n|
    "email-#{n}@email.com"
  end


  factory :user do
    name
    email
    password              "foobar"
    password_confirmation "foobar"
  end
end
