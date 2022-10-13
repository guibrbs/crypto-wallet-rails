namespace :dev do
  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
    if Rails.env.development?
      show_spinner("Apagando o BD...") {%x(rails db:drop)}

      show_spinner("Criando o BD...") {%x(rails db:create)}

      show_spinner("Migrando o BD...") {%x(rails db:migrate)}

      show_spinner("Populando o BD...") {%x(rails db:seed)}
    else
      puts ("Você não está em ambiente de desenvolvimento!")
    end
  end

  private
  def show_spinner(description)
    spinner = TTY::Spinner.new("[:spinner] #{description}")
    spinner.auto_spin
    yield
    spinner.success('(Concluído com sucesso)')
  end
end
