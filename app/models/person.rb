class Person
  include ActiveModel::Validations

  attr_accessor :firstname, :lastname, :postcode

  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :postcode, presence: true

end
