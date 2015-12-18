source "https://rubygems.org"
gem "rails", "4.2.4"
gem "rails-api"
gem "rspec-rails"
gem "bcrypt"
gem "active_model_serializers"
gem "validates_email_format_of"
gem "jwt"
gem "simple_command"

group :development, :test do
  gem "spring"
  gem "byebug"
  gem "sqlite3"
end

group :test do
  gem "codeclimate-test-reporter", require: nil
  gem "factory_girl_rails"
  gem "simplecov", require: false
  gem "database_cleaner"
end
group :production do
  gem "puma"
  gem "pg"
end
