class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?
  
  private  

  def after_sign_in_path_for(resource)
    case resource
    when Admin
      admin_top_path
    when Customer
      root_path
    end
  end
  
  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :admin
      admin_sign_in_path
    else
      new_customer_session_path
    end
  end
  
  #def after_sign_out_path_for(resource)
    #case resource
    
    #when Admin
     # admin_sign_in_path
    #when Customer
    #  new_customer_session_path
    #end
 # end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,keys:[:email, :last_name, :first_name, :last_name_kana, :first_name_kana, :address, :telephone_number, :postal_code])
    devise_parameter_sanitizer.permit(:sign_in,keys:[:email])
  end
  
end
