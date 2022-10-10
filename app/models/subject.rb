class Subject < ApplicationRecord
  has_many :questions

  # ╔═╗╔═╗╦  ╦  ╔╗ ╔═╗╔═╗╦╔═╔═╗                       
  # ║  ╠═╣║  ║  ╠╩╗╠═╣║  ╠╩╗╚═╗                       
  # ╚═╝╩ ╩╩═╝╩═╝╚═╝╩ ╩╚═╝╩ ╩╚═╝
  after_create :set_statistics

  # Kaminari Pagination
  paginates_per 15

  # ╔═╗╦═╗╦╦  ╦╔═╗╔╦╗╔═╗  ╔╦╗╔═╗╔╦╗╦ ╦╔═╗╔╦╗╔═╗       
  # ╠═╝╠╦╝║╚╗╔╝╠═╣ ║ ║╣   ║║║║╣  ║ ╠═╣║ ║ ║║╚═╗       
  # ╩  ╩╚═╩ ╚╝ ╩ ╩ ╩ ╚═╝  ╩ ╩╚═╝ ╩ ╩ ╩╚═╝═╩╝╚═╝
  private
    def set_statistics
      AdminStatistic.set_event(AdminStatistic::EVENTS[:total_subjects])
    end
end
