class AdminsBackoffice::AdminsController < AdminsBackofficeController
  before_action :verify_password, only: [:update]
  before_action :set_admin, only: [:edit, :update, :destroy]
  
  def index
    @admins = Admin.all #Variáveis de instância dentro de controllers são chamadas de variáveis de sessão, para serem utilizadas nas views...
  end

  def new
    @admin = Admin.new
  end

  def create
    @admin = Admin.new(get_params_admin)
    if @admin.save
      redirect_to admins_backoffice_admins_path, notice: "Admin account has been created"
    else 
      render :new
    end
  end

  def edit
  end

  def update
    if @admin.update(get_params_admin)
      redirect_to admins_backoffice_admins_path, notice: "Admin account has been updated"
    else 
      render :edit
    end
  end

  def destroy
    if @admin.destroy
      redirect_to admins_backoffice_admins_path, notice: "Admin account has been deleted"
    else 
      render :index
    end
  end

  # ╔═╗╦═╗╦╦  ╦╔═╗╔╦╗╔═╗  ╔╦╗╔═╗╔╦╗╦ ╦╔═╗╔╦╗╔═╗
  # ╠═╝╠╦╝║╚╗╔╝╠═╣ ║ ║╣   ║║║║╣  ║ ╠═╣║ ║ ║║╚═╗
  # ╩  ╩╚═╩ ╚╝ ╩ ╩ ╩ ╚═╝  ╩ ╩╚═╝ ╩ ╩ ╩╚═╝═╩╝╚═╝
  private  

  def set_admin
    @admin = Admin.find(params[:id]) #Parâmetro vem da URL, setado em routes, com o resources
  end

  def get_params_admin
    params.require(:admin).permit(:email, :password, :password_confirmation)
  end

  def verify_password
    if params[:admin][:password].blank? && params[:admin][:password_confirmation].blank?
      params[:admin].extract!(:password, :password_confirmation)
    end
  end
end
