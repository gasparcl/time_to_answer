class AdminStatistic < ApplicationRecord
   # ╔╦╗╔═╗╔╦╗╔═╗╔╦╗╔═╗╔╦╗╔═╗                          
   # ║║║║╣  ║ ╠═╣ ║║╠═╣ ║ ╠═╣                          
   # ╩ ╩╚═╝ ╩ ╩ ╩═╩╝╩ ╩ ╩ ╩ ╩
   EVENTS = {
      total_users: "TOTAL_USERS",
      total_subjects: "TOTAL_SUBJECTS",
      total_questions: "TOTAL_QUESTIONS"
   }

   # ╔═╗╔═╗╔═╗╔═╗╔═╗╔═╗                                
   # ╚═╗║  ║ ║╠═╝║╣ ╚═╗                                
   # ╚═╝╚═╝╚═╝╩  ╚═╝╚═╝ 
   scope :total_users, -> {
      find_by_event(EVENTS[:total_users]).value
   }

   scope :total_subjects, -> {
      find_by_event(EVENTS[:total_subjects]).value
   }

   scope :total_questions, -> {
      find_by_event(EVENTS[:total_questions]).value
   }

   # ╔═╗╦  ╔═╗╔═╗╔═╗  ╔╦╗╔═╗╔╦╗╦ ╦╔═╗╔╦╗╔═╗            
   # ║  ║  ╠═╣╚═╗╚═╗  ║║║║╣  ║ ╠═╣║ ║ ║║╚═╗            
   # ╚═╝╩═╝╩ ╩╚═╝╚═╝  ╩ ╩╚═╝ ╩ ╩ ╩╚═╝═╩╝╚═╝
   def self.set_event(event)
      admin_statistics = AdminStatistic.find_or_create_by(event: event)
      admin_statistics.value += 1
      admin_statistics.save      
   end
end
