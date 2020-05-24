require_relative 'default'

module Formatters
  class Int < Default
    ROW_HEIGHT = 1

    def max_output_width
      @max_output_width ||= data.max { |a, b| a.length <=> b.length }.length
    end

    def row_height(_index)
      ROW_HEIGHT
    end

    def output(row_index:, height:)
      int_output = format_int(data[row_index])
      element_output = 2.upto(height).map { format_int }
      element_output.unshift(int_output)
    end

    private

    def format_int(element = '')
      element.rjust(max_output_width)
    end
  end
end
