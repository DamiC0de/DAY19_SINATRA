require 'csv'

class Comment
  attr_reader :id, :gossip_id, :content

  def initialize(id, gossip_id, content)
    @id = id
    @gossip_id = gossip_id
    @content = content
  end

  def save
    id = Comment.all.empty? ? 1 : Comment.all.last.id + 1
    CSV.open("./db/comment.csv", "ab") do |csv|
      csv << [id, @gossip_id, @content]
    end
    @id = id
  end

  def self.all
    all_comments = []
    CSV.read("./db/comment.csv").each_with_index do |csv_line, index|
      all_comments << Comment.new(index + 1, csv_line[1].to_i, csv_line[2])
    end
    return all_comments
  end
  

  def self.find_by_gossip_id(gossip_id)
    all_comments = self.all
    return all_comments.select { |comment| comment.gossip_id == gossip_id }
  end
end
