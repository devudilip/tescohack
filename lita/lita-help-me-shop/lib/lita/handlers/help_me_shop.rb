module Lita
  module Handlers
    require 'firebase'
    require 'faraday'
    class HelpMeShop < Handler


      http.get "/bot_index", :bot_index
      http.get "/bot_payment", :bot_payment_status
      route(/^set:\s+(.+)/, :set_response, help: {"set" => "sets response"})
      #route(/^get\s+(.+)/, :get_response, help: {"get" => "gets answer"} )

      on :unhandled_message, :chat


      def bot_payment_status(req, res)
          val = req.env["QUERY_STRING"]
          puts URI.decode_www_form(val)
          puts "Payment"
          parsed_val = JSON.parse(URI.decode_www_form(val)[0][0]).first
          
          base_uri = 'https://tescohack.firebaseio.com/'
          firebase = Firebase::Client.new(base_uri)
          text = (if parsed_val[1] == true
                " Your order is placed successfully. Thanks for purchasing at tesco. Have a great day"
                else
                " Your order has failed. Please try again."
                end)
          
          firebase.push("messages", {"type": 'text', "user": "bot", "payload": "Hi #{parsed_val[0]}," + text})
      end



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
        @redis_new = Redis.new
        @table_name = "messages"
        val = req.env['QUERY_STRING'].gsub('/%22', '\%22')
        p val
        parsed_val = JSON.parse(URI.decode_www_form(val)[0][0])
        message = parsed_val
        @chat_parser = Lita::Handlers::ChatParser.new
        return nil if message['user'].upcase == 'BOT'
        # handles only the text type and name not in bot
        if @chat_parser.parse(parsed_val)
          @product_details_val = product_details(message['payload'])
                if message['payload'].upcase.match(/CHECKOUT/)
                  reply_with_check_out(message)
                elsif !@product_details_val.empty?
                  response = reply_with_products(@product_details_val)
                elsif get_answer(message['payload'])
                  response = reply_with_text(message, get_answer(message['payload']))
                    #elsif 
                     # reply_with_products(message)
                      #generic(products)
                    else
                      response = reply_with_text(message, "Oops that product is not in our store. We will update you once available.")
                    end
          
            elsif message['type'] == "postback"  && message['payload']
              add_to_cart(message)
            #else
             # response = reply_with_text(message, "message not addressed at bot")
            end
          end

          def add_to_cart(message)
            payloads = JSON.parse(message['payload'])
            get_actions =  payloads['action'].split("/")
            if get_actions[3] == 'me'
              table_name = message['user']
            else
              table_name = 'rajesh'
            end
            
            product = get_product_info(get_actions[2])
            @firebase.push(table_name, {info: product})
            @firebase.push('messages', {"user": "bot","type": "text","payload": "#{product['title']} is added to #{table_name}'s cart."})
         end


         def get_product_info(id)
          table = "products_" + id.to_s
          puts table
          redis_new = Redis.new
          product = redis_new.hgetall(table)
         end


         def text_keygen(user, text)
          {"user": "bot","type": "text","payload": text}
        end
      
      def reply_with_check_out(message)
        cart_name = message["user"]
        #puts cart_name
        price_array = []

        cart = @firebase.get(cart_name).body
          if cart
            cart_val = cart.values
          else
            reply_with_text(message['user'], "U do not have any Item in your cart. Please add an item to checkout")
            return
          end
        cart_val.each {|k| 
            price_array << k["info"]["price"]
        }
        puts price_array
        puts total_quantity = cart_val.size
        puts total_price = price_array.map(&:to_f).inject(:+) || 0
        total_price = total_price.round(2)
        cart_name = cart_name.capitalize
        response_txt = "#{cart_name}, U have #{total_quantity} items in your cart. And your total bill amount is: " + "£" + "#{total_price}"
        @firebase.push(@table_name, payment_button(response_txt, total_price, cart_name))
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
        # regexp_type = "/(([0-9])( |)(ltr|litre|litres|ltrs|gms|gram|kg|kilogram|gm|kilos|kilo gram|kilo gram|kilo gm))/ig"
        # get_sizequestion.match(regexp_type)
        key = redis.keys(question)
        if key.empty?
          if question.match(/thanks|tks|thanku|thank you|thnks/)
            return ['Welcome', 'Hope you had fun!!', 'See You Soon'].sample
          end
          return "Sorry, I didn't understand what you are asking !." 
        end
        redis.get(key.first)
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

      def payment_button(text, price, user)
        web_url = Lita::Handlers::Payment.get_payment_url(price, user)
        payload_element = {"text": text,"buttons": [{"type": "web_url","action": web_url,"title": "Quick Pay"}]}
        {"user": "bot","type": "BUTTON","payload": payload_element.to_json}
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
  {"title": product['title'],"image_url": product['image_url'],"subtitle": "£" + product["price"] + " : " + product['subtitle'] ,"buttons": [{"type": "postback","title": "+ MyCart","action": "action/addToBasket/#{product['id']}/me"},{"type": "postback","title": "+ Group Cart","action": "action/addToBasket/#{product['id']}/group"}]}
