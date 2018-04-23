class BigbeeDecoratorGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)
  #argument :scaffold_name, :type => :string
  class_option :app_namespace, :type => :boolean, default: true

  def generate
    dir_path = "app/decorators/#{my_class_path.join('/')}/#{file_name}_decorator.rb"
    template "decorator_base.rb", dir_path
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