module Lita
  module Handlers
    require 'firebase'
    class HelpMeShop < Handler


      http.get "/bot_index", :bot_index
      route(/^set:\s+(.+)/, :set_response, help: {"set" => "sets response"})
      #route(/^get\s+(.+)/, :get_response, help: {"get" => "gets answer"} )

      on :unhandled_message, :chat

      def chat(payload)
        message = payload[:message]
        #check if it has a response
        #starts with
        ##robot.send_message(message.source, "recieved a nil message") if !message.body.match(/^dave|dave/)
        recieved_res = get_answer(message.body)
        if recieved_res
          robot.send_message(message.source, recieved_res)
        else
          robot.send_message(message.source, "I recieved an Unhandled Message - #{message.body}!!")
        end
      end

      def bot_index(req, res)
        text = nil
        base_uri = 'https://tescohack.firebaseio.com/'
        @firebase = Firebase::Client.new(base_uri)
        @table_name = "messages"
        val = req.env['QUERY_STRING']
        parsed_val = JSON.parse(URI.decode_www_form(val)[0][0])
        message = parsed_val
        @chat_parser = Lita::Handlers::ChatParser.new
puts ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
puts message['user']
        return nil if message['user'].upcase == 'BOT'
        if @chat_parser.parse(parsed_val)
            @product_details_val = product_details(message['payload'])
              if !@product_details_val.empty?
              response = reply_with_products(@product_details_val)
              elsif get_answer(message['payload'])
                response = reply_with_text(message, get_answer(message['payload']))
              #elsif 
               # reply_with_products(message)
                #generic(products)
              else
                response = reply_with_text(message, "Sorry unable to help U")
              end
        else
        response = reply_with_text(message, "message not addressed at bot")
        end
      end
      
      def text_keygen(user, text)
        {"user": "bot","type": "text","payload": text}
      end
        
      def reply_with_text(message, text)
        @firebase.push(@table_name, text_keygen(message['user'], text))
      end
      
      def reply_with_products(message)
        @firebase.push(@table_name, @chat_parser.generic(@product_details_val))
      end

      def get_response(request)
        #redis.get("mykey")
        redis.get(request)
      end

      #bot set q, val
      def set_response(request)

        message = request.message.body
        # parse user input for ques & ans
        splitted_qa_from_message = message.split(': ')[1]
        splitted_message = splitted_qa_from_message.split(',')
        #split it into ques & ans
        question = splitted_message[0]
        answer = splitted_message[1]
        #save into redis
        #redis.set("mykey", "hello world")
        redis_res = redis.set(question, answer)
        #respond back
        if redis_res
          res_message = "saved to redis"
        else
          res_message = "failed to save to redis"
        end
        request.reply_with_mention(res_message)
      end

      private

      def get_answer(question)
        #question = questions.detect { |q| Regexp.new(q.sub('lita:handlers:help_me_shop:', ''), 'i') =~ question }
        #TODO: fix this as am always expecting a single key here
        # regexp_type = "/(([0-9])( |)(ltr|litre|litres|ltrs|gms|gram|kg|kilogram|gm|kilos|kilo gram|kilo gram|kilo gm))/ig"
        # get_sizequestion.match(regexp_type)
        key = redis.keys(question)
        return "Hey nothinh aval" if key.empty?
        redis.get(key)
      end
      
      def get_quantity(message)
        message
      end
      
      def product_details(message)
        prod_details = products(message)
        if !prod_details.empty?
          prod_details
        else
          []
        end
      end

      def products(message)
        products_val = []
        redis_new = Redis.new
        keys = redis_new.keys('products_*')

          keys.each { |k|
          k_val = redis_new.hgetall(k)
          
            products_val << k_val if message.match(/#{k_val['category']}/i)
          }
          return products_val
      end

    end
    Lita.register_handler(HelpMeShop)


class ChatParser

  def parse message
    if ((message['type'].upcase == 'text'.upcase) and message['user'].upcase != 'BOT')
     #call_bot(message['payload']) if string_has_dave(message['payload'])
     return true if string_has_dave(message['payload'])
   else
    return false
    end
  end


def string_has_dave(str)
  return true if str.include?("Dave") or str.include?("dave")
end

def call_bot(str)
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
   {"elements": products_array}.to_json
   #{}"\'{\"elements\":" + products_array + "}\'"
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
  {"title": product['title'],"image_url": product['image_url'],"subtitle": product['subtitle'],"buttons": [{"type": "web_url","title": "View Website","action": "http://img.tesco.com/Groceries/pi/457/5000436589457/IDShot_225x225.jpg"},{"type": "postback","title": "Start Chatting","action": "https://petersfancybrownhats.com"}]}
end

def generic_bkp
  {"type": "GENERIC","user": "bot","payload": '{"elements": [{"title": "Welcome to Peter s Hats","item_url": "https://petersfancybrownhats.com","image_url": "https://petersfancybrownhats.com/company_image.png","subtitle": "We ve got the right hat for everyone.","buttons": [{"type": "web_url","title": "View Website","action": "http://img.tesco.com/Groceries/pi/457/5000436589457/IDShot_225x225.jpg"},{"type": "postback","title": "Start Chatting","action": "https://petersfancybrownhats.com"}]},{"title": "Welcome to Peter s Hats","item_url": "http://img.tesco.com/Groceries/pi/457/5000436589457/IDShot_225x225.jpg","image_url": "http://img.tesco.com/Groceries/pi/457/5000436589457/IDShot_225x225.jpg","subtitle": "We ve got the right hat for everyone.","buttons": [{"type": "web_url","title": "View Website","action": "http://img.tesco.com/Groceries/pi/457/5000436589457/IDShot_225x225.jpg"},{"type": "postback","title": "Start Chatting","action": "http://img.tesco.com/Groceries/pi/457/5000436589457/IDShot_225x225.jpg"}]},{"title": "Welcome to Peter s Hats","item_url": "http://img.tesco.com/Groceries/pi/457/5000436589457/IDShot_225x225.jpg","image_url": "https://petersfancybrownhats.com/company_image.png","subtitle": "We ve got the right hat for everyone.","buttons": [{"type": "web_url","title": "View Website","action": "http://img.tesco.com/Groceries/pi/457/5000436589457/IDShot_225x225.jpg"},{"type": "postback","title": "Start Chatting","action": "http://img.tesco.com/Groceries/pi/457/5000436589457/IDShot_225x225.jpg"}]}]}'}
end


def button_bkp
  {"user": "bot","type": "BUTTON","payload": '{"text": "What do you want to do next?","buttons": [{"type": "web_url","action": "https://petersapparel.parseapp.com","title": "Show Website"},{"type": "postback","title": "Start Chatting","action": "USER_DEFINED_PAYLOAD"}]}'}
end


    end

  end
end
