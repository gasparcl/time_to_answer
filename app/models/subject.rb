class Subject < ApplicationRecord
  has_many :questions

  # Kaminari Pagination
  paginates_per 15
end
