class ChatParser

  def parse message
    if ((message['type'].upcase == 'text'.upcase) and message['user'].upcase != 'BOT')
     call_bot(message['payload']) if string_has_dave(message['payload'])
   else
    puts "<<<<<<<<<<<<<<<<<<<<<<<<Do  Nothing >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
  end
end


def string_has_dave(str)
  return true if str.include?("Dave") or str.include?("dave")
end

def call_bot(str)
  puts "<<<<<<<<<<<<<<<<<<,Do Something >>>>>>>>>>>>>>>>....."
  base_uri = 'https://tescohack.firebaseio.com/'

  firebase = Firebase::Client.new(base_uri)
  response = firebase.push("messages", generic)
  # response = firebase.push("messages", { :user => 'bot ', :type => "Text", :payload => "Hello is it working now ?" })
end


def generic(products)
  {"type": "GENERIC","user": "bot","payload": elements_array(products)}
end

def elements_array(products)
   products_array = add_products(products)
   {"elements": products_array}.to_s
end

def button
  {"user": "bot","type": "BUTTON","payload": '{"text": "What do you want to do next?","buttons": [{"type": "web_url","action": "https://petersapparel.parseapp.com","title": "Show Website"},{"type": "postback","title": "Start Chatting","action": "USER_DEFINED_PAYLOAD"}]}'}
end

def add_products(products)
  arr = []
  products.each do |product|
    arr << product_info(product)
  end
  return arr
end

def product_info(product)
  {"title": product['title'],"item_url": product['item_url'],"image_url": product['image_url'],"subtitle": product['subtitle'],"buttons": [{"type": "web_url","title": "View Website","action": "http://img.tesco.com/Groceries/pi/457/5000436589457/IDShot_225x225.jpg"},{"type": "postback","title": "Start Chatting","action": "https://petersfancybrownhats.com"}]}
end

def generic_bkp
  {"type": "GENERIC","user": "bot","payload": '{"elements": [{"title": "Welcome to Peter s Hats","item_url": "https://petersfancybrownhats.com","image_url": "https://petersfancybrownhats.com/company_image.png","subtitle": "We ve got the right hat for everyone.","buttons": [{"type": "web_url","title": "View Website","action": "http://img.tesco.com/Groceries/pi/457/5000436589457/IDShot_225x225.jpg"},{"type": "postback","title": "Start Chatting","action": "https://petersfancybrownhats.com"}]},{"title": "Welcome to Peter s Hats","item_url": "http://img.tesco.com/Groceries/pi/457/5000436589457/IDShot_225x225.jpg","image_url": "http://img.tesco.com/Groceries/pi/457/5000436589457/IDShot_225x225.jpg","subtitle": "We ve got the right hat for everyone.","buttons": [{"type": "web_url","title": "View Website","action": "http://img.tesco.com/Groceries/pi/457/5000436589457/IDShot_225x225.jpg"},{"type": "postback","title": "Start Chatting","action": "http://img.tesco.com/Groceries/pi/457/5000436589457/IDShot_225x225.jpg"}]},{"title": "Welcome to Peter s Hats","item_url": "http://img.tesco.com/Groceries/pi/457/5000436589457/IDShot_225x225.jpg","image_url": "https://petersfancybrownhats.com/company_image.png","subtitle": "We ve got the right hat for everyone.","buttons": [{"type": "web_url","title": "View Website","action": "http://img.tesco.com/Groceries/pi/457/5000436589457/IDShot_225x225.jpg"},{"type": "postback","title": "Start Chatting","action": "http://img.tesco.com/Groceries/pi/457/5000436589457/IDShot_225x225.jpg"}]}]}'}
end


def button_bkp
  {"user": "bot","type": "BUTTON","payload": '{"text": "What do you want to do next?","buttons": [{"type": "web_url","action": "https://petersapparel.parseapp.com","title": "Show Website"},{"type": "postback","title": "Start Chatting","action": "USER_DEFINED_PAYLOAD"}]}'}
