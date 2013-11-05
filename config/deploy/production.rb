server "mazg.ssapp.co", :app, :web, :db, :primary => true
set :domain,"mazg.ssapp.co"
set :rails_env, :production

#unicorn var
set :unicorn_workers,4
set :monit_mem_restart,"300.0 MB"

