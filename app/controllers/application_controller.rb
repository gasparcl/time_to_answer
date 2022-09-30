class ApplicationController < ActionController::Base
   layout :layout_by_resourse

   protected
      
      def layout_by_resourse
         devise_controller? ? "#{resource_class.to_s.downcase}_devise" : "application"
      end
end
