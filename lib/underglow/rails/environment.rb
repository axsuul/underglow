# Require this file for quick access to Rails environment properties
unless defined? Rails
  # Mock a Rails class that supplies the env and root if it's not defined
  class Rails
    def self.env
      ENV['RAILS_ENV'] || "development"
    end

    def self.root
      # File.dirname(File.dirname(File.expand_path(__FILE__)))
      if env == "development"
        "/vagrant" if File.exists?("/vagrant")
      else
        caller_path = "#{Dir.pwd}/#{caller.last.split(":").first}"

        # Assume we are using capistrano, so whatever is /*/current would be the root
        caller_path.sub(/\/current\/.*/, "/current")
      end
    end
  end
end
