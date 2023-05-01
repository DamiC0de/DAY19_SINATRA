require 'csv'

class Comment # Définit une nouvelle classe appelée Comment
  attr_reader :id, :gossip_id, :content # Crée les getters pour les attributs id, gossip_id et content

  def initialize(id, gossip_id, content) # Initialise l'objet Comment avec un ID, un gossip_id et un contenu
    @id = id  # Initialise l'attribut id avec la valeur passée en argument
    @gossip_id = gossip_id # Initialise l'attribut gossip_id avec la valeur passée en argument
    @content = content # Initialise l'attribut content avec la valeur passée en argument
  end

  def save # Méthode pour enregistrer un objet Comment dans un fichier CSV
    id = Comment.all.empty? ? 1 : Comment.all.last.id + 1 # Si le fichier CSV est vide, utilise l'ID 1, sinon utilise l'ID suivant
    CSV.open("./db/comment.csv", "ab") do |csv| # Ouvre le fichier CSV en mode ajout
      csv << [id, @gossip_id, @content] # Ajoute une nouvelle ligne au fichier CSV avec l'ID, le gossip_id et le contenu
    end
    @id = id # Attribue l'ID généré à l'attribut id
  end

  def self.all # Méthode de classe pour récupérer tous les Comment à partir du fichier CSV
    all_comments = [] # Initialise un tableau vide pour stocker les Comment
    CSV.read("./db/comment.csv").each_with_index do |csv_line, index| # Lit le fichier CSV ligne par ligne avec un index
      all_comments << Comment.new(index + 1, csv_line[1].to_i, csv_line[2]) # Crée un nouvel objet Comment et l'ajoute au tableau all_comments
    end
    return all_comments # Retourne le tableau contenant tous les Comment
  end
  

  def self.find_by_gossip_id(gossip_id) # Méthode de classe pour trouver les Comment par leur gossip_id
    all_comments = self.all # Récupère tous les Comment
    return all_comments.select { |comment| comment.gossip_id == gossip_id }  # Retourne les Comment dont le gossip_id correspond à l'ID recherché
  end
end
