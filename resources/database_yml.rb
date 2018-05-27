property :path, name_property: true
property :app_env
property :app_user
property :app_group
property :database
property :db_username
property :db_password
property :db_host

action :create do
  template path do
    source 'database.yml.erb'

    variables(
      app_env: app_env,
      database: database,
      username: db_username,
      password: db_password,
      host: db_host
    )

    owner app_user
    group app_group
    mode '0660'
  end
end
