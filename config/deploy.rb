set :stages, %w(production staging development)
set :default_stage, 'staging'
require 'capistrano/ext/multistage'

set :application, 'wordpress-boilerplate'

set :repository, 'git@github.com:ckhampus/wordpress-boilerplate.git'
set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `svn`, `mercurial`, `perforce`, `subversion` or `none`

set :deploy_via, :remote_cache
set :copy_exclude, ['.git', '.DS_Store', '.gitignore', '.gitmodules']
set :git_enable_submodules, 1

set :deploy_to, '/var/www'

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

namespace :wordpress do
    desc 'Symlink the Uploads folder from shared folders'
    task :symlink, :roles => :app do
        run "ln -nfs #{shared_path}/uploads #{release_path}/content/uploads"
    end
end

after 'deploy:create_symlink', 'wordpress:symlink'

%w{deploy:migrate deploy:migrations deploy:update deploy:update_code deploy:start deploy:stop deploy:restart deploy:symlink}.each do |name|
  find_task(name).instance_variable_get(:@desc).insert(0, '[internal]')
end