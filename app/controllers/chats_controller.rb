class ChatsController < ApplicationController
  def index
    message = JSON.parse(params['value'])
    cp = ChatParser.new
    cp.parse message
  end
end
