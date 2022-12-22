source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.6'

gem 'acts_as_paranoid'
gem "aws-sdk-s3", "~> 1.14"
gem 'bcrypt', '~> 3.1.7'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'foreman'
gem 'friendly_id', '~> 5.4.0'
gem 'jsonapi.rb'
gem 'jsonapi-serializer'
gem 'jwt'
gem 'kaminari'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 4.1'
gem 'rack-cors'
gem 'rails', '~> 6.0.3', '>= 6.0.3.4'
gem "shrine", "~> 3.0"

group :development, :test do
  gem 'bullet'
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'faker', git: 'https://github.com/faker-ruby/faker.git', branch: 'master'
  gem 'guard-rspec', require: false
  gem 'pry-rails'
  gem 'rspec-rails'
  gem 'rubocop-rails'
  gem 'shoulda-matchers', '~> 4.0'
end

group :development do
  gem 'listen', '~> 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'database_cleaner-active_record'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
