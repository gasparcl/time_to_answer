class AdminsBackoffice::QuestionsController < AdminsBackofficeController
   before_action :set_question, only: [:edit, :update, :destroy]
   before_action :get_subjects, only: [:new, :edit]
   
   def index
      #Variáveis de instância dentro de controllers são chamadas de variáveis de sessão, para serem utilizadas nas views...
      # O método includes, adiciona ao Model a ser exibido, o model de relacionamento, no caso abaixo, o subject, que tem muitas questões, evitando assim inúmeras queries desnecessárias no banco de dados - quando utilizamos o includes, o método .all fica implícito, tirando a necessidade do seu uso.
      #O método per define quantos objetos por página # A Ordenação por ID já é padrão, mas está explicitada para ficar clara a sintaxe - o símbolo :asc / :desc define a ordenação. O padrão é :asc
      @questions = Question.includes(:subject)
                           .order(description: :asc)
                           .page(params[:page]) 
   end

   def new
      @question = Question.new
   end

   def create
      @question = Question.new(get_params_question)
      if @question.save
         redirect_to admins_backoffice_questions_path, notice: "Question has been created"
      else 
         render :new
      end
   end

   def edit
   end

   def update
      if @question.update(get_params_question)
         redirect_to admins_backoffice_questions_path, notice: "Question has been updated"
      else 
         render :edit
      end
   end

   def destroy
      if @question.destroy
         redirect_to admins_backoffice_questions_path, notice: "Question has been deleted"
      else 
         render :index
      end
   end

   # ╔═╗╦═╗╦╦  ╦╔═╗╔╦╗╔═╗  ╔╦╗╔═╗╔╦╗╦ ╦╔═╗╔╦╗╔═╗
   # ╠═╝╠╦╝║╚╗╔╝╠═╣ ║ ║╣   ║║║║╣  ║ ╠═╣║ ║ ║║╚═╗
   # ╩  ╩╚═╩ ╚╝ ╩ ╩ ╩ ╚═╝  ╩ ╩╚═╝ ╩ ╩ ╩╚═╝═╩╝╚═╝
   private  

      def get_params_question # require from form body 
         params.require(:question)
               .permit(:description, :subject_id, answers_attributes: [:id, :description, :correct, :_destroy])
      end

      def set_question
         @question = Question.find(params[:id]) #Parâmetro vem da URL, setado em routes, com o resources
      end

      def get_subjects
         @subjects = Subject.all
      end
end
