namespace :rails do
  desc "Run rails console"
  task console: :'deploy:set_rails_env' do
    on roles(:app) do
      within current_path do
        with rails_env: fetch(:rails_env) do
          execute_with_tty "bin/rails", "c"
        end
      end
    end
  end

  task c: :console

  # Ex: cap production rake:invoke TASK=db:migrate TRACE=true ENV=FOO=bar,BAZ=boo"
  desc "Run rails rake task"
  task rake: :'deploy:set_rails_env' do
    on roles(:app) do
      within current_path do
        with rails_env: fetch(:rails_env) do
          # Build environment variables that we need
          # to pass in
          env = (ENV.delete('ENV') || "")
          env_hash = env.split(',').each_with_object({}) do |pair, hash|
            key, value = pair.split('=')

            hash[key.downcase.to_sym] = value
          end

          with env_hash do
            args = ["bin/rake", ENV['TASK']]
            args << "--trace" if ENV['TRACE']

            execute(*args)
          end
        end
      end
    end
  end

  desc "Run rails runner"
  task runner: 'deploy:set_rails_env' do
    on roles(:app) do
      within current_path do
        with rails_env: fetch(:rails_env) do
          execute "bin/rails", "runner", ENV['FILE']
        end
      end
    end
  end

  desc "View rails log"
  task log: 'deploy:set_rails_env' do
    on roles(:app) do
      within current_path do
        with rails_env: fetch(:rails_env) do
          execute_with_tty "vi", "log/#{fetch(:stage)}.log"
        end
      end
    end
  end

  desc "Tail rails log"
  task tail: 'deploy:set_rails_env' do
    on roles(:app) do
      within current_path do
        with rails_env: fetch(:rails_env) do
          execute "tail", "-f", "log/#{fetch(:stage)}.log"
        end
      end
    end
  end
end