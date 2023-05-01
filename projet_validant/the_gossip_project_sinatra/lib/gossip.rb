require 'csv'

class Gossip
    attr_reader :id, :author, :content # Crée les getters pour les attributs id, author et content
  
    def initialize(id=nil, author, content) # Initialise l'objet Gossip avec un ID (optionnel), un auteur et un contenu
        @id = id # Initialise l'attribut id avec la valeur passée en argument (ou nil par défaut)
        @author = author # Initialise l'attribut author avec la valeur passée en argument
        @content = content # Initialise l'attribut content avec la valeur passée en argument
    end

    def save # Méthode pour enregistrer un objet Gossip dans un fichier CSV
      id = Gossip.all.empty? ? 1 : Gossip.all.last.id + 1  # Si le fichier CSV est vide, utilise l'ID 1, sinon utilise l'ID suivant
      @id ||= id # Attribue l'ID seulement si l'attribut id est actuellement nil
      CSV.open("./db/gossip.csv", "ab") do |csv| # Ouvre le fichier CSV en mode ajout
        csv << [id, @author, @content] # Ajoute une nouvelle ligne au fichier CSV avec l'ID, l'auteur et le contenu
      end
    end

    def self.all # Méthode de classe pour récupérer tous les Gossips à partir du fichier CSV
        all_gossips = [] # Initialise un tableau vide pour stocker les Gossips
        CSV.read("./db/gossip.csv").each_with_index do |csv_line, index| # Lit le fichier CSV ligne par ligne avec un index
        all_gossips << Gossip.new(index + 1, csv_line[0], csv_line[1]) # Crée un nouvel objet Gossip et l'ajoute au tableau all_gossips
        end
        return all_gossips # Retourne le tableau contenant tous les Gossips
    end



  def self.find(id) # Méthode de classe pour trouver un Gossip par son ID
    all_gossips = self.all # Récupère tous les Gossips
    return all_gossips.find { |gossip| gossip.id == id } # Retourne le premier Gossip dont l'ID correspond à l'ID recherché
  end

  def update(new_author, new_content) # Méthode pour mettre à jour l'auteur et le contenu d'un Gossip
    @author = new_author # Met à jour l'auteur avec la nouvelle valeur
    @content = new_content # Met à jour le contenu avec la nouvelle valeur
  
    all_gossips = Gossip.all # Récupère tous les Gossips
    all_gossips[@id - 1] = self # Remplace le Gossip à l'index correspondant par l'objet Gossip mis à jour
  
    CSV.open("./db/gossip.csv", "wb") do |csv| # Ouvre le fichier CSV en mode écriture (écrase le contenu existant)
      all_gossips.each do |gossip| 
        csv << [gossip.author, gossip.content]
        end
    end
end
end


