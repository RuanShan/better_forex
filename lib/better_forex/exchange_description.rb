#一个汇率品种
module BetterForex
  class ExchangeDescription
    attr_accessor :quotations, :fields, :initial_values, :datetime
    attr_accessor :symbol, :name, :digits, :field_price_index
    attr_accessor :new_value, :last_settle, :open_value, :high_value, :low_value, :close_value
    #          商品,最新, 涨跌, 开盘, 最高,最低, 收盘, 涨跌, 涨跌幅
    # fields = [Name,Price,Arrow,Open,High,Low,Close,Fluctuatation,FluctuatationRate]
    def initialize( symbol, fields )
      self.symbol = symbol
      self.fields = fields
      self.quotations = []
      self.datetime = Time.now
      self.field_price_index = 1
      self.name = nil
    end

    def push_message( data )
      if name.nil?
        initialize_fields( data )
      else
        new_quotation = Quotation.new( self, data, datetime )
        quotations.push new_quotation
        puts "#{symbol} = #{new_quotation.new_value}"
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
puts "initial push #{symbol} #{new_value}, #{last_settle}, #{open_value}, #{high_value}, #{low_value}, #{close_value}"
    end

    class Quotation
      attr_accessor :exchange_description, :data, :datetime
      attr_accessor :new_value, :last_settle, :open_value, :high_value, :low_value, :close_value
      #DUSD	美汇澳元 4
      def initialize( exchange_description, data, datetime )
        self.exchange_description = exchange_description
        self.data = data
        self.datetime = datetime
        update_field_values
      end

      def update_field_values
        if self.data[ exchange_description.field_price_index ]
          last_quotation = exchange_description.quotations.last
          if last_quotation
            self.new_value = last_quotation.new_value + self.data[ exchange_description.field_price_index ]
          else
            #quotation[req_field] += qval; // Math.pow(10, quotation.Digits);
            self.new_value = exchange_description.new_value + self.data[ exchange_description.field_price_index ]
          end
        end
      end


    end

  end
end
