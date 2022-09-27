# ╔╦╗╔═╗╦╔╗╔  ╔╦╗╔═╗╔═╗╦╔═            
# ║║║╠═╣║║║║   ║ ╠═╣╚═╗╠╩╗            
# ╩ ╩╩ ╩╩╝╚╝   ╩ ╩ ╩╚═╝╩ ╩  
namespace :dev do
  DEFAULT_PASSWORD = '123456'

  desc "Configure development environment and seed DB"
  # Comando para gerar a task - "rails g(generate) task namespace nome_da_task"
  task setup: :environment do
    if Rails.env.development?
      show_spinner("Dropping DB...") { %x(rails db:drop) }
      show_spinner("Creating DB...") { %x(rails db:create) }
      show_spinner("Migrating DB...") { %x(rails db:migrate) }
      show_spinner("Creating default admin account...") { %x(rails dev:add_default_admin) }
      show_spinner("Creating extra admin accounts...") { %x(rails dev:add_extra_admins) }
      show_spinner("Creating default user account...") { %x(rails dev:add_default_user) }
    else
      puts "You are not in a development environment"
    end
  end

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
    10.times do |i|
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
      password_confirmation: DEFAULT_PASSWORD
    )
  end

  # ╔╦╗╔═╗╔╦╗╦ ╦╔═╗╔╦╗╔═╗               
  # ║║║║╣  ║ ╠═╣║ ║ ║║╚═╗               
  # ╩ ╩╚═╝ ╩ ╩ ╩╚═╝═╩╝╚═╝
  private #apenas o namespace dev:setup terá acesso ao método
  def show_spinner(start_msg, end_msg="Done")
      spinner = TTY::Spinner.new("[:spinner] #{start_msg}...", format: :dots, interval: 18)
      spinner.auto_spin
      yield #O bloco de código yield deve ser inserido dentro de um do snippet, ou até entre chaves '{}', quando é apenas uma linha de execução
      spinner.success("(#{end_msg})")
  end
end
