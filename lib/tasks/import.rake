require 'csv'
require('redis')

desc "Import"
task :import_products => :environment do
  file_name = Rails.root.to_s + '/lib/products.csv'
  redis = Redis.new
  puts 'started importing'
  CSV.foreach(file_name, :col_sep => ",", :headers => true) do |row|
    redis.hmset("products_"+row['Id'],'id',row['Id'],'title',row['Name'],"subtitle",row['Name'],'description',row['Descrption'],"item_url",row['URL'],'image_url',row['URL'],'category',row['Category'],'price',row['Price'],'quantity',row['Quantity'])
  end
end

