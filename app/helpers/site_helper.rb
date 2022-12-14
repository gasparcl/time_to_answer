module SiteHelper
   def search_card_msg
      case params[:action]
      when 'index'
         t('site_layout.posts_list') 
      when 'questions'
         if(params[:term].strip != "" && @questions_count)
            t('site_layout.search.result', search_term: params[:term], questions_count: @questions_count)
         else
            t('site_layout.posts_list')
         end  
      when 'subject'
         t('site_layout.search.subject', subject: params[:subject])
      end  
   end

   def avatar_url
      if current_user.user_profile.avatar != nil
         avatar = current_user.user_profile.avatar
         avatar.attached? ? avatar : 'img.jpg'
      end
   end
end
