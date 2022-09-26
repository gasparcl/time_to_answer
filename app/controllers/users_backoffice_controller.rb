class UsersBackofficeController < ApplicationController
# The authentication before_action method must be written with the model name(in singular), as the example below:
   before_action :authenticate_user! 

   layout 'users_backoffice'
end
