class String
  class_eval do
    def colorize(color_code)  "\e[#{color_code}m#{self}\e[0m"   end
    def red()                 colorize(31)                      end
    def green()               colorize(32)                      end
    def yellow()              colorize(33)                      end
    def blue()                colorize(34)                      end
    def light_blue()          colorize(36)                      end
    def pink()                colorize(35)                      end
  end
end

# desc "Explaining what the task does"
# task :acts_as_relating_to do
#   # Task goes here
# end
namespace :acts_as_relating_to do 
  desc "Load all role files"
  task load_roles: :environment do
    RoleLoader.load_all
  end
end
