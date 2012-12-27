# encoding: utf-8
FactoryGirl.define do |u|

  factory :user do
    name  " Matthias Günther               "
    email " matthias.guenther@wikimatze.de "
  end

  factory :job_offer do
    title       " Padrino Engineer    "
    location    " Berlin              "
    description " We want you ...     "
    contact     " recruter@awesome.de "
    time_start  " 1/01/2013           "
    time_end    " 01/03/2013          "
  end

end
