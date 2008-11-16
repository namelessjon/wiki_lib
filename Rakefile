require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require 'rcov/rcovtask'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |s|
    s.name = "wiki_lib"
    s.summary = "A simple library to wrap around some common wiki operations"
    s.email = "jonathan.stott@gmail.com"
    s.homepage = "http://github.com/namelessjon/wiki-lib"
    s.description = "A simple library to wrap around some common wiki operations\nCurrently only PMWiki is supported, but more will be added as and when."
    s.authors = ["Jonathan Stott"]
    s.add_dependency 'mechanize', '~>0.8'
    s.autorequire = 'wiki_lib'
    s.files =  %w(LICENSE README Rakefile) + Dir.glob("{lib,spec}/**/*")
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end

Rake::TestTask.new do |t|
  t.libs << 'lib'
  t.pattern = 'spec/**/*_spec.rb'
  t.verbose = false
end

Rake::RDocTask.new do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'wiki-lib'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

Rcov::RcovTask.new do |t|
  t.libs << "spec"
  t.test_files = FileList['spec/**/*_spec.rb']
  t.verbose = true
end

task :default => :rcov
