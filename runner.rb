
#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'app'

app = App.new(ARGV)
app.execute!
