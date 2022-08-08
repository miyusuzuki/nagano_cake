class ApplicationController < ActionController::Base
 def after_sign_in_path_for(resource)
        case resource
        when Admin
            root_path
        when Customer
            customers_my_page_path # ログイン後に遷移するpathを設定
        end
 end
  
  
  private

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up,keys:[:email])
    end
end
