require 'csv'

keywords = CSV.read('keywords.csv', headers: true)

keywords.each do |k|
  p k
end