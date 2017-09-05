require 'HTTParty'
require 'Nokogiri'
require 'JSON'
require 'Pry'
require 'csv'

#variable to store url of page being scraped
page = HTTParty.get('https://sfbay.craigslist.org/search/pet?s=0')

#transforming http response into nokogiri object
parse_page = Nokogiri::HTML(page)

#empty array to store all the pets
pets_array = []

#parsing the data
parse_page.css('.content').css('.result-row').css('.hdrlnk').map do |a|
  post_name = a.text
  pets_array.push(post_name)
end

#push data from array into CSV file
CSV.open('pets.csv', 'w') do |csv|
  csv << pets_array
end

#Pry.start(binding)
