require 'csv'

print "Enter soccer results CSV file name (default 'results-sample.csv'):"
file_name = gets.strip.empty? ? 'results-sample.csv' : file_name
results_table = CSV.parse(File.read(file_name), headers: true)

# Team with the smallest difference in 'for' and 'against' goals
puts "\n########## Team with smallest difference in 'for' and 'against' goals ##########".upcase
result = results_table.sort{ |a,b| a['Goals'].to_i - a['Goals Allowed'].to_i <=> b['Goals'].to_i - b['Goals Allowed'].to_i }[0]
puts result['Team']
puts 'Difference: ' + (result['Goals'].to_i - result['Goals Allowed'].to_i).to_s


# Top 10 highest win percentage
highest_win_percentages = []

results_table.each do |result|
  highest_win_percentages << [result['Team'], ((result['Wins'].to_f / result['Losses'].to_f) * 100).truncate(1)]
end

highest_win_percentages.sort!{ |a,b| b[1] <=> a[1] }

puts "\n########## Top 10 teams with highest win percentages ##########".upcase
highest_win_percentages[0..10].each do |result|
  puts result[0] + ' - ' + result[1].to_s + '%'
end

# Full stats for team with the most draws
puts "\n########## Team with the most draws ##########".upcase
puts results_table.sort{ |a,b| a['Draws'].to_i <=> b['Draws'].to_i }[-1]
