prawn_document do |pdf|
   pdf.text "Listando Assuntos/Áreas", :align => :center, :size => 22
   pdf.move_down 20
   pdf.table @subjects.collect{|s| [s.id, s.description, s.questions.size, s.created_at.strftime('%d/%m/%Y')]}
end