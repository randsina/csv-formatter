module Formatters
  class Default
    attr_reader :data

    def initialize(data:)
      @data = data
    end

    def max_output_width
      raise 'Not implemented'
    end

    def row_height(_index = 0)
      raise 'Not implemented'
    end

    def output(row_index:, height:)
      raise 'Not implemented'
    end
  end
end
