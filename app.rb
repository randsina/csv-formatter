require 'csv'
Dir['./formatters/*.rb'].sort.each { |file| require file }

FORMATTERS = {
  'int' => Formatters::Int,
  'string' => Formatters::String,
  'money' => Formatters::Money
}.freeze

file_name = ARGV[0] || 'example.csv'
table = CSV.parse(File.read(file_name), col_sep: ';', headers: true)
headers = table.headers
formatters = headers.map.with_index do |type, index|
  col_data = table.by_col[index]
  FORMATTERS[type].new(data: col_data)
end
max_output_width = formatters.map(&:max_output_width).sum + headers.count - 1
puts ('-' * max_output_width).prepend('+').concat('+')
table.count.times do |row_index|
  row_height = formatters.map { |formatter| formatter.row_height(row_index) }.max
  raw_row_output = formatters.map do |formatter|
    formatter.output(row_index: row_index, height: row_height)
  end
  output = raw_row_output.transpose.map { |row| row.join('|').prepend('|').concat('|') }
  puts output
  last_line = formatters.map(&:max_output_width).map { |i| '-' * i }.join('+').prepend('+').concat('+')
  puts last_line
end
