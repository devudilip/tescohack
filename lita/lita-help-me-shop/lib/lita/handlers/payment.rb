module Lita
  module Handlers
    class Payment


          def self.get_payment_url(price)
          headers = {"X-Api-Key" => "236f9d6737e4cfee228c102d9e0ec85d", "X-Auth-Token" => "327757ac8a979354f48b1e0c371eec0c"}
          payload = {
            purpose: 'TESCO',
            amount: price,
            buyer_name: 'John Doe',
            email: 'foo@example.com',
            phone: '9999999999',
            redirect_url: 'http://www.tesco.com/',
            send_email: true,
            send_sms: true,
            webhook: 'http://www.example.com/webhook/',
            allow_repeated_payments: false,
          }
          conn = Faraday.new(:url => 'https://test.instamojo.com/api/1.1/', :headers => headers)
          response = conn.post 'payment-requests/', payload
          return JSON.parse(response.body)["payment_request"]["longurl"]

          end

end
end
