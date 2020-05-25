# frozen_string_literal: true

require 'csv'
Dir['./lib/**/*.rb'].sort.each { |file| require file }

FORMATTERS = {
  'int' => Formatters::Int,
  'string' => Formatters::String,
  'money' => Formatters::Money
}.freeze

class App
  def initialize(options)
    file_name = options[0] || 'example.csv'
    @table = CSV.parse(File.read(file_name), col_sep: ';', headers: true)
    @output = []
  end

  def execute!
    output_first_line
    output_data
    print_output
  end

  private

  attr_reader :table, :output

  def headers
    @headers ||= table.headers
  end

  def formatters
    @formatters ||= headers.map.with_index do |type, index|
      col_data = table.by_col[index]
      FORMATTERS[type].new(data: col_data)
    end
  end

  def print_output
    puts output
  end

  def output_first_line
    max_output_width = formatters.map(&:max_output_width).sum + headers.count - 1
    first_line = ('-' * max_output_width).prepend('+').concat('+')
    output << first_line
  end

  def output_last_line
    last_line = formatters.map(&:max_output_width).map { |i| '-' * i }.join('+').prepend('+').concat('+')
    output << last_line
  end

  def output_data
    table.count.times do |row_index|
      row_height = formatters.map { |formatter| formatter.row_height(row_index) }.max
      raw_row_output = formatters.map do |formatter|
        formatter.output(row_index: row_index, height: row_height)
      end
      row_output = raw_row_output.transpose.map { |row| row.join('|').prepend('|').concat('|') }
      output << row_output
      output_last_line
    end
  end
end
