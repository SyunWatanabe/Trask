set :default_env, {
  AWS_ACCESS_KEY: ENV['AWS_ACCESS_KEY'],
  AWS_SECRET_KEY: ENV['AWS_SECRET_KEY'],
  S3_REGION: ENV['S3_REGION']
}
set :rbenv_type, :user
set :rbenv_ruby, '2.5.1'
set :rbenv_custom_path, '/home/shun/.rbenv'

# capistranoのバージョン固定
lock '3.11.1'

# デプロイするアプリケーション名
set :application, 'trask'

# cloneするgitのレポジトリ
set :repo_url, 'git@github.com:SyunWatanabe/trask.git'

# deployするブランチ。デフォルトはmasterなのでなくても可。
set :branch, 'master'

# deploy先のディレクトリ。 
set :deploy_to, '/var/www/trask'

# シンボリックリンクをはるファイル。(※後述)
set :linked_files, fetch(:linked_files, []).push('config/master.key')

# シンボリックリンクをはるフォルダ。(※後述)
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# 保持するバージョンの個数(※後述)
set :keep_releases, 5

#出力するログのレベル。
set :log_level, :debug

namespace :deploy do
  desc 'Restart application'
  task :restart do
    invoke 'unicorn:restart'
  end

  desc 'Create database'
  task :db_create do
    on roles(:db) do |host|
      with rails_env: fetch(:rails_env) do
        within current_path do
          execute :bundle, :exec, :rake, 'db:create'
        end
      end
    end
  end

  desc 'Run seed'
  task :seed do
    on roles(:app) do
      with rails_env: fetch(:rails_env) do
        within current_path do
          execute :bundle, :exec, :rake, 'db:seed'
        end
      end
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
    end
  end
end
