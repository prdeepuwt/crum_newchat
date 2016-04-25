class RegistrationsController < Devise::RegistrationsController
  def create
    build_resource(sign_up_params)
    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        if !params[:user][:interests].blank?
          @tag= process_tags(params[:user][:interests])
          @tag.each do |name|
	          searched_tag = Tag.find_by(name: name)
	          tag = (searched_tag) ? searched_tag : Tag.new(name: name)
	          if current_user.tags.count < 14 and name.length <= 15
		          tag.users << current_user unless tag.users.include? current_user
		          tag.save
	          end
          end
        end
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end


  end
  private

  def sign_up_params
    params.require(:user).permit(:name,:avatar, :interests, :email, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:name,:avatar, :current_password, :email, :interests, :password, :password_confirmation)
  end


end
