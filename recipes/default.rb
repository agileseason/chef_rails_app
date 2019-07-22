app = AppHelpers.new node['app']

app.node['dirs'].each do |key, dir|
  next if key == 'root'
  next unless dir

  mkdir dir
end

if app.node['secrets']
  chef_rails_app_secrets_yml "#{app.dir :shared}/config/secrets.yml" do
    app_env app.env
    app_user app.user
    app_group app.group
    secrets app.node['secrets']
  end
end

if node['chef_rails_postgresql']
  chef_rails_app_database_yml "#{app.dir :shared}/config/database.yml" do
    app_env app.env
    app_user app.user
    app_group app.group
    database node['chef_rails_postgresql']['database'] || "#{app.name}_#{app.env}"

    db_username node['chef_rails_postgresql']['username']
    db_password node['chef_rails_postgresql']['password']
    db_host node['chef_rails_postgresql']['listen_addresses']
  end
end
