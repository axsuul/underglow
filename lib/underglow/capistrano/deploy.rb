Capistrano::Configuration.instance.load do
  # this task gets called last by capistrano when required to restart stuff
  namespace :deploy do
    # Custom web enable/disable tasks by simply added active suffix to maintenance page
    namespace :web do
      desc "Present a maintenance page to visitors."
      task :disable do
        require 'haml'
        on_rollback { run "rm #{shared_path}/system/maintenance.html" }

        reason = ENV['REASON']
        deadline = ENV['UNTIL']
        template = File.read('app/views/layouts/maintenance.html.haml')
        html = Haml::Engine.new(template).render(binding)

        put html, "#{shared_path}/system/maintenance.html", mode: 0644
      end
    end

    namespace :assets do
      desc "Precompile assets only if they haven't changed"
      task :precompile, roles: :web, except: { no_release: true } do
        # if there's no current revision, then this is the first deploy, then we must precompile regardless
        # otherwise, only precompile if assets have changed
        if !remote_file_exists?("#{current_path}/REVISION") or capture("cd #{release_path} && #{source.local.log(source.next_revision(current_revision))} vendor/assets/ app/assets/ | wc -l").to_i > 0
          run %Q{cd #{release_path} && #{rake_command} RAILS_ENV=#{stage} #{asset_env} assets:precompile}
        else
          logger.info "Skipping asset pre-compilation because there were no asset changes"
        end
      end
    end
  end
end