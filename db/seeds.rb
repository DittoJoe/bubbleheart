require 'open-uri'
require 'nokogiri'
require 'dotenv'

puts "Initializing..."

def handle_string_io_as_file(io, filename)
  return io unless io.class == StringIO
  file = Tempfile.new(["temp",".png"], encoding: 'ascii-8bit')
  file.binmode
  file.write io.read
  file.open
end

puts "Deleting current items..."

Shop.destroy_all
User.destroy_all
Bookmark.destroy_all
Review.destroy_all

puts "Creating users..."

User.create(email: 'info@bubblehe.art', password: ENV['ADMIN_PASSWORD'], username: 'bubbleheart', admin: true)
User.create(email: 'joseph.jf.rohde@gmail.com', password: ENV['USER_PASSWORD'], username: 'DittoJoe', admin: false)
User.create(email: 'test@bubblehe.art', password: '123456', username: 'Test1', admin: false)

puts "Creating shops..."

img_prefix = "https://www.visitstockholm.com/media/images/"
img_suffix = ".width-768.jpg"

shop = Shop.new(name: 'Cha Talk', address: 'Rådmansgatan 58',  details: 'Popular Cha Talk in Vasastan serves bubble tea, juice tea and flavored milk tea in various blends. For a lighter snack there are also egg waffles on the menu to go with your drink.')
file = URI.open("#{img_prefix}2021-06-10_CHA_TALK_3#{img_suffix}")
shop.photos.attach(io: handle_string_io_as_file(file, 'image.png'), filename: 'shop.png', content_type: 'image/png')
shop.save

shop_two = Shop.new(name: 'Machi Machi', address: 'Sergelgatan 29', details: 'Machi Machi is a tea house catering to sweet-tooths. Choose between Créme Brulee, Strawberry with cream cheese, or a zesty tea with fresh fruits. They also have a large selection of Taiwanese "boba teas"; flavored teas with sweet and chewy tapioca bubbles.')
file = URI.open("#{img_prefix}machi-machi#{img_suffix}")
shop_two.photos.attach(io: handle_string_io_as_file(file, 'image.png'), filename: 'shop_two.png', content_type: 'image/png')
shop_two.save

shop_three = Shop.new(name: 'Ninecha', address: 'Katarinavägen 20', details: 'Ninecha Milk Tea on Katarinagatan serves chilled tea drinks in various flavors. Refreshingly fruity, creamy or in different sweet bubble tea-variants.')
file = URI.open("#{img_prefix}Dirty_DirtyDirty_Green#{img_suffix}")
shop_three.photos.attach(io: handle_string_io_as_file(file, 'image.png'), filename: 'shop_three.png', content_type: 'image/png')
shop_three.save

shop_four = Shop.new(name: 'Yi Fang', address: 'Mäster Samuelsgatan 38', details: 'The bubble tea-café Yi Fang serves fruity and refreshing drinks made from only natural ingredients.')
file = URI.open("#{img_prefix}yi-fang#{img_suffix}")
shop_four.photos.attach(io: handle_string_io_as_file(file, 'image.png'), filename: 'shop_four.png', content_type: 'image/png')
shop_four.save

puts "Done!"
