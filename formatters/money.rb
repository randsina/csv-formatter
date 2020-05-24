require_relative 'default'

module Formatters
  class Money < Default
    EXTRA_CHARACTERS = 4 # dot, 2 decimals, and delimiter for thousands
    DELIMITER_BY = 3
    ROW_HEIGHT = 1

    def max_output_width
      return @max_output_width if defined?(@max_output_width)

      number_length = data.max { |a, b| a.length <=> b.length }.length
      space = (number_length - EXTRA_CHARACTERS) / DELIMITER_BY
      @max_output_width = number_length + space
    end

    def row_height(_index)
      ROW_HEIGHT
    end

    def output(row_index:, height:)
      integer, decimal = data[row_index].split('.')
      integer_output = format_integer(integer)
      money_output = format_money(integer_output.concat('.', decimal))
      element_output = 2.upto(height).map { format_money }
      element_output.unshift(money_output)
    end

    private

    def format_money(element = '')
      element.rjust(max_output_width)
    end

    def format_integer(integer)
      integer.chars.reverse.each_slice(DELIMITER_BY).map(&:join).join(' ').reverse
    end
  end
end
