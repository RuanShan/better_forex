module BetterForex

  class Quotation
    attr_accessor :exchange_description, :data, :time
    attr_accessor :new_value, :last_settle, :open_value, :high_value, :low_value, :close_value

    #DUSD	美汇澳元 4
    def initialize( exchange_description, data, time )
      self.exchange_description = exchange_description
      self.data = data
      self.time = time
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

    def symbol
      exchange_description.symbol
    end
  end

end
