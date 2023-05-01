require 'csv'

class Gossip
    attr_reader :id, :author, :content
  
    def initialize(id=nil, author, content)
        @id = id
        @author = author
        @content = content
      end

      def save
        id = Gossip.all.empty? ? 1 : Gossip.all.last.id + 1
        @id ||= id
        CSV.open("./db/gossip.csv", "ab") do |csv|
          csv << [id, @author, @content]
        end
      end

    def self.all
        all_gossips = []
        CSV.read("./db/gossip.csv").each_with_index do |csv_line, index|
        all_gossips << Gossip.new(index + 1, csv_line[0], csv_line[1])
        end
        return all_gossips
    end



  def self.find(id)
    all_gossips = self.all
    return all_gossips.find { |gossip| gossip.id == id }
  end

  def update(new_author, new_content)
    @author = new_author
    @content = new_content
  
    all_gossips = Gossip.all
    all_gossips[@id - 1] = self
  
    CSV.open("./db/gossip.csv", "wb") do |csv|
      all_gossips.each do |gossip|
        csv << [gossip.author, gossip.content]
        end
    end
end
end


