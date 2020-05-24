require_relative 'default'

module Formatters
  class String < Default
    def initialize(data:)
      @data = data.map(&:split)
    end

    def max_output_width
      return @max_output_width if defined?(@max_output_width)

      max_strings = data.map do |string|
        string.max { |a, b| a.length <=> b.length }.length
      end
      @max_output_width = max_strings.max
    end

    def row_height(index = 0)
      data[index].count
    end

    def output(row_index:, height:)
      string_output = data[row_index].map { |string| format_string(string) }
      element_output = (string_output.size + 1).upto(height).map { format_string }
      string_output.concat(element_output)
    end

    private

    def format_string(element = '')
      element.ljust(max_output_width)
    end
  end
end
