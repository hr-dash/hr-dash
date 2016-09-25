# Constraints used in config/routes.rb 
Dir.glob('config/routes/constraints/*') { |f| require "#{Rails.root}/#{f}" }
