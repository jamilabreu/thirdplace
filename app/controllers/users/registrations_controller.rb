class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters

  def create
    # Auto-generate temporary password
    generated_password = Devise.friendly_token.first(10)
    params[:user][:password] = generated_password
    super
  end

  protected

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  def after_sign_up_path_for(resource)
    edit_user_registration_path
  end

  def after_update_path_for(resource)
    signed_in_root_path(resource)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:account_update) << :name
    Community::TYPES.each do |community_type|
      devise_parameter_sanitizer.for(:account_update) << { "#{community_type.downcase}_ids" => [] }
    end
  end
end