end

def generic_bkp
  {"type": "GENERIC","user": "bot","payload": '{"elements": [{"title": "Welcome to Peter s Hats","item_url": "https://petersfancybrownhats.com","image_url": "https://petersfancybrownhats.com/company_image.png","subtitle": "We ve got the right hat for everyone.","buttons": [{"type": "web_url","title": "View Website","action": "http://img.tesco.com/Groceries/pi/457/5000436589457/IDShot_225x225.jpg"},{"type": "postback","title": "Start Chatting","action": "https://petersfancybrownhats.com"}]},{"title": "Welcome to Peter s Hats","item_url": "http://img.tesco.com/Groceries/pi/457/5000436589457/IDShot_225x225.jpg","image_url": "http://img.tesco.com/Groceries/pi/457/5000436589457/IDShot_225x225.jpg","subtitle": "We ve got the right hat for everyone.","buttons": [{"type": "web_url","title": "View Website","action": "http://img.tesco.com/Groceries/pi/457/5000436589457/IDShot_225x225.jpg"},{"type": "postback","title": "Start Chatting","action": "http://img.tesco.com/Groceries/pi/457/5000436589457/IDShot_225x225.jpg"}]},{"title": "Welcome to Peter s Hats","item_url": "http://img.tesco.com/Groceries/pi/457/5000436589457/IDShot_225x225.jpg","image_url": "https://petersfancybrownhats.com/company_image.png","subtitle": "We ve got the right hat for everyone.","buttons": [{"type": "web_url","title": "View Website","action": "http://img.tesco.com/Groceries/pi/457/5000436589457/IDShot_225x225.jpg"},{"type": "postback","title": "Start Chatting","action": "http://img.tesco.com/Groceries/pi/457/5000436589457/IDShot_225x225.jpg"}]}]}'}
end


def button_bkp
  {"user": "bot","type": "BUTTON","payload": '{"text": "What do you want to do next?","buttons": [{"type": "web_url","action": "https://petersapparel.parseapp.com","title": "Show Website"},{"type": "postback","title": "Start Chatting","action": "USER_DEFINED_PAYLOAD"}]}'}
end


end



 class Payment


          def self.get_payment_url(price, buyer)
          headers = {"X-Api-Key" => "236f9d6737e4cfee228c102d9e0ec85d", "X-Auth-Token" => "327757ac8a979354f48b1e0c371eec0c"}
          payload = {
            purpose: 'TESCO',
            amount: price,
            buyer_name: buyer,
            email: "#{buyer.downcase}@tesco.com",
            phone: ['9908765424','9876076523','9076542312'].sample,
            redirect_url: 'http://www.tesco.com/',
            send_email: true,
            send_sms: true,
            webhook: 'https://hack-tes-sathishachilles.c9users.io:8080/payment_call_back',
            allow_repeated_payments: false,
          }
          conn = Faraday.new(:url => 'https://test.instamojo.com/api/1.1/', :headers => headers)
          response = conn.post 'payment-requests/', payload
          p response.body
          return JSON.parse(response.body)["payment_request"]["longurl"]

          end

end

end
end
