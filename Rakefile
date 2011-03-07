$:.unshift File.expand_path(File.join(File.dirname(__FILE__), 'lib'))

require 'rubygems'
require 'tomahto'
# require 'rake/testtask'
require 'rake/gempackagetask'

lib_files = Dir['lib/**/*.rb']
spec_files = Dir['spec/**/*.rb']

gem_spec = Gem::Specification.new do |s|
  s.name = "tomahto"
  s.version = Tomahto::VERSION
  s.authors = ["Samuel Mullen"]
  s.email = "samullen@gmail.com"
  s.homepage = "http://github.com/samullen/tomahto"
  s.summary = "A simple pomodoro executable which can be run on Linux and Mac."
  s.description = false
  s.files = [
    "LICENSE",
    "README.md",
    "Rakefile",
    "bin/tomahto",
  ] + spec_files + lib_files
end

# Rake::TestTask.new(:test) do |test|
#   test.libs = [lib_dir, test_dir]
#   test.pattern = 'test/**/*rb'
#   test.verbose = true
# end

Rake::GemPackageTask.new(gem_spec) do |pkg|
  pkg.need_zip = false
  pkg.need_tar = false
end

desc "Install the gem locally"
# task :install => [:test, :gem] do
task :install => [:gem] do
  sh %{gem install pkg/#{gem_spec.name}-#{gem_spec.version}}
end

desc "Remove the pkg directory and all of its contents."
task :clean => :clobber_package

# task :default => [:test, :gem]
task :default => [:install]

