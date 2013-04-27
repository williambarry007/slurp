# encoding: UTF-8
require "bundler/gem_tasks"
require 'rake/testtask'
require 'rdoc/task'

desc 'Default: run tests for all ORMs.'
task :default => :test

desc 'Run Slurp tests for all ORMs.'
task :pre_commit do
  Dir[File.join(File.dirname(__FILE__), 'test', 'orm', '*.rb')].each do |file|
    orm = File.basename(file).split(".").first
    exit 1 unless system "rake test DEVISE_ORM=#{orm}"
  end
end

desc 'Run Slurp unit tests.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
  t.warning = true
end

desc 'Generate documentation for Slurp.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'Slurp'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README.md')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
