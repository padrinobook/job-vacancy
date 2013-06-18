require 'bundler/setup'
require 'padrino-core/cli/rake'

PadrinoTasks.use(:database)
PadrinoTasks.use(:activerecord)
PadrinoTasks.init

desc "run the testfiles"
task :spec do
  Dir.glob("spec/**/*_spec.rb") do |file|
    system "rspec #{file}"
  end
end

task :default => :spec

