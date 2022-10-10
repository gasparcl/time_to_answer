namespace :dev do
  # ╔╦╗╔═╗╔╦╗╔═╗╔╦╗╔═╗╔╦╗╔═╗                   
  # ║║║║╣  ║ ╠═╣ ║║╠═╣ ║ ╠═╣                   
  # ╩ ╩╚═╝ ╩ ╩ ╩═╩╝╩ ╩ ╩ ╩ ╩
  counter = 0
  DEFAULT_PASSWORD = '123456'
  DEFAULT_FIRST_NAME = 'TEST'
  DEFAULT_LAST_NAME = 'USER TEST'
  DEFAULT_FILES_PATH = File.join(Rails.root, 'lib', 'tmp')

  # ╔╦╗╔═╗╦╔╗╔  ╔╦╗╔═╗╔═╗╦╔═            
  # ║║║╠═╣║║║║   ║ ╠═╣╚═╗╠╩╗            
  # ╩ ╩╩ ╩╩╝╚╝   ╩ ╩ ╩╚═╝╩ ╩  
  desc "Configure development environment and seed DB"
  # Comando para gerar a task - "rails g(generate) task namespace nome_da_task"
  task setup: :environment do
    if Rails.env.development?
      show_spinner("Dropping DB") { %x(rails db:drop) }
      show_spinner("Creating DB") { %x(rails db:create) }
      show_spinner("Migrating DB") { %x(rails db:migrate) }
      show_spinner("Creating default admin account") { %x(rails dev:add_default_admin) }
      show_spinner("Creating extra admin accounts") { %x(rails dev:add_extra_admins) }
      show_spinner("Creating default user account") { %x(rails dev:add_default_user) }
      show_spinner("Creating extra user accounts") { %x(rails dev:add_extra_users) }
      show_spinner("Seeding default subjects") { %x(rails dev:add_subjects) }
      show_spinner("Seeding questions and answers") { %x(rails dev:add_questions) }
    else
      puts "You are not in a development environment"
    end
  end

  # ╔╦╗╔═╗╔═╗╦╔═╔═╗                            
  #  ║ ╠═╣╚═╗╠╩╗╚═╗                            
  #  ╩ ╩ ╩╚═╝╩ ╩╚═╝
  desc "Create a default admin account"
  task add_default_admin: :environment do
    Admin.create!(
      email: 'admin@admin.com',
      password: DEFAULT_PASSWORD,
      password_confirmation: DEFAULT_PASSWORD
    )
  end

  desc "Create extra admin accounts"
  task add_extra_admins: :environment do
    9.times do |i|
      current_password = Faker::Internet.password
      Admin.create!(
        email: Faker::Internet.email,
        password: current_password,
        password_confirmation: current_password
      )
    end
  end

  desc "Create a default user account"
  task add_default_user: :environment do
    User.create!(
      email: 'user@user.com',
      password: DEFAULT_PASSWORD,
      password_confirmation: DEFAULT_PASSWORD,
      first_name: DEFAULT_FIRST_NAME,
      last_name: DEFAULT_LAST_NAME
    )
  end

  desc "Create extra user accounts"
  task add_extra_users: :environment do
    24.times do |i|
      User.create!(
        email: Faker::Internet.email,
        password: DEFAULT_PASSWORD,
        password_confirmation: DEFAULT_PASSWORD,
        first_name: DEFAULT_FIRST_NAME,
        last_name: `#{DEFAULT_LAST_NAME} - #{counter += 1}`
      )
    end  
  end

  desc "Add default subjects"
  task add_subjects: :environment do
    file_name = 'subjects.txt'
    file_path = File.join(DEFAULT_FILES_PATH, file_name)

    File.open(file_path, 'r').each do |subject|
      Subject.create!(description: subject.strip)
    end
  end

  desc "Add questions and answers"
  task add_questions: :environment do
    Subject.all.each do |subject|
      # rand gera um número randômico, no intervalo informado - entre 5 e 10 e o .times é para informar o laço de repeticao
      rand(5..10).times do |i|
        params = create_question_params(subject)
        answers_array = params[:question][:answers_attributes]

        add_answers(answers_array)
        
        set_correct_answer(answers_array)

        Question.create!(params[:question])
      end
    end
  end

  desc "Reset subjects counter"
  task reset_subject_counter: :environment do
    show_spinner("Reseting subject counters") do
      Subject.find_each do |subject| # o .find_each é exatamente a mesma coisa que o .all.each
        Subject.reset_counters(subject.id, :questions)
      end
    end
  end

  # ╔═╗╦═╗╦╦  ╦╔═╗╔╦╗╔═╗  ╔╦╗╔═╗╔╦╗╦ ╦╔═╗╔╦╗╔═╗
  # ╠═╝╠╦╝║╚╗╔╝╠═╣ ║ ║╣   ║║║║╣  ║ ╠═╣║ ║ ║║╚═╗
  # ╩  ╩╚═╩ ╚╝ ╩ ╩ ╩ ╚═╝  ╩ ╩╚═╝ ╩ ╩ ╩╚═╝═╩╝╚═╝
  private #apenas o namespace dev:setup terá acesso ao método

  def show_spinner(start_msg, end_msg="Done")
      spinner = TTY::Spinner.new("[:spinner] #{start_msg}...", format: :dots, interval: 18)
      spinner.auto_spin
      yield #O bloco de código yield deve ser inserido dentro de um do snippet, ou até entre chaves '{}', quando é apenas uma linha de execução
      spinner.success("(#{end_msg})")
  end
  
  def create_question_params(subject = Subject.all.sample)
    { 
      question: {
        description: "#{Faker::Lorem.paragraph} #{Faker::Lorem.question}",
        subject: subject,
        answers_attributes: []
      }
    }
  end

  def create_answer_params(correct = false)
    { description: Faker::Lorem.sentence, correct: correct }
  end

  def add_answers(array = [])
    rand(4..5).times do |a|
      array.push(create_answer_params)
    end
  end

  def set_correct_answer(array = [])
    # .size, neste caso, retorna 4 ou 5, por conta do método acima ter bloco do de execução, contudo o índice foi definido dessa forma para evitar bugs em refatoração de código:
    correct_answer_index = rand(array.size)

    # Inserindo a resposta correta pelo índice randômico: 
    array[correct_answer_index][:correct] = true 
  end  
end
