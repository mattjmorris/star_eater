ENV['R_HOME'] = "/usr/local/R/R.framework/Resources"
require 'rsruby'
r = RSRuby.instance
r.source(File.dirname(__FILE__) + '/grouper.R')

data_points = []; 20.times{|idx| data_points << [idx, rand(11) - 5, rand(11) - 5] }
# data_points = [[0, 1, 0], [1, -4, 3], [2, 3, 4], [3, 5, 1], [4, -5, 2], [5, -3, 4], [6, -3, -1], [7, 3, -3], 
#                [8, 0, -4], [9, 1, 3], [10, -1, -3], [11, -2, -4], [12, -3, 2], [13, -4, -5], [14, -2, 5], 
#                [15, -2, 3], [16, -3, 3], [17, 5, -1], [18, -5, 5], [19, -2, 5]]
results = r.group(data_points, 3)
p results
