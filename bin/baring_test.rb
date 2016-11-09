require "em-http-request"
EventMachine.run do
  url1 = "http://www.baring.cn/quo/bin/quotation.dll"
  url2 = "http://www.baring.cn/quo/bin/quotation.dll?fields=Price,LastSettle,Open,High,Low,Close,&symbols=USAUDUSD,USDINIW,USEURUSD,USGBPUSD,USNZDUSD,USUSDCAD,USUSDCHF,USUSDCNY,USUSDHKD,USUSDJPY,USUSDMOP,USUSDMYR,USUSDSGD,USUSDTWD,"
  url = "http://www.baring.cn/quo/bin/quotation.dll?fields=Price,LastSettle,&symbols=SH1A0001,SZ399001,HKHSIO,USDINIW,IDDJSII,IDNQCI,IDNICI,IDDAX,USGBPUSD,USEURUSD,USUSDJPY,CRXAU,LMLMCD,LMLMAD,NYCON0,CBSBC0,CXGLN2,CXSLN2,CXCHC0,SQALS0,SQCOS0,"
  query = {
    'fields': 'Price,LastSettle,',
    'symbols': 'SH1A0001,SZ399001,HKHSIO,USDINIW,USGBPUSD,USEURUSD,USUSDJPY,'
    }
  headers = {
    'Host'=> 'www.baring.cn',
    'User-Agent' => 'Mozilla/5.0 (X11; Fedora; Linux x86_64; rv:47.0) Gecko/20100101 Firefox/47.0',
    'Referer' => 'http://www.baring.cn/quo/index.html',
    'Connection' => 'keep-alive'
  }

  http = EventMachine::HttpRequest.new( url).get(query: query, head: headers)
  http.stream { |chunk|
    print Time.now.to_f.to_s + chunk
  }
end
