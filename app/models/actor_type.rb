class ActorType

  include Mongoid::Document

  field :name, :type => String, :localize => true
  field :key, :type => Symbol

  validates_uniqueness_of :key

  embeds_many :information_type, class_name: 'InformationTypeDecorator'    #embedded

  def self.find_by_key(key)
    ActorType.find_by(key: key)
  end

  def to_s
    self.name
  end

  ##
  # returns name of actor_type object in lang
  def name_locale(lang)
    current_lang = I18n.locale
    I18n.locale = lang
    locale = self.name
    I18n.locale = current_lang
    locale
  end

  def every_information_type
    info_types = Array.new
    for info_type in information_type do
      info_types.push(info_type.information_type)
    end
    info_types
  end

  def information_type_decorator_by_information_type(info_type)        #THIS FUCKER SHOULD GIVE ME AN InformationTypeObject BUT IT GIVES ME NilObject
    self.information_type.select{|a| a.information_type==info_type}.first
  end

end