# frozen_string_literal: true

require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new(:test) do |t|
  # TODO: currently cocoapods-core, nanaimo and addressable emit many
  # "warning: character class has duplicated range" warnings.
  # silence them with the `-W0` ruby CLI option until dependent gems are
  # updated to no longer emit these warnings
  t.ruby_opts = %w{-W0}

  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList["test/**/*_test.rb"]
end

require "rubocop/rake_task"

RuboCop::RakeTask.new

task default: %i[test rubocop]
