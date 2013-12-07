namespace :log do
  desc "Truncate all logs"
  task truncate: :environment do
    Dir.glob(Rails.root.join(('log/*.log'))).each do |path|
      f = File.open(path, 'w')
      f.close
    end
  end
end