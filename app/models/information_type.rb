class InformationType

  include Mongoid::Document

  field :name, :type => String, :localize => true
  field :key, :type => Symbol


  validates_uniqueness_of :key

  belongs_to :information_type_ype, class_name: 'InformationTypeType', inverse_of: nil  #referenced  / one way relationship

  #no mappings needed!

  def self.find_by_key(key)
    InformationType.find_by(key: key)
  end


end