class Site::AnswerController < SiteController
   def question
      @answer = Answer.find(params[:answer_id])
      # Creating or incrementing statistics
      UserStatistic.set_statistics(@answer, current_user)
   end     
end
