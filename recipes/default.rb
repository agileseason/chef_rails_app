app = AppHelpers.new node['app']

node['chef_rails_app']['dirs'].each do |key, dir|
  next if key == 'root'
  mkdir dir
end

chef_rails_app_secrets "#{app.dir :shared}/config/secrets.yml" do
  app_env app.env
  app_user app.user
  app_group app.group
  secrets node['chef_rails_app']['secrets']
end
