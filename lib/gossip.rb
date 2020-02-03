require 'csv'
class Gossip
  attr_accessor :content, :author

  def initialize(author, content) # 2 parametres sont demandés pour créer un nouveau gossip
    @content = content
    @author = author
  end

  def save # sauvegarde du gossip dans la DB
    CSV.open("./db/gossip.csv", "ab") do |csv|
      csv << [@author, @content]
    end
  end

	def self.all # injecte les gossips extraits de la DB dans un tableau
    all_gossips = []
    CSV.read('./db/gossip.csv').each do |csv_line|
      all_gossips << Gossip.new(csv_line[0],csv_line[1])
		end
		return all_gossips
	end

  def self.find(id) # cherche dans le fichier csv un id en particulier
    CSV.read("./db/gossip.csv")[id]
  end

  def update # sauvegarde du gossip dans la DB
    CSV.open("./db/gossip.csv", "ab") do |csv|
      csv << [author_new, content_new]
    end
  end
end

