require './config/environment'

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

#to send delete and pactch requests
use Rack::MethodOverride

#mount controllers with 'use'
use UsersController
use DevotionEntriesController
run ApplicationController
