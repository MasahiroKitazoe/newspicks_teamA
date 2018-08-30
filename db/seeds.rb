require 'csv'

CSV.foreach('db/picks.csv') do |row|
  Pick.create(:url => row[0], :image => row[1], :title => row[2], :body => row[3], :created_at => row[4], :updated_at => row[5], :source => row[6])
end
