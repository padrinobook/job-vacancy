# encoding: utf-8
FactoryGirl.define do
  sequence(:email){ |n| "matthias.guenther#{n}@wikimatze.de"}
  sequence(:name){ |n| "Matthias Günther #{n}"}

  factory :user do
    name
    email
    password "foobar"
    password_confirmation "foobar"
  end

  factory :job_offer do
    title       "Padrino Engineer   "
    location    "Berlin             "
    description "We want you ...    "
    contact     "recruter@awesome.de"
    time_start  "1/01/2013          "
    time_end    "01/03/2013         "
  end
end
