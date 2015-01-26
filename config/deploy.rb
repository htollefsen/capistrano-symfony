# config valid only for current version of Capistrano
lock '3.3.5'

# Project specifics
set :application,       'capistrano-symfony'
set :domain,            'capistrano-symfony.com'
set :repo_url,          'git@bitbucket.com:htollefsen/capistrano-symfony.git'
set :webserver_user,    'www-data'      # Default: www-data
set :remote_path,       '/var/www'      # No default


# The settings below shouldn't need any changes
set :scm, :git                          # Default: :git
set :format, :pretty                    # Default: :pretty
set :pty, false                         # Default: false
set :default_env, {}                    # Default: {}. Example: { path: "/opt/ruby/bin:$PATH" }
set :keep_releases, 5                   # Default: 5
set :deploy_via, :remote_cache          # Default: :copy. Use :copy if the server dont have access to GitHub
set :tmp_dir, fetch(:remote_path)'/' + fetch(:domain)

# Output
set :log_level, :info                   # Default: :debug. Options: info, debug

# Symfony 2 specifics
set :app_path,                  "app"
set :web_path,                  "web"
set :vendor_path,               "vendor"
set :log_path,                  fetch(:app_path) + "/logs"
set :session_path,              fetch(:app_path) + "/sessions"
set :cache_path,                fetch(:app_path) + "/cache"
set :app_config_path,           fetch(:app_path) + "/config"
set :linked_files,              fetch(:linked_files, []).push('app/config/parameters.yml')
set :linked_dirs,               fetch(:linked_dirs, []).push(fetch(:log_path), fetch(:vendor_path), fetch(:session_path))
set :file_permissions_paths,    [fetch(:log_path), fetch(:cache_path), fetch(:session_path)]
set :permission_method,         :acl            # Default: false. Options: :chmod, :acl, :chgrp
set :use_set_permissions,       true
set :symfony_console_path,      fetch(:app_path) + "/console"
set :symfony_console_flags,     "--no-debug"
set :assets_install_path,       fetch(:web_path)
set :assets_install_flags,      '--symlink'
set :assetic_dump_flags,        ''
set :controllers_to_clear,      ["app_*.php"]   # Default: []

# Hooks
namespace :deploy do
  before :starting, 'deploy:check'
  after :starting, 'composer:install_executable'
  after :updated, 'symfony:assets:install'
  after :updated, 'symfony:assetic:dump'
end