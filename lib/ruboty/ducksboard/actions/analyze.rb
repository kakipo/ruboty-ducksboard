module Ruboty
  module Ducksboard
    module Actions
      class Analyze < Ruboty::Actions::Base
        def call
          conn = Faraday::Connection.new(url: 'https://pull.ducksboard.com/') do |builder|
            builder.use Faraday::Request::UrlEncoded
            builder.use Faraday::Adapter::NetHttp
          end

          conn.basic_auth(
            ENV['DUCKSBOARD_API_KEY'],
            'unused')

          results = message[:label_and_ids].split(",").map do |label_and_id|
            label = label_and_id.split(":")[0]
            id = label_and_id.split(":")[1]

            rep = conn.get "/values/#{id}/last?count=1"
            val = JSON.parse(rep.body)['data'].first['value']
            {id: id, label: label, value: val}
          end

          message.reply results.map{ |res| "#{res[:label]}: #{res[:value]}" }.join("\n")
        rescue
          message.reply("なにかに失敗したよ")
        end
      end
    end
  end
end
