# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'sun'
set :repo_url, 'git@github.com:luxflux/sun'

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/srv/autohome'

# Default value for linked_dirs is []
set :linked_files, -> { %w{config/database.yml config/secrets.yml} }
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/assets}

set :rbenv_type, :system
set :rbenv_ruby, '2.2.2'

set :passenger_restart_with_touch, true
