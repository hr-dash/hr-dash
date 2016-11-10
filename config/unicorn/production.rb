current_path = "/var/www/hr-dash/current"
shared_path = "/var/www/hr-dash/shared/"

working_directory current_path

listen File.expand_path('tmp/sockets/unicorn.sock', shared_path)
pid File.expand_path('tmp/pids/unicorn.pid', shared_path)

worker_processes Integer(ENV["WEB_CONCURRENCY"] || 3)
timeout 15
preload_app true

before_fork do |server, worker|
  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.connection.disconnect!
  end

  ENV['BUNDLE_GEMFILE'] = File.expand_path('Gemfile', current_path)
  old_pid = "#{server.config[:pid]}.oldbin"
  if File.exists?(old_pid) && server.pid != old_pid
	  begin
	    sig = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
	    Process.kill(sig, File.read(old_pid).to_i)
	  rescue Errno::ENOENT, Errno::ESRCH
	  # someone else did our job for us
	  end
	end
end 

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
end