end

def parse message
    if ((message['type'].upcase == 'text'.upcase) and message['user'].upcase != 'BOT')
     call_bot(message['payload']) if string_has_dave(message['payload'])
   else
    puts "<<<<<<<<<<<<<<<<<<<<<<<<Do  Nothing >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
  end
end


def string_has_dave(str)
  return true if str.include?("Dave") or str.include?("dave")
end

def call_bot(str)
  puts "<<<<<<<<<<<<<<<<<<,Do Something >>>>>>>>>>>>>>>>....."
  base_uri = 'https://tescohack.firebaseio.com/'

  firebase = Firebase::Client.new(base_uri)
  response = firebase.push("messages", generic)
  # response = firebase.push("messages", { :user => 'bot ', :type => "Text", :payload => "Hello is it working now ?" })
end


def generic(products)
  {"type": "GENERIC","user": "bot","payload": elements_array(products)}
end

def elements_array(products)
   products_array = add_products(products)
   {"elements": products_array}.to_s
end

def button
  {"user": "bot","type": "BUTTON","payload": '{"text": "What do you want to do next?","buttons": [{"type": "web_url","action": "https://petersapparel.parseapp.com","title": "Show Website"},{"type": "postback","title": "Start Chatting","action": "USER_DEFINED_PAYLOAD"}]}'}
end

def add_products(products)
  arr = []
  products.each do |product|
    arr << product_info(product)
  end
  return arr
end

def product_info(product)
  {"title": product['title'],"item_url": product['item_url'],"image_url": product['image_url'],"subtitle": product['subtitle'],"buttons": [{"type": "web_url","title": "View Website","action": "http://img.tesco.com/Groceries/pi/457/5000436589457/IDShot_225x225.jpg"},{"type": "postback","title": "Start Chatting","action": "https://petersfancybrownhats.com"}]}
end

def generic_bkp
  {"type": "GENERIC","user": "bot","payload": '{"elements": [{"title": "Welcome to Peter s Hats","item_url": "https://petersfancybrownhats.com","image_url": "https://petersfancybrownhats.com/company_image.png","subtitle": "We ve got the right hat for everyone.","buttons": [{"type": "web_url","title": "View Website","action": "http://img.tesco.com/Groceries/pi/457/5000436589457/IDShot_225x225.jpg"},{"type": "postback","title": "Start Chatting","action": "https://petersfancybrownhats.com"}]},{"title": "Welcome to Peter s Hats","item_url": "http://img.tesco.com/Groceries/pi/457/5000436589457/IDShot_225x225.jpg","image_url": "http://img.tesco.com/Groceries/pi/457/5000436589457/IDShot_225x225.jpg","subtitle": "We ve got the right hat for everyone.","buttons": [{"type": "web_url","title": "View Website","action": "http://img.tesco.com/Groceries/pi/457/5000436589457/IDShot_225x225.jpg"},{"type": "postback","title": "Start Chatting","action": "http://img.tesco.com/Groceries/pi/457/5000436589457/IDShot_225x225.jpg"}]},{"title": "Welcome to Peter s Hats","item_url": "http://img.tesco.com/Groceries/pi/457/5000436589457/IDShot_225x225.jpg","image_url": "https://petersfancybrownhats.com/company_image.png","subtitle": "We ve got the right hat for everyone.","buttons": [{"type": "web_url","title": "View Website","action": "http://img.tesco.com/Groceries/pi/457/5000436589457/IDShot_225x225.jpg"},{"type": "postback","title": "Start Chatting","action": "http://img.tesco.com/Groceries/pi/457/5000436589457/IDShot_225x225.jpg"}]}]}'}
end


def button_bkp
  {"user": "bot","type": "BUTTON","payload": '{"text": "What do you want to do next?","buttons": [{"type": "web_url","action": "https://petersapparel.parseapp.com","title": "Show Website"},{"type": "postback","title": "Start Chatting","action": "USER_DEFINED_PAYLOAD"}]}'}
