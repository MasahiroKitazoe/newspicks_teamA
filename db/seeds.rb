require "csv"

CSV.foreach('db/users.csv') do |row|
  User.create!(:email => row[0], :password => row[1], :first_name => row[5], :last_name => row[6], :support_number => row[7], :company => row[8], :position => row[9], :profile => row[10], :pro => row[11], :real_name => row[12], :created_at => row[13], :updated_at => row[14])
end

CSV.foreach('db/picks.csv') do |row|
  Pick.create(:url => row[0], :image => row[1], :title => row[2], :body => row[3], :created_at => row[4], :updated_at => row[5], :source => row[6])
end
