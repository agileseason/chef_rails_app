class AppHelpers
  def initialize app_node
    @app_node = app_node
  end

  def name
    @app_node['name']
  end

  def user
    @app_node['user']['name']
  end

  def group
    @app_node['user']['groups'].first()
  end

  def env
    @app_node['env']
  end

  def dir value
    @app_node['dirs'][value.to_s]
  end

  def ruby_version
    @app_node['ruby_version']
  end

  def service value
    "#{name}_#{value}_#{env}"
  end
end
