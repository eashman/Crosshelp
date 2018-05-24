require 'mina/multistage'
require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/rbenv'    # for rbenv support. (http://rbenv.org)
#require 'mina/rvm'    # for rvm support. (http://rvm.io)
require 'mina/puma'
require 'mina_sidekiq/tasks'
# Basic settings:
#   domain       - The hostname to SSH to.
#   deploy_to    - Path to deploy into.
#   repository   - Git repo to clone from. (needed by mina/git)
#   branch       - Branch name to deploy. (needed by mina/git)

set :domain, '47.105.32.52'
set :deploy_to, '/var/www/CrossBorderHelp'
set :repository, 'git@github.com:CrossBorderHelp/CrossBorderHelp-Web.git'
set :branch, 'master'
set :user, 'root'
set :rails_env, 'production'

# For system-wide RVM install.
#set :rvm_path, '/usr/local/rvm/bin/rvm'

# Manually create these paths in shared/ (eg: shared/config/database.yml) in your server.
# They will be linked in the 'deploy:link_shared_paths' step.
#set :shared_paths, ['config/database.yml', 'config/secrets.yml', 'log']

set :shared_paths, ['config/application.yml', 'config/database.yml', 'config/secrets.yml', 'config/puma.rb',
  'log', 'tmp/pids', 'tmp/sockets', 'docker-compose.yml']

set :sidekiq_pid, "#{deploy_to}/#{shared_path}/tmp/pids/sidekiq.pid"

# Optional settings:
#   set :user, 'foobar'    # Username in the server to SSH to.
#   set :port, '30000'     # SSH port number.
#   set :forward_agent, true     # SSH forward_agent.

# This task is the environment that is loaded for most commands, such as
# `mina deploy` or `mina rake`.
task :environment do
  # If you're using rbenv, use this to load the rbenv environment.
  # Be sure to commit your .ruby-version or .rbenv-version to your repository.
  invoke :'rbenv:load'

  # For those using RVM, use this to load an RVM version@gemset.
  #invoke :'rvm:use[ruby-2.4.0@default]'
  #invoke :'rvm:use', 'ruby-2.4.0@default'
end

# Put any custom mkdir's in here for when `mina setup` is ran.
# For Rails apps, we'll make some of the shared paths that are shared between
# all releases.
task :setup => :environment do
  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/log"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/log"]

  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/config"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/config"]

  queue! %[touch "#{deploy_to}/#{shared_path}/config/database.yml"]
  queue! %[touch "#{deploy_to}/#{shared_path}/config/secrets.yml"]
  queue  %[echo "-----> Be sure to edit '#{deploy_to}/#{shared_path}/config/database.yml' and 'secrets.yml'."]

end

desc "Deploys the current version to the server."
task deploy: :environment do
  to :before_hook do
    # Put things to run locally before ssh
  end
  deploy do
    # Put things that will set up an empty directory into a fully set-up
    # instance of your project.
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'docker:up'
    invoke :'bundle:install'
    invoke :'rails:db_create'
    invoke :'rails:db_migrate'
    #invoke :'npm:install'
    #invoke :'searchkick:reindex'
    invoke :'rails:assets_precompile'

    to :launch do
      invoke :'deploy:cleanup'
      invoke :'sidekiq:restart'
      invoke :'puma:hard_restart'
    end
  end
end


namespace :npm do
  desc 'npm install'
  task install: :environment do
    queue 'npm install'
  end
end

namespace :searchkick do
  desc 'searchkick:reindex'
  task reindex: :environment do
    command 'bundle exec rake searchkick:reindex CLASS=User RAILS_ENV=production'
  end
end

namespace :db do
  desc "Seed data to the database"
  task seed: :environment do
      command "bundle exec rake db:seed RAILS_ENV=production"
  end
  desc "Drop database"
  task drop: :environment do
    command "bundle exec rake db:drop RAILS_ENV=production"
  end
end

namespace :docker do
  set :compose_file, "#{deploy_to}/#{shared_path}/docker-compose.yml"
  set :project_name, 'CrossBorderHelp'.freeze

  desc 'Start docker-compose'
  task up: :environment do
    queue "docker-compose -f #{compose_file} -p #{project_name} up -d"
  end

  desc 'Stop docker-compose'
  task down: :environment do
    queue "docker-compose -f #{compose_file} -p #{project_name} down"
  end

  desc 'Restart docker-compose'
  task restart: :environment do
    queue "docker-compose -f #{compose_file} -p #{project_name} restart"
  end
end


# For help in making your deploy script, see the Mina documentation:
#
#  - http://nadarei.co/mina
#  - http://nadarei.co/mina/tasks
#  - http://nadarei.co/mina/settings
#  - http://nadarei.co/mina/helpers
