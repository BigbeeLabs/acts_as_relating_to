module ActsAsRelatingTo
  class Engine < ::Rails::Engine
    isolate_namespace ActsAsRelatingTo
  
		initializer :append_migrations do |app|
			unless app.root.to_s.match root.to_s
				config.paths["db/migrate"].expanded.each do |expanded_path|
					app.config.paths["db/migrate"] << expanded_path
				end
			end
		end

    initializer :append_dictionaries do |app|
      app.config.x.dictionaries.events_paths ||= []
      app.config.x.dictionaries.events_paths << "#{root}/db/dictionaries/events"
    end

  end
    
end
