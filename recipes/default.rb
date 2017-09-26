app = AppHelpers.new node['app']

app.node['dirs'].each do |key, dir|
  next if key == 'root'
  mkdir dir
end

chef_rails_app_secrets_yml "#{app.dir :shared}/config/secrets.yml" do
  app_env app.env
  app_user app.user
  app_group app.group
  secrets app.node['secrets']
end

chef_rails_app_database_yml "#{app.dir :shared}/config/database.yml" do
  app_env app.env
  app_user app.user
  app_group app.group
  database "#{app.name}_#{app.env}"

  credentials = node['postgresql']['users']
    .find { |v| v['username'] == database }

  db_user credentials['username']
  db_password credentials['password']
end
