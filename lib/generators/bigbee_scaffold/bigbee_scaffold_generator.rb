class BigbeeScaffoldGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)
  #argument :scaffold_name, :type => :string
  class_option :app_namespace, :type => :boolean, default: true
  class_option :actions, :type => :array, default: [:index, :show, :new, :create, :update, :edit]

  def generate_controller
    dir_path = "app/controllers/#{my_class_path.join('/')}"
    controller_file_name = "#{file_name}_controller.rb"
    write_path = dir_path + "/#{controller_file_name}"
    template_name = "controllers/base.rb"
    #empty_directory dir_path
    template template_name, write_path
  end

  def generate_managers
    dir_path = "app/managers/#{class_path.join('/')}/#{file_name}"
    @manager_name = "manager_base"
    template_name = "managers/manager_base.rb"
    write_path = "#{dir_path}/manager_base.rb"
    template template_name, write_path
    actions.each do |manager_name|
      @manager_name = manager_name.to_s
      template_name = "managers/manager_template.rb"
      write_path = "#{dir_path}/#{manager_name}_manager.rb"
      template template_name, write_path
    end
  end

  def generate_views
    unless is_an_api?
      dir_path = "app/views/#{class_path.join('/')}/#{file_name}"
      actions.each do |view_name|
        template_name = "views/view_template.rb"
        write_path = "#{dir_path}/#{view_name}.html.haml"
        template template_name, write_path
        template_name = "views/partial_template.rb"
        write_path = "#{dir_path}/_#{view_name}.html.haml"
        template template_name, write_path
      end
    end
  end

  def generate_presenters
    unless is_an_api?
      dir_path = "app/presenters/#{class_path.join('/')}/#{file_name}"
      template_name = "presenters/base.rb"
      write_path = "#{dir_path}/presenter_base.rb"
      template template_name, write_path
      actions.each do |presenter_name|
        @presenter_name = presenter_name
        template_name = "presenters/action_presenter.rb"
        write_path = "#{dir_path}/#{presenter_name}_presenter.rb"
        template template_name, write_path
      end
    end
  end

  def generate_javascript
    unless is_an_api?
      js_path = class_path.clone
      js_path.shift
      dir_path = "app/assets/javascripts/#{app_name}/jquery_plugins/pages/#{js_path.join('/')}/#{file_name}"
      template_name = "javascripts/javascript.rb"
      template template_name, "#{dir_path}.coffee"
      actions.each do |action|
        write_path = "#{dir_path}/#{action}.coffee"
        template template_name, write_path
      end
    end
  end

  private

  def actions()         options[:actions]                 end
  def app_namespace()   options[:app_namespace]           end
  def app_name()        @app_name ||= find_app_name       end
  def manager_name()    @manager_name                     end
  def presenter_name()  @presenter_name                   end
  def view_name()       @view_name                        end
  def is_an_api?()      class_path[0] == "api"            end

  def find_app_name
    app_namespace ? ENV['app_name'] : nil
  end

  def my_class_path() @my_class_path ||= find_my_class_path end
  
  def find_my_class_path
    if app_namespace and app_name and not is_an_api?
      class_path.unshift(app_name)
    else
      class_path
    end
  end


end