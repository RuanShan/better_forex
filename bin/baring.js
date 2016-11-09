// http://stackoverflow.com/questions/34204304/nodejs-as-sse-client-wih-eventsource

var url = "http://www.baring.cn/quo/bin/quotation.dll?fields=Price,LastSettle,Open,High,Low,Close,&symbols=USAUDUSD,USDINIW,USEURUSD,USGBPUSD,USNZDUSD,USUSDCAD,USUSDCHF,USUSDCNY,USUSDHKD,USUSDJPY,USUSDMOP,USUSDMYR,USUSDSGD,USUSDTWD,"
headers = {
  'Accept': 'text/event-stream',
  'Accept-Encoding': 'gzip, deflate, sdch',
  'Accept-Language': 'en-US,en;q=0.8',
  'Cache-Control': 'no-cache',
  'Connection': 'keep-alive',
  'Host': 'www.baring.cn',
  'Referer': 'http://www.baring.cn/quo/index.html',
  'User-Agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.90 Safari/537.36'
}
var options = { 'headers': headers};
var EventSource = require('eventsource');
var es = new EventSource(url, options);

//sse.addEventListener('command.notification', function(e) {
//  var data = JSON.parse(e.data);
//  console.log('eventSource : ' + e.data + '/' + data.message);
//}, false);
es.onmessage = function (event) {
  console.log(event.data);
};

es.onerror = function(err) {
  console.log('ERROR! ' + JSON.stringify(err));
};
