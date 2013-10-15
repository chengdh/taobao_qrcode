require "bundler/capistrano"
#require "capistrano-rbenv"
#require "capistrano-unicorn"

require "capistrano-cook"

server "106.186.112.108", :app, :web, :db, :primary => true
#server "219.147.55.69", :app, :web, :db, :primary => true
set :domain,    "www.2wm.com"
set :rails_env, :production

set :application, "taobao_qr"
set :user,        "taobao_qr"

set :scm,         "git"
set :repository,  "git@github.com:chengdh/taobao_qrcode.git"
set :branch,      "master"
set :deploy_to,   "/var/www/#{application}"
set :deploy_via,  :remote_cache

set :use_sudo,      true
set :root_user,     'root'

default_run_options[:pty]   = true
ssh_options[:forward_agent] = true

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end
