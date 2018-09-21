# config valid only for current version of Capistrano
lock '3.11.0'

set :application, 'newspicks_teamA'
set :repo_url,  'git@github.com:MasahiroKitazoe/newspicks_teamA.git'

set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads')

set :rbenv_type, :user
set :rbenv_ruby, '2.3.1'

set :ssh_options, auth_methods: ['publickey'],
                  keys: ['/Users/masahiro/.ssh/v2_newspicks_teama.pem']

set :unicorn_pid, -> { "#{shared_path}/tmp/pids/unicorn.pid" }
set :unicorn_config_path, -> { "#{current_path}/config/unicorn.rb" }
set :keep_releases, 5

set :default_env, {
  rbenv_root: "/usr/local/rbenv",
  path: "/usr/local/rbenv/shims:/usr/local/rbenv/bin:$PATH",
  AWS_ACCESS_KEY_ID_NP: ENV["AWS_ACCESS_KEY_ID_NP"],
  AWS_SECRET_ACCESS_KEY_NP: ENV["AWS_SECRET_ACCESS_KEY_NP"]
}

set :linked_files, %w{ config/secrets.yml }

after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  task :restart do
    invoke 'unicorn:restart'
  end

  desc 'upload secrets.yml'
  task :upload do
    on roles(:app) do |host|
      if test "[ ! -d #{shared_path}/config ]"
        execute "mkdir -p #{shared_path}/config"
      end
      upload!('config/secrets.yml', "#{shared_path}/config/secrets.yml")
    end
  end
  before :starting, 'deploy:upload'
  after :finishing, 'deploy:cleanup'
end

# require "delayed/recipes"

# role :delayed_job, 'delayed_job.example.com' # ワーカ用サーバの指定
# set :delayed_job_server_role, :delayed_job   # delayed_jobのワーカを動かすロール名の設定
# set :delayed_job_command, defer { "#{bundle_cmd} exec bin/delayed_job" }

# after "deploy:stop",    "delayed_job:stop"
# after "deploy:start",   "delayed_job:start"
# after "deploy:restart", "delayed_job:restart"

# SSHKit.config.command_map[:rake] = 'bundle exec rake'

# namespace :deploy do
#   desc 'db_seed must be run only one time right after the first deploy'
#   task :db_seed do
#     on roles(:db) do |host|
#       within current_path do
#         with rails_env: fetch(:rails_env) do
#           execute :rake, 'db:seed'
#         end
#       end
#     end
#   end
# end
