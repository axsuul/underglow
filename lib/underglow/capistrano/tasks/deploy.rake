namespace :deploy do
  task :chmod_binstubs do
    on roles(:app) do
      within release_path do
        execute :chmod, "775", "-R", "bin"
      end
    end
  end

  after "updated", "chmod_binstubs"
end