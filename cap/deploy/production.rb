# Define roles, user and IP address of deployment server
role :app, %w{root@[YOUR_SERVER_IP]}
set :stage, :production

server '[YOUR_SERVER_IP]', user: 'root', roles: %w{app}

set :branch, "master"
set :deploy_to, "/var/www/"

set :db_host, "localhost"
set :db_name, "craft"
set :db_user, "root"
set :db_password, "SUPERSECRETPASSWORD"