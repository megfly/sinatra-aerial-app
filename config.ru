require './config/environment'

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

use Rack::MethodOverride #patch and delete

#here is where we will mount other controllers with 'use'

use AerialEntriesController
use UsersController

run ApplicationController
