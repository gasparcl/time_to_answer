class UserProfile < ApplicationRecord
  belongs_to :user
  # Método herdado do active storage, instalado na raiz da app. rails active_storage:install, que serve para adicionar anexos e arquivos(blobs) à DB.
  has_one_attached :avatar
end
