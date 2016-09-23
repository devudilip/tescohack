class HomeController < ApplicationController
  def index
    base_uri = 'https://tescohack.firebaseio.com/'

    firebase = Firebase::Client.new(base_uri)
    # response = firebase.push("message_randomkey", { :message => 'Tesitng ', :name => "Nikhil" })
    # response = firebase.push("users", { cart: {mi: '2', iphone: 'ss'}, :email => 'Nikhil@team22.com ', :name => "Nikhil" })
    # response = firebase.push("messages", { email: "devu@mail.com", message: "hello", pdesc: ["Desc1","Desc2"],pname: ["produyct1","product2"],price: ["23","44"],purl: ["http://product.com","http://product2.com"],type: 1,uid: ["2","4"] })
    # response = firebase.get("messages")
    # byebug
    # puts response.success? # => true
  end

  def payment_call_back

    #   url = "http://localhost:8080/bot_payment?"
    #   if params["status"] == "Credit"
    #       val =  true
    #   else
    #       val=  false

    #    end
    #    puts ">>>>>>>>>>>>>>>>>>>>>>>>>>>>"
    #    puts params


    # complet_url = url + {params['buyer_name'] => val}.to_json
    # redirect_to complet_url


    base_uri = 'https://tescohack.firebaseio.com/'
    firebase = Firebase::Client.new(base_uri)
    text = "Your order is placed successfully. Thanks for purchasing at tesco. Have a great day"
    firebase.push("messages", {"type": 'text', "user": "bot", "payload": text})
  end
  
end
