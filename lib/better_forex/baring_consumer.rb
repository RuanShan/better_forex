require "em-http-request"
module BetterForex
  module BaringConsumer
    class << self
      def start
        EventMachine.run do
          fields = ['Price','LastSettle','Open','High','Low','Close']
          symbols = [ 'USAUDUSD','USDINIW','USEURUSD','USGBPUSD','USNZDUSD','USUSDCAD','USUSDCHF','USUSDCNY','USUSDHKD','USUSDJPY','USUSDMOP','USUSDMYR','USUSDSGD','USUSDTWD']

          url1 = "http://www.baring.cn/quo/bin/quotation.dll"
          url = "http://www.baring.cn/quo/bin/quotation.dll?fields=Price,LastSettle,Open,High,Low,Close,&symbols=USAUDUSD,USDINIW,USEURUSD,USGBPUSD,USNZDUSD,USUSDCAD,USUSDCHF,USUSDCNY,USUSDHKD,USUSDJPY,USUSDMOP,USUSDMYR,USUSDSGD,USUSDTWD,"
          query = {
            'fields': fields.join(','),    #'Price,LastSettle,Open,High,Low,Close,',
            'symbols': symbols.join(',')  #'USAUDUSD,USDINIW,USEURUSD,USGBPUSD,USNZDUSD,USUSDCAD,USUSDCHF,USUSDCNY,USUSDHKD,USUSDJPY,USUSDMOP,USUSDMYR,USUSDSGD,USUSDTWD,'
            }
          headers = {
            'Host'=> 'www.baring.cn',
            'User-Agent' => 'Mozilla/5.0 (X11; Fedora; Linux x86_64; rv:47.0) Gecko/20100101 Firefox/47.0',
            'Referer' => 'http://www.baring.cn/quo/index.html',
            'Connection' => 'keep-alive'
          }
          exchanges = ExchangeCollection.new( symbols,fields )
          http = EventMachine::HttpRequest.new( url).get( head: headers)

          #--ThisRandomString
          #Content-Type: application/json
          #
          #[["USUSDCNY","人 民 币",4,67833,67740,67741,67840,67740,67740],["USAUDUSD","美汇澳元",4,7696,7727,7727,7728,7687,7727],["USUSDCAD","美汇加元",4,13368,13362,13363,13391,13350,13362],["USUSDCHF","美汇瑞士",4,9763,9742,9743,9765,9734,9742],["USGBPUSD","美汇英镑",4,12408,12396,12394,12440,12385,12396],["USUSDHKD","美汇港元",4,77547,77547,77548,77560,77542,77547],["USUSDJPY","美汇日元",2,10472,10445,10445,10476,10429,10445],["USNZDUSD","美汇纽元",4,7325,7343,7343,7348,7316,7343],["USUSDSGD","美汇新元",4,13902,13891,13891,13922,13882,13891],["USUSDTWD","美汇台币",4,314700,314670,315090,316100,313900,314670],["USEURUSD","美汇欧元",4,11043,11039,11040,11067,11029,11039],]
          #Content-Type: application/json
          #
          #[[3],[6],[8,2],[10],]
          #--ThisRandomString

          http.stream { |chunk|
            if chunk =~ /\[.*\]/
              data = eval(parse_message( $& ))
              exchanges.push_message( data, Time.now )
            end
          }
        end

      end

      # [[1,-1],[2,-3,,,,-1],[3],[8,4],[10,-1],]
      # [[4],[7,1],[8,-1],[10,2],]
      def parse_message( s )
        s.gsub(/(?<=,),/, "0,")
      end
    end
  end
end
