Capistrano with Symfony2
========================

## Required ruby gems on local machine/execution source

* bundler (1.7.12)
* capistrano (3.3.5)
    * capistrano-composer (0.0.5)
    * capistrano-file-permissions (0.1.0)
    * capistrano-stats (1.1.1)
* capistrano-symfony (0.4.0)

Usage
--------------

## Install required gems on your local-/project source machin
* `sudo gem install bundler`
* `sudo gem install capistrano`
* `sudo gem install capistrano-symfony`

## Prepare project
1. Copy ./Gemfile to <my-project>/
2. Run the following commands:
`cd <my-project> && bundle install && bundle exec cap install`
3. A Capfile has been created and should look somewhere along the lines of: <br>
`require 'capistrano/setup'` <br>
`require 'capistrano/deploy'` <br>
`require 'capistrano/composer'` <br>
`require 'capistrano/symfony'` <br>
`Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }`

4. Now lets create stage and prod-files: <br>
`bundle exec cap install STAGES=prod,stage`

5. Update the following variables in config/deploy.rb <br>
`:application` <br>
`:domain` <br>
`:repo_url` <br>
`:webserver_user` <br>
`:remote_path` <br>

6. Fix the roles in config/deploy/{prod,stage}.rb

7. Update your Symfony2 front-controller <br>
`$env = (getenv("SYMFONY_ENV") === false ? "prod" : getenv("SYMFONY_ENV"));` <br>
`$kernel = new AppKernel($env, false);` <br>

8. Add `SetEnv SYMFONY_ENV` values in your webservers virtual hosts

9. Change sessionpath to project to prevent visitors from being logged out upon deploy <br>
`framework.session:` <br>
`    handler_id:  session.handler.native_file` <br>
`    save_path: "%kernel.root_dir%/sessions"` <br>

10. Deploy to stage and prod:
`bundle exec cap stage deploy` <br>
`bundle exec cap prod deploy`

Todo
--------------

* [x] Setup
* [x] Several environments (~~dev~~, stage, prod)
* [x] Environments (SYMFONY_ENV)
* [x] Vendor deployment
* [x] Documentation