end

def parse message
    if ((message['type'].upcase == 'text'.upcase) and message['user'].upcase != 'BOT')
     call_bot(message['payload']) if string_has_dave(message['payload'])
   else
    puts "<<<<<<<<<<<<<<<<<<<<<<<<Do  Nothing >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
  end
end


def string_has_dave(str)
  return true if str.include?("Dave") or str.include?("dave")
end

def call_bot(str)
  puts "<<<<<<<<<<<<<<<<<<,Do Something >>>>>>>>>>>>>>>>....."
  base_uri = 'https://tescohack.firebaseio.com/'

  firebase = Firebase::Client.new(base_uri)
  response = firebase.push("messages", generic)
  # response = firebase.push("messages", { :user => 'bot ', :type => "Text", :payload => "Hello is it working now ?" })
end


def generic(products)
  {"type": "GENERIC","user": "bot","payload": elements_array(products)}
end

def elements_array(products)
   products_array = add_products(products)
   {"elements": products_array}.to_s
end

def button
  {"user": "bot","type": "BUTTON","payload": '{"text": "What do you want to do next?","buttons": [{"type": "web_url","action": "https://petersapparel.parseapp.com","title": "Show Website"},{"type": "postback","title": "Start Chatting","action": "USER_DEFINED_PAYLOAD"}]}'}
end

def add_products(products)
  arr = []
  products.each do |product|
    arr << product_info(product)
  end
  return arr
end

def product_info(product)
  {"title": product['title'],"item_url": product['item_url'],"image_url": product['image_url'],"subtitle": product['subtitle'],"buttons": [{"type": "web_url","title": "View Website","action": "http://img.tesco.com/Groceries/pi/457/5000436589457/IDShot_225x225.jpg"},{"type": "postback","title": "Start Chatting","action": "https://petersfancybrownhats.com"}]}
end

def generic_bkp
  {"type": "GENERIC","user": "bot","payload": '{"elements": [{"title": "Welcome to Peter s Hats","item_url": "https://petersfancybrownhats.com","image_url": "https://petersfancybrownhats.com/company_image.png","subtitle": "We ve got the right hat for everyone.","buttons": [{"type": "web_url","title": "View Website","action": "http://img.tesco.com/Groceries/pi/457/5000436589457/IDShot_225x225.jpg"},{"type": "postback","title": "Start Chatting","action": "https://petersfancybrownhats.com"}]},{"title": "Welcome to Peter s Hats","item_url": "http://img.tesco.com/Groceries/pi/457/5000436589457/IDShot_225x225.jpg","image_url": "http://img.tesco.com/Groceries/pi/457/5000436589457/IDShot_225x225.jpg","subtitle": "We ve got the right hat for everyone.","buttons": [{"type": "web_url","title": "View Website","action": "http://img.tesco.com/Groceries/pi/457/5000436589457/IDShot_225x225.jpg"},{"type": "postback","title": "Start Chatting","action": "http://img.tesco.com/Groceries/pi/457/5000436589457/IDShot_225x225.jpg"}]},{"title": "Welcome to Peter s Hats","item_url": "http://img.tesco.com/Groceries/pi/457/5000436589457/IDShot_225x225.jpg","image_url": "https://petersfancybrownhats.com/company_image.png","subtitle": "We ve got the right hat for everyone.","buttons": [{"type": "web_url","title": "View Website","action": "http://img.tesco.com/Groceries/pi/457/5000436589457/IDShot_225x225.jpg"},{"type": "postback","title": "Start Chatting","action": "http://img.tesco.com/Groceries/pi/457/5000436589457/IDShot_225x225.jpg"}]}]}'}
end


def button_bkp
  {"user": "bot","type": "BUTTON","payload": '{"text": "What do you want to do next?","buttons": [{"type": "web_url","action": "https://petersapparel.parseapp.com","title": "Show Website"},{"type": "postback","title": "Start Chatting","action": "USER_DEFINED_PAYLOAD"}]}'}
