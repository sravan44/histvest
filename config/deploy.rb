set :application, "histvest"
set :repository, "https://8c28b400-7832-4d8a-bc0d-01ea6bc69555:notused@globalit.kilnhg.com/Code/HistVest/Group/Development"
set :scm, :mercurial

set :user, "vds"
set :use_sudo, false

# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "histvest.no"                          # Your HTTP server, Apache/etc
role :app, "histvest.no"                          # This may be the same as your `Web` server
role :db,  "histvest.no", :primary => true # This is where Rails migrations will run

set :deploy_to, "/home/vds/histvest.no"
set :normalize_asset_timestamps, false
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
# endw

desc "Copies the database config to the current release."
task :copy_database_config, :hosts => "histvest.no" do
  run "cp /home/vds/database.yml /home/vds/histvest.no/current/config/database.yml"
end