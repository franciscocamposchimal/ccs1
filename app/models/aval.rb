class Aval < ApplicationRecord
	has_and_belongs_to_many :clients, inverse_of: :order
	validates :ine, length: {minimum: 18, maximum: 18}
end
