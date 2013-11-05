#server "ssapp.co", :app, :web, :db, :primary => true
server "sandbox.ssapp.co", :app, :web, :db, :primary => true
set :domain,"sandbox.ssapp.co"
set :rails_env,'sandbox'
set :unicorn_workers,2
set :monit_mem_restart,"100.0 MB"
