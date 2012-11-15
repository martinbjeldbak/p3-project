FactoryGirl.define do
  factory :user do
    name "Martin Madsen"
    email "mabma11@student.aau.dk"
    password "foobar"
    password_confirmation "foobar"

    factory :admin do
      admin true
    end
  end
end