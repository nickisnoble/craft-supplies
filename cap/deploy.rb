############################################
# Setup project
############################################

set :application, "[APPNAME]"
set :repo_url, "[YOUR_REPO_SSH_HERE]"
set :scm, :git

set :git_strategy, SubmoduleStrategy

############################################
# Local details
############################################

set :local_db_host, "192.168.56.102"
set :local_db_name, "craft"
set :local_db_user, "homestead" # This is the homestead default
set :local_db_password, "secret" # This is the homestead default

############################################
# Setup Capistrano
############################################

set :log_level, :info
set :use_sudo, false
set :deploy_as, 'root:www-data'

set :ssh_options, {
	forward_agent: true,
	paranoid: true
}

set :keep_releases, 3
set :keep_db_backups, 3

############################################
# Deploy actions
############################################

namespace :deploy do

	desc "create files for symlinking"
	task :symlink do
		on roles(:app) do
			execute "ln -nfs #{shared_path}/assets #{release_path}/public/assets"
			execute "ln -nfs #{shared_path}/fonts #{release_path}/public/fonts"
			execute "ln -nfs #{shared_path}/craft/app #{release_path}/craft/app"
			execute "ln -nfs #{shared_path}/craft/storage #{release_path}/craft/storage"
			execute "ln -nfs #{shared_path}/craft/config/license.key #{release_path}/craft/config/license.key"
		end
	end
	after :finished, :symlink

	desc "set file permissions"
	task :modify_permissions do
		on roles(:app) do
			execute :chown, "-R :www-data #{release_path}/craft/"
      execute :chmod, "-R 774 #{release_path}/craft/"
		end
	end
	after :symlink, :modify_permissions

	desc "copy compiled styles"
	task :transfer_styles do
		on roles(:app) do
			execute "mkdir #{release_path}/public/css"
			execute "touch #{release_path}/public/css/style.css"
			execute "rm -rf #{release_path}/public/scss"
			run_locally do
		    exec "git checkout master && gulp compile"
		  end
      upload! "public/css/style.css", "#{release_path}/public/css/style.css"
		end 
	end
	after :symlink, :transfer_styles

	desc "Creates robots.txt for non-production envs"
	task :create_robots do
		on roles(:app) do
			if fetch(:stage) != :production then
				io = StringIO.new('User-agent: * Disallow: /')
				upload! io, File.join(release_path, "robots.txt")
				execute :chmod, "644 #{release_path}/robots.txt"
			end
		end
	end

	after :finished, :create_robots
	after :finishing, "deploy:cleanup"
end
