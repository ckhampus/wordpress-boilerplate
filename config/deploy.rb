set :stages, %w(production staging development)
set :default_stage, 'development'
require 'capistrano/ext/multistage'

# The application name.
set :application, 'wordpress-boilerplate'
set :user, 'www-data'
set :group, 'www-data'

# The application repository.
set :scm, :git
set :repository, 'git@github.com:ckhampus/wordpress-boilerplate.git'

set :deploy_via, :remote_cache
set :copy_exclude, ['.git', '.DS_Store', '.gitignore', '.gitmodules']
set :git_enable_submodules, 1

set :deploy_to, "/var/www/#{application}"

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