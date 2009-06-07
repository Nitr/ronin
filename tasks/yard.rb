require 'yard'

YARD::Rake::YardocTask.new do |t|
  t.files   = ['lib/**/*.rb', 'History.txt', 'TODO.txt', 'README.txt']
end

task :docs => :yardoc
