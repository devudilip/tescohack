require 'net/http'
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

    url = "https://hack-tes-sathishachilles.c9users.io:8081/bot_payment?"
    if params["status"] == "Credit"
      val =  true
    else
      val=  false
    end

    complet_url = url + {params["buyer_name"] => val}.to_json
    
    url = URI.parse(complet_url)
    req = Net::HTTP::Get.new(url.to_s)
    res = Net::HTTP.start(url.host, url.port) {|http|
      http.request(req)
    }
    
    p res.body
   
  end
  
end
