class AdminMailer < ApplicationMailer
   # In this case, the affected_admin will receive an email, if any other admin(current_admin) make some update in its account.
   def update_email(current_admin, affected_admin)
      @current_admin = current_admin
      @admin = affected_admin

      mail(to: @admin.email, subject: "Seus dados foram alterados!" )
   end
end
