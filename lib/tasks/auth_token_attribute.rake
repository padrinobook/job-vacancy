namespace :user do
  desc "Generate fresh auth_tokens for all users in the current environment."
  task :scramble_auth_token => :environment do
  end
end
