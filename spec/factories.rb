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
    title       'Padrino Engineer'
    description 'We want you ...'
    location    'Berlin'
    contact     'recruter@awesome.de'
    time_start  '2019/01/16'
    time_end    '2019/01/31'
  end
end

