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
        puts recieved_res
        if recieved_res
          robot.send_message(message.source, recieved_res)
        else
          robot.send_message(message.source, "I recieved an Unhandled Message - #{message.body}!!")
        end
      end

      def bot_index(req, res)
        #res.write(req.env['QUERY_STRING'])
        # base_uri = 'https://tescohack.firebaseio.com/'

        # firebase = Firebase::Client.new(base_uri)
        # response = firebase.get("message_randomkey")

        message = JSON.parse(req.env['QUERY_STRING'])
        cp = Lita::Handlers::Chatparse.new
        if cp.parse(message)
          @text = get_answer(message['action'])
        end

        res.write(@text)
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



    end
    Lita.register_handler(HelpMeShop)


    class ChatParser

      def parse message
        if message['action']
          if string_has_dave(message['action'])
            return true
          else
            return false
          end
        else
          puts "<<<<<<<<<<<<<<<<<<<<<<<<Do  Nothing >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
          return false
        end
      end


      def string_has_dave(str)
        return true if str.include?("Dave") or str.include?("dave")
      end

      def call_bot(str)
        puts "<<<<<<<<<<<<<<<<<<,Do Something >>>>>>>>>>>>>>>>....."
      end

    end

  end
end
