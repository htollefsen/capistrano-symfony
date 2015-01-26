set :branch, :master

set :symfony_env,   'prod'
set :deploy_to,     fetch(:remote_path) + '/' + fetch(:domain) + '/' + fetch(:symfony_env)
fetch(:default_env).merge!(symfony_env: fetch(:symfony_env))

set :filter, :roles => %w{app web}

role :app, %w{www-data@capistrano-symfony.com}
role :web, %w{www-data@capistrano-symfony.com}

server fetch(:domain), user: fetch(:webserver_user), roles: fetch(:filter)
