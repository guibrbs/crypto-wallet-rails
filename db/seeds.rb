# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

spinner = TTY::Spinner.new("[:spinner] Cadastrando moedas...")
spinner.auto_spin

coins = [
    {
        description: "Bitcoin",
        acronym: "BTC",
        url_image: "https://imagensemoldes.com.br/wp-content/uploads/2020/09/Imagem-Dinheiro-Bitcoin-PNG.png"
    },
    {
        description: "Ethereum",
        acronym: "ETH",
        url_image: "https://www.pngall.com/wp-content/uploads/10/Ethereum-Logo-PNG.png"
    },
    {
        description: "Dash",
        acronym: "DASH",
        url_image: "https://ico-wiki.com/wp-content/uploads/2018/08/dash-coin-price.png"
    },
]

coins.each do |coin|
    Coin.find_or_create_by!(coin)
end

spinner.success('(Concluído com sucesso)')