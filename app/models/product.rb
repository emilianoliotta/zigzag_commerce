class Product < ActiveRecord::Base

	has_many :pictures
	has_many :orders, dependent: :destroy
	has_many :feedbacks, dependent: :destroy
	belongs_to :user
	belongs_to :category


	def self.search(query)
		consulta1 = where('products.title ilike ? or products.description ilike ?', "%#{query}%", "%#{query}%")
		consulta2 = joins(:category).where("categories.name ilike ?", "%#{query}%")
		arr = consulta1 | consulta2 # Devuelve la unión de los dos conjuntos, pero es un arreglo, NO ES UNA ActiveRecord Relation
		return where(id: arr.map(&:id)) #Conversión a AR Relation... no es lo mejor pero así permite usar scopes
	end

end
