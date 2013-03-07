class ActorType

  include Mongoid::Document

  field :name, type :String

  has_many :actors, class_name => 'Actor::Actor', inverse_of => :actor_type             #referenced
  has_and_belongs_to :information_type, class_name => 'Information::InformationType'    #referenced
end