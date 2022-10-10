class UserStatistic < ApplicationRecord
  belongs_to :user

  # ╦  ╦╦╦═╗╔╦╗╦ ╦╔═╗╦    ╔═╗╔╦╗╔╦╗╦═╗╦╔╗ ╦ ╦╔╦╗╔═╗╔═╗
  # ╚╗╔╝║╠╦╝ ║ ║ ║╠═╣║    ╠═╣ ║  ║ ╠╦╝║╠╩╗║ ║ ║ ║╣ ╚═╗
  #  ╚╝ ╩╩╚═ ╩ ╚═╝╩ ╩╩═╝  ╩ ╩ ╩  ╩ ╩╚═╩╚═╝╚═╝ ╩ ╚═╝╚═╝
  def total_questions
    self.right_questions + self.wrong_questions
  end

  # ╔═╗╦  ╔═╗╔═╗╔═╗  ╔╦╗╔═╗╔╦╗╦ ╦╔═╗╔╦╗╔═╗            
  # ║  ║  ╠═╣╚═╗╚═╗  ║║║║╣  ║ ╠═╣║ ║ ║║╚═╗            
  # ╚═╝╩═╝╩ ╩╚═╝╚═╝  ╩ ╩╚═╝ ╩ ╩ ╩╚═╝═╩╝╚═╝
  def self.set_statistics(answer, current_user)
    if !!current_user
      user_statistics = UserStatistic.find_or_create_by(user: current_user)
      answer.correct? ? user_statistics.right_questions += 1 : user_statistics.wrong_questions += 1
      user_statistics.save 
    end
  end

end

