class HomeController < ApplicationController
  def index
    base_uri = 'https://tescohack.firebaseio.com/'

    firebase = Firebase::Client.new(base_uri)
    redirect_to '/bot_index'
    #response = firebase.push("message_randomkey", { :message => 'Tesitng', :name => "Nikhil" })
    #puts response.success? # => true
end

  def test
  


  end
  
end
