module Ruboty
  module Handlers
    class Ducksboard < Base

      # /qiita scouter (analyze|a) (?<id>.*?)\z/,
      on(
        /ducks (?<label_and_ids>(.+:\w+,?)+)/,
        name: 'analyze',
        description: 'ducksboard plugin description'
      )

      def analyze(message)
        Ruboty::Ducksboard::Actions::Analyze.new(message).call
      end
    end
  end
end