class Product < ActiveRecord::Base

	has_many :pictures
	has_many :orders, dependent: :destroy
	has_many :feedbacks, dependent: :destroy
	belongs_to :user
	belongs_to :category

	validates :title, :description, :price, :quantity, :location, :category_id, :allow_blank => false, :allow_nil => false, :on => :create, presence: true

	default_scope -> { order(created_at: :desc) }

	#include PgSearch

	#pg_search_scope :search, 
	#								:against => [:title, :description, :location], 
	#								:using => {
	#									:tsearch => {
	#										:prefix => true,
	#										:dictionary => "spanish"
	#									}
	#								},
	#								:associated_against => {
   # 								:category => :name
  	#							}


  searchable do
    text :title, :description, :location
    text :categories do
      categories.map { |category| category.name }
    end
  end

	#def self.search(query)
	#	consulta1 = where('products.title ilike ? or products.description ilike ?', "%#{query}%", "%#{query}%")
	#	consulta2 = joins(:category).where("categories.name ilike ?", "%#{query}%")
	#	arr = consulta1 | consulta2 # Devuelve la unión de los dos conjuntos, pero es un arreglo, NO ES UNA ActiveRecord Relation
	#	return where(id: arr.map(&:id)) #Conversión a AR Relation... no es lo mejor pero así permite usar scopes
	#end

end
