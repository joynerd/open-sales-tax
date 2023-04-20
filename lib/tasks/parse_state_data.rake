require 'csv'

namespace :parse_state_data do

  task washington: :environment do
    rate_text = File.read("#{Rails.root}/lib/sales_tax_data/united_states/washington/rates.csv")
    #locale_text = File.read("#{Rails.root}/lib/sales_tax_data/united_states/washington/locales.csv")

    rate_csv = CSV.parse(rate_text, headers: true)
    #locale_csv = CSV.parse(locale_text, headers: true)

    CSV.foreach("#{Rails.root}/lib/sales_tax_data/united_states/washington/locales.csv", headers: true) do |row|
      rate_row = rate_csv.find {|row| row['Code'] == '1702'}
      full_postal_code = "#{row['ZIP']}-#{row['PLUS4']}"
      postal_code = PostalCode.find_or_initialize_by(full: full_postal_code)
      postal_code.code = row['ZIP']
      postal_code.plus = row['PLUS4']
      postal_code.rate = (rate_row['Rate'].to_f * 1000).to_i
      postal_code.save
    end
  end

end
