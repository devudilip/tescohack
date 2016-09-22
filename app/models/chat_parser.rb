class ChatParser

  def parse message
    if message['action']
       call_bot(message['action']) if string_has_dave(message['action'])
    else
      puts "<<<<<<<<<<<<<<<<<<<<<<<<Do  Nothing >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
    end
  end


  def string_has_dave(str)
    return true if str.include?("Dave") or str.include?("dave")
  end

  def call_bot(str)
    puts "<<<<<<<<<<<<<<<<<<,Do Something >>>>>>>>>>>>>>>>....."
  end

end