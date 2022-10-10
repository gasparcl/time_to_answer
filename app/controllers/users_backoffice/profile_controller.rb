class UsersBackoffice::ProfileController < UsersBackofficeController
   before_action :verify_password, only: [:update]
   before_action :set_user

   def edit
      # Sua função é criar um user_profile para o edit
      # Pode ser utilizado esse método embutido, pois a relação de user para com user_profile é de 1 x 1
      #     Se fosse 1 x Muitos, deveria ser utilizado o método embutido user_profile.build
      @user.build_user_profile if @user.user_profile.blank?
   end

   def update
      if @user.update(params_user)
         bypass_sign_in(@user)
         unless params_user[:user_profile_attributes][:avatar]
            redirect_to users_backoffice_profile_path, notice: "Usuário atualizado com sucesso!"
         end
      else
         render :edit
      end
   end

   # ╔═╗╦═╗╦╦  ╦╔═╗╔╦╗╔═╗  ╔╦╗╔═╗╔╦╗╦ ╦╔═╗╔╦╗╔═╗
   # ╠═╝╠╦╝║╚╗╔╝╠═╣ ║ ║╣   ║║║║╣  ║ ╠═╣║ ║ ║║╚═╗
   # ╩  ╩╚═╩ ╚╝ ╩ ╩ ╩ ╚═╝  ╩ ╩╚═╝ ╩ ╩ ╩╚═╝═╩╝╚═╝
   private
      def set_user 
         @user = User.find(current_user.id)
      end

      def params_user
         params.require(:user).permit(:first_name, :last_name, :email, :password, 
            :password_confirmation, user_profile_attributes: [:id, :address, :gender, :birthdate, :avatar])
      end

      def verify_password
         if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
            params[:user].extract!(:password, :password_confirmation)
         end
      end
end
