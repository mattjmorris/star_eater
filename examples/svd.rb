#
# Example of using SVD for rating comparisons
#
require 'linalg'
 
movies = ["Star Wars V", "Independence Day", "The Notebook", "Alien", "Lethal Weapon", "Twilight"]
existing_users = ["Geek", "Macho", "Romantic"]
user_ratings = {0=>[5,1,1,4,1,1], 1=>[2,5,1,2,5,1], 2=>[1,2,5,1,1,4]}

new_user = ["Mary"]
new_user_ratings = {3=>[4,2,1,nil,nil,nil]}
# new_user_ratings = {3=>[2,1,5,nil,nil,nil]}
# new_user_ratings = {3=>[2,5,2,nil,nil,nil]}

# grabs ratings of users that have rated the same movies
user_matching_ratings = []
user_ratings.map{|id,ratings| arr = []; ratings.each_with_index{|val, idx| arr << val if new_user_ratings[3][idx] }; user_matching_ratings << arr}

# Let's find which existing user matches our new user
m = Linalg::DMatrix.rows(user_matching_ratings).transpose
u, s, v = m.singular_value_decomposition
vt = v.transpose
u2 = Linalg::DMatrix.join_columns [u.column(0), u.column(1)]
v2 = Linalg::DMatrix.join_columns [vt.column(0), vt.column(1)]
eig2 = Linalg::DMatrix.columns [s.column(0).to_a.flatten[0,2], s.column(1).to_a.flatten[0,2]]

new_user_m = Linalg::DMatrix.rows([new_user_ratings[3].compact])
new_user_embed = new_user_m * u2 * eig2.inverse
 
# grab most similar user
def similarity(user, row)
  (user.transpose.dot(row.transpose)) / (row.norm * user.norm)
end

similar_row = v2.rows.dup.sort{|x,y| similarity(new_user_embed,y) <=> similarity(new_user_embed,x)}.first
similar_user_idx = nil; v2.rows.each_with_index{|row, idx| similar_user_idx = idx if row == similar_row}
similar_user = existing_users[similar_user_idx]
similar_user_ratings = user_ratings[similar_user_idx]
top = [0,nil]
p similar_user_ratings
p new_user_ratings[3]
similar_user_ratings.each_with_index{|rating, idx| top = [rating, idx] if new_user_ratings[3][idx].nil? && top[0] < rating}

p "The new user most closely matches existing user: '#{similar_user}'"
p "Most recommended unwatched movie for new user is: '#{movies[top[1]]}'"

