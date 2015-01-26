set :branch, :develop
# Use the line below to be asked what branch to checkout to on each deployment to this environment
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

set :symfony_env,   'stage'
set :deploy_to,     fetch(:remote_path) + '/' + fetch(:domain) + '/' + fetch(:symfony_env)
fetch(:default_env).merge!(symfony_env: fetch(:symfony_env))

set :filter, :roles => %w{app web}

role :app, %w{www-data@stage.capistrano-symfony.com}
role :web, %w{www-data@stage.capistrano-symfony.com}

server fetch(:symfony_env) + '.' + fetch(:domain), user: fetch(:webserver_user), roles: fetch(:filter)
