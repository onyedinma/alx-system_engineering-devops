#!/usr/bin/env ruby
# Get the first argument from the command line
input = ARGV.first

# Define a pattern to match the word School
pattern = /School/

# Check if the input is a valid string and contains the pattern
if input.is_a?(String) && input.include?(pattern)
  # Print the pattern
  puts pattern
end
