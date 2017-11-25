# encoding: utf-8

FactoryBot.define do
  sequence(:email) { |email_number| "matthias#{email_number}@padrinobook.de" }
  sequence(:name) { |name_number| "wikimatze #{name_number}" }
  sequence(:confirmation_token) { '1' }
  sequence(:id) { |n| n }

  factory :user do
    id
    name
    email
    password 'octocat'
    confirmation_token
  end

  factory :job_offer do
    title       'Padrino Engineer   '
    location    'Berlin             '
    description 'We want you ...    '
    contact     'recruter@awesome.de'
    time_start  '1/01/2013          '
    time_end    '01/03/2013         '
  end
end