end

def parse message
    if ((message['type'].upcase == 'text'.upcase) and message['user'].upcase != 'BOT')
     call_bot(message['payload']) if string_has_dave(message['payload'])
   else
    puts "<<<<<<<<<<<<<<<<<<<<<<<<Do  Nothing >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
  end
end


def string_has_dave(str)
  return true if str.include?("Dave") or str.include?("dave")
end

def call_bot(str)
  puts "<<<<<<<<<<<<<<<<<<,Do Something >>>>>>>>>>>>>>>>....."
  base_uri = 'https://tescohack.firebaseio.com/'

  firebase = Firebase::Client.new(base_uri)
  response = firebase.push("messages", generic)
  # response = firebase.push("messages", { :user => 'bot ', :type => "Text", :payload => "Hello is it working now ?" })
end


def generic(products)
  {"type": "GENERIC","user": "bot","payload": elements_array(products)}
end

def elements_array(products)
   products_array = add_products(products)
   {"elements": products_array}.to_s
end

def button
  {"user": "bot","type": "BUTTON","payload": '{"text": "What do you want to do next?","buttons": [{"type": "web_url","action": "https://petersapparel.parseapp.com","title": "Show Website"},{"type": "postback","title": "Start Chatting","action": "USER_DEFINED_PAYLOAD"}]}'}
end

def add_products(products)
  arr = []
  products.each do |product|
    arr << product_info(product)
  end
  return arr
end

def product_info(product)
  {"title": product['title'],"item_url": product['item_url'],"image_url": product['image_url'],"subtitle": product['subtitle'],"buttons": [{"type": "web_url","title": "View Website","action": "http://img.tesco.com/Groceries/pi/457/5000436589457/IDShot_225x225.jpg"},{"type": "postback","title": "Start Chatting","action": "https://petersfancybrownhats.com"}]}
end

def generic_bkp
  {"type": "GENERIC","user": "bot","payload": '{"elements": [{"title": "Welcome to Peter s Hats","item_url": "https://petersfancybrownhats.com","image_url": "https://petersfancybrownhats.com/company_image.png","subtitle": "We ve got the right hat for everyone.","buttons": [{"type": "web_url","title": "View Website","action": "http://img.tesco.com/Groceries/pi/457/5000436589457/IDShot_225x225.jpg"},{"type": "postback","title": "Start Chatting","action": "https://petersfancybrownhats.com"}]},{"title": "Welcome to Peter s Hats","item_url": "http://img.tesco.com/Groceries/pi/457/5000436589457/IDShot_225x225.jpg","image_url": "http://img.tesco.com/Groceries/pi/457/5000436589457/IDShot_225x225.jpg","subtitle": "We ve got the right hat for everyone.","buttons": [{"type": "web_url","title": "View Website","action": "http://img.tesco.com/Groceries/pi/457/5000436589457/IDShot_225x225.jpg"},{"type": "postback","title": "Start Chatting","action": "http://img.tesco.com/Groceries/pi/457/5000436589457/IDShot_225x225.jpg"}]},{"title": "Welcome to Peter s Hats","item_url": "http://img.tesco.com/Groceries/pi/457/5000436589457/IDShot_225x225.jpg","image_url": "https://petersfancybrownhats.com/company_image.png","subtitle": "We ve got the right hat for everyone.","buttons": [{"type": "web_url","title": "View Website","action": "http://img.tesco.com/Groceries/pi/457/5000436589457/IDShot_225x225.jpg"},{"type": "postback","title": "Start Chatting","action": "http://img.tesco.com/Groceries/pi/457/5000436589457/IDShot_225x225.jpg"}]}]}'}
end


def button_bkp
  {"user": "bot","type": "BUTTON","payload": '{"text": "What do you want to do next?","buttons": [{"type": "web_url","action": "https://petersapparel.parseapp.com","title": "Show Website"},{"type": "postback","title": "Start Chatting","action": "USER_DEFINED_PAYLOAD"}]}'}
end

