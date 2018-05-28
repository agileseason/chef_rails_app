property :path, name_property: true
property :app_user
property :app_env
property :app_group
property :secrets

action :create do
  if new_resource.secrets
    template new_resource.path do
      source 'secrets.yml.erb'

      variables(
        app_env: new_resource.app_env,
        secrets: JSON.parse(new_resource.secrets.to_json, symbolize_names: true)
      )

      owner new_resource.app_user
      group new_resource.app_group
      mode '0660'
    end
  end
end
