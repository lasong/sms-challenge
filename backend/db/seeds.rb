# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

require 'json'

json_from_file = File.read("#{Rails.root}/db/data/data.json")
data = JSON.parse(json_from_file)

data.each do |hsh|
  attributes = {
    id: hsh['id'],
    city: hsh['city'],
    start_date: Date.strptime(hsh['start_date'], '%m/%d/%Y'),
    end_date: Date.strptime(hsh['end_date'], '%m/%d/%Y'),
    price: hsh['price'].to_f,
    status: hsh['status'],
    color: hsh['color']
  }

  Information.create(attributes)
end
