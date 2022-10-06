class UsersBackoffice::ProfileController < UsersBackofficeController
   def edit
      @user = User.find(current_user.id)
   end

   def update
      
   end
end
