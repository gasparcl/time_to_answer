class Question < ApplicationRecord
  belongs_to :subject

  # Kaminari Pagination
  paginates_per 15
end
