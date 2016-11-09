#一个汇率品种
module BetterForex
  class ExchangeDescription
    attr_accessor :quotations, :fields, :initial_values, :time, :exchange_redis_store
    attr_accessor :symbol, :name, :digits, :field_price_index
    attr_accessor :new_value, :last_settle, :open_value, :high_value, :low_value, :close_value
    #          商品,最新, 涨跌, 开盘, 最高,最低, 收盘, 涨跌, 涨跌幅
    # fields = [Name,Price,Arrow,Open,High,Low,Close,Fluctuatation,FluctuatationRate]
    def initialize( symbol, fields, time, exchange_redis_store )
      self.symbol = symbol
      self.fields = fields
      self.quotations = []
      self.time = time
      self.field_price_index = 1
      self.name = nil
      self.exchange_redis_store = exchange_redis_store
    end

    def push_message( data, time )
      if name.nil?
        initialize_fields( data )
        exchange_redis_store.store( self )
      else
        new_quotation = Quotation.new( self, data, time )
        quotations.push new_quotation
        puts "#{symbol} #{time.to_f} = #{new_quotation.new_value}"
        exchange_redis_store.store( new_quotation )
      end
    end

    def initialize_fields( item )

      self.symbol, self.name, self.digits = item[0], item[1], item[2]

      ## Price,LastSettle,Open,Hight,Low,Close
      #reqest_fields.each_with_index{|field, i|
      #  # skip 名称符号, 名称, 小数点位数
      #  initial_values[i] = item[ i + 3 ]
      #}
      self.new_value, self.last_settle, self.open_value, self.high_value, self.low_value, self.close_value = item[3], item[4], item[5],item[6], item[7], item[8]
puts "initial push #{symbol} #{time} #{new_value}, #{last_settle}, #{open_value}, #{high_value}, #{low_value}, #{close_value}"
    end


  end
end
