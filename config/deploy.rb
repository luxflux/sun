# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'sun'
set :repo_url, 'git@github.com:luxflux/sun'

set :default_env, 'EXECJS_RUNTIME' => 'Node'

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/srv/autohome'

# Default value for linked_dirs is []
set :linked_files, -> { %w{.env} }
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/assets}

set :rbenv_type, :system
set :rbenv_ruby, '2.3.0'

set :passenger_restart_with_touch, true
