class Site::SearchController < SiteController
   def questions
      @questions = Question.search(params[:page], params[:term].strip) # foi utilizado o método strip para evitar buscas indesejáveis de perguntas apenas com espaços vazios em branco...

      if(params[:term].strip != "")
         @questions_count = Question.search_count(params[:term].strip).count
      else
         @questions_count = 0
      end
   end

   def subject
      @questions = Question.search_subject(params[:page], params[:subject_id])
   end
end
