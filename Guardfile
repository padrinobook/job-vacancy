guard :rspec, cmd: "bundle exec rspec" do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^app/controllers/(.+)\.rb$}) { |m| "spec/app/controllers/#{m[1]}_controller_spec.rb" }
  watch(%r{^app/models/(.+)\.rb$})      { |m| "spec/models/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb')          { "spec" }
end

