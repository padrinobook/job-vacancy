desc "run the testfiles"
task :spec do
  Dir.glob("spec/**/*_spec.rb") do |file|
    system "rspec #{file}"
  end
end

task :default => :spec
