class BigbeeJqueryPluginGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)
  #argument :scaffold_name, :type => :string
  class_option :app_namespace, :type => :boolean, default: true

  def generate
    template "jquery_plugin_base.rb", dir_path
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
    %w(
      app assets javascripts
      nfp_admin jquery_plugins
    ).concat(class_path)
  end

  def plugin_class_name; @plugin_class_name ||= get_plugin_class_name end
  
  def get_plugin_class_name
    class_path.clone.tap do |class_name_base|
      class_name_base.shift
      return class_name_base.send(:<<, file_name).map{|n| n.camelize}.join('_')
    end
  end

  def dir_path; @dir_path ||= get_dir_path end
  
  def get_dir_path
    my_class_path.send(:<<, file_name).join('/').send(:<<, '.coffee')
  end

  def plugin_function_name
    plugin_class_name.clone.tap do |name_base|
      name_base[0] = name_base[0].downcase
      name_base
    end
  end

end