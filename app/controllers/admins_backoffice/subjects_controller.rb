class AdminsBackoffice::SubjectsController < AdminsBackofficeController
   before_action :set_subject, only: [:edit, :update, :destroy]
   
   def index
      #Variáveis de instância dentro de controllers são chamadas de variáveis de sessão, para serem utilizadas nas views...
      @subjects = Subject.all.order(:id).page(params[:page]) #O método per define quantos objetos por página # A Ordenação por ID já é padrão, mas está explicitada para ficar clara a sintaxe
   end

   def new
      @subject = Subject.new
   end

   def create
      @subject = Subject.new(get_params_subject)
      if @subject.save
         redirect_to admins_backoffice_subjects_path, notice: "Subject/Area has been created"
      else 
         render :new
      end
   end

   def edit
   end

   def update
      if @subject.update(get_params_subject)
         redirect_to admins_backoffice_subjects_path, notice: "Subject/Area has been updated"
      else 
         render :edit
      end
   end

   def destroy
      if @subject.destroy
         redirect_to admins_backoffice_subjects_path, notice: "Subject/Area has been deleted"
      else 
         render :index
      end
   end

   # ╔═╗╦═╗╦╦  ╦╔═╗╔╦╗╔═╗  ╔╦╗╔═╗╔╦╗╦ ╦╔═╗╔╦╗╔═╗
   # ╠═╝╠╦╝║╚╗╔╝╠═╣ ║ ║╣   ║║║║╣  ║ ╠═╣║ ║ ║║╚═╗
   # ╩  ╩╚═╩ ╚╝ ╩ ╩ ╩ ╚═╝  ╩ ╩╚═╝ ╩ ╩ ╩╚═╝═╩╝╚═╝
   private  

      def set_subject
         @subject = Subject.find(params[:id]) #Parâmetro vem da URL, setado em routes, com o resources
      end

      def get_params_subject
         params.require(:subject).permit(:description)
      end
end
