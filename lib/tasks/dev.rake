namespace :dev do
  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
    if Rails.env.development?
      show_spinner("Apagando o BD...") {%x(rails db:drop)}
      show_spinner("Criando o BD...") {%x(rails db:create)}
      show_spinner("Migrando o BD...") {%x(rails db:migrate)}
      %x(rails dev:add_mining_types)
      %x(rails dev:add_coins)
    else
      puts ("Você não está em ambiente de desenvolvimento!")
    end
  end

  desc "Cadastra as moedas"
  task add_coins: :environment do
    show_spinner("Cadastrando moedas...") do
      coins = [
          {
              description: "Bitcoin",
              acronym: "BTC",
              url_image: "https://imagensemoldes.com.br/wp-content/uploads/2020/09/Imagem-Dinheiro-Bitcoin-PNG.png",
              mining_type: MiningType.find_by(acronym: 'PoW')
          },
          {
              description: "Ethereum",
              acronym: "ETH",
              url_image: "https://www.pngall.com/wp-content/uploads/10/Ethereum-Logo-PNG.png",
              mining_type: MiningType.all.sample,
          },
          {
              description: "Dash",
              acronym: "DASH",
              url_image: "https://ico-wiki.com/wp-content/uploads/2018/08/dash-coin-price.png",
              mining_type: MiningType.all.sample
          },
      ]

      coins.each do |coin|
          Coin.find_or_create_by!(coin)
      end
    end
  end

  desc "Cadastra os tipos de mineração"
  task add_mining_types: :environment do
    show_spinner("Cadastrando os tipos de mineração...") do
      mining_types = [
        {description: "Proof of Work", acronym: "PoW"},
        {description: "Proof of Stake", acronym: "PoS"},
        {description: "Proof of Capacity", acronym: "PoC"}
      ]
      mining_types.each do |mining_type|
        MiningType.find_or_create_by!(mining_type)
      end
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