def parse message
    if ((message['type'].upcase == 'text'.upcase) and message['user'].upcase != 'BOT')
     call_bot(message['payload']) if string_has_dave(message['payload'])
   else
    puts "<<<<<<<<<<<<<<<<<<<<<<<<Do  Nothing >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
  end
end


def string_has_dave(str)
  return true if str.include?("Dave") or str.include?("dave")
end

def call_bot(str)
  puts "<<<<<<<<<<<<<<<<<<,Do Something >>>>>>>>>>>>>>>>....."
  base_uri = 'https://tescohack.firebaseio.com/'

  firebase = Firebase::Client.new(base_uri)
  response = firebase.push("messages", generic)
  # response = firebase.push("messages", { :user => 'bot ', :type => "Text", :payload => "Hello is it working now ?" })
end


def generic(products)
  {"type": "GENERIC","user": "bot","payload": elements_array(products)}
end

def elements_array(products)
   products_array = add_products(products)
   {"elements": products_array}.to_s
end

def button
  {"user": "bot","type": "BUTTON","payload": '{"text": "What do you want to do next?","buttons": [{"type": "web_url","action": "https://petersapparel.parseapp.com","title": "Show Website"},{"type": "postback","title": "Start Chatting","action": "USER_DEFINED_PAYLOAD"}]}'}
end

def add_products(products)
  arr = []
  products.each do |product|
    arr << product_info(product)
  end
  return arr
end

def product_info(product)
  {"title": product['title'],"item_url": product['item_url'],"image_url": product['image_url'],"subtitle": product['subtitle'],"buttons": [{"type": "web_url","title": "View Website","action": "http://img.tesco.com/Groceries/pi/457/5000436589457/IDShot_225x225.jpg"},{"type": "postback","title": "Start Chatting","action": "https://petersfancybrownhats.com"}]}
end

def generic_bkp
  {"type": "GENERIC","user": "bot","payload": '{"elements": [{"title": "Welcome to Peter s Hats","item_url": "https://petersfancybrownhats.com","image_url": "https://petersfancybrownhats.com/company_image.png","subtitle": "We ve got the right hat for everyone.","buttons": [{"type": "web_url","title": "View Website","action": "http://img.tesco.com/Groceries/pi/457/5000436589457/IDShot_225x225.jpg"},{"type": "postback","title": "Start Chatting","action": "https://petersfancybrownhats.com"}]},{"title": "Welcome to Peter s Hats","item_url": "http://img.tesco.com/Groceries/pi/457/5000436589457/IDShot_225x225.jpg","image_url": "http://img.tesco.com/Groceries/pi/457/5000436589457/IDShot_225x225.jpg","subtitle": "We ve got the right hat for everyone.","buttons": [{"type": "web_url","title": "View Website","action": "http://img.tesco.com/Groceries/pi/457/5000436589457/IDShot_225x225.jpg"},{"type": "postback","title": "Start Chatting","action": "http://img.tesco.com/Groceries/pi/457/5000436589457/IDShot_225x225.jpg"}]},{"title": "Welcome to Peter s Hats","item_url": "http://img.tesco.com/Groceries/pi/457/5000436589457/IDShot_225x225.jpg","image_url": "https://petersfancybrownhats.com/company_image.png","subtitle": "We ve got the right hat for everyone.","buttons": [{"type": "web_url","title": "View Website","action": "http://img.tesco.com/Groceries/pi/457/5000436589457/IDShot_225x225.jpg"},{"type": "postback","title": "Start Chatting","action": "http://img.tesco.com/Groceries/pi/457/5000436589457/IDShot_225x225.jpg"}]}]}'}
end


def button_bkp
  {"user": "bot","type": "BUTTON","payload": '{"text": "What do you want to do next?","buttons": [{"type": "web_url","action": "https://petersapparel.parseapp.com","title": "Show Website"},{"type": "postback","title": "Start Chatting","action": "USER_DEFINED_PAYLOAD"}]}'}
end


end





