class Question < ApplicationRecord
  # ╔═╗╔═╗╔═╗╔═╗╔═╗╦╔═╗╔╦╗╦╔═╗╔╗╔╔═╗
  # ╠═╣╚═╗╚═╗║ ║║  ║╠═╣ ║ ║║ ║║║║╚═╗
  # ╩ ╩╚═╝╚═╝╚═╝╚═╝╩╩ ╩ ╩ ╩╚═╝╝╚╝╚═╝
  belongs_to :subject, counter_cache: true, inverse_of: :questions
  has_many :answers
  accepts_nested_attributes_for :answers, reject_if: :all_blank, allow_destroy: true
  
  # Kaminari Pagination
  paginates_per 15

  # ╔═╗╔═╗╔═╗╔═╗╔═╗╔═╗
  # ╚═╗║  ║ ║╠═╝║╣ ╚═╗ # Utilizados apenas como método de pesquisa no Banco de dados
  # ╚═╝╚═╝╚═╝╩  ╚═╝╚═╝
  scope :search, -> (page, term) {
    includes(:answers, :subject)
    .where("lower(description) LIKE ?", "%#{term.downcase}%")
    .order('created_at desc') 
    .page(page)

    # O método de pesquisa LIKE não deve ser utilizado em tabelas com um número muito grande de registros, pois ele percorre linha por linha da tabela, se tornando então um processo muito custoso e demorado... O método padrão mais indicado é o full-text, pois é mais rápido, performático e menos custoso.
  } 

  scope :search_count, -> (term) {
    includes(:answers, :subject)
    .where("lower(description) LIKE ?", "%#{term.downcase}%")

    # O método de pesquisa LIKE não deve ser utilizado em tabelas com um número muito grande de registros, pois ele percorre linha por linha da tabela, se tornando então um processo muito custoso e demorado... O método padrão mais indicado é o full-text, pois é mais rápido, performático e menos custoso.
  } 

  scope :search_subject, -> (page, subject_id) {
    includes(:answers, :subject)
    .where(subject_id: subject_id) #neste caso não utilizamos o LIKE, pois queremos o valor de id exato do assunto para ser comparado e filtrado
    .page(page)
  }

  scope :last_questions, -> (page) {
    includes(:answers, :subject)
    .order('created_at desc')
    .page(page)
  }

end
