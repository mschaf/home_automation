# config valid for current version and patch releases of Capistrano
lock "~> 3.11.0"

set :application, "home_automation"
set :repo_url, "gitlab@git.martin-sc.de:martin/home_automation.git"
set :scm_user, "deploy"
server "home.ramaschaf.de", user: "deploy-home_automation", roles: %w{app db web}
set :use_sudo, false
set :linked_files, ['config/master.key', 'config/database.yml']
set :rails_env, "production"
set :keep_releases, 5
set :whenever_identifier, ->{ "#{fetch(:application)}_#{fetch(:stage)}" }


namespace :deploy do
  after :restart, :restart_passenger do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      within release_path do
        execute :touch, 'tmp/restart.txt'
      end
    end
  end
  after :finishing, 'deploy:restart_passenger'
end