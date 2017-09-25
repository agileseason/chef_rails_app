property :path, name_property: true
property :app_user
property :app_env
property :app_group
property :secrets

action :create do
  template path do
    source 'secrets.yml.erb'

    variables(
      app_env: app_env,
      secrets: JSON.parse(secrets.to_json, symbolize_names: true)
    )

    owner app_user
    group app_group
    mode '0660'
  end if secrets
end
