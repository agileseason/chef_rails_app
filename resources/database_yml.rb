property :path, name_property: true
property :app_env
property :app_user
property :app_group
property :database
property :db_username
property :db_password
property :db_host

action :create do
  template new_resource.path do
    source 'database.yml.erb'

    variables(
      app_env: new_resource.app_env,
      database: new_resource.database,
      username: new_resource.db_username,
      password: new_resource.db_password,
      host: new_resource.db_host
    )

    owner new_resource.app_user
    group new_resource.app_group
    mode '0660'
  end
end
