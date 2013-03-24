class ActorTypeController < ApplicationController

	before_filter :authenticate_login!, :authenticate_admin!

	# Creates an ActorType with chosen name and InformationTypes
  def create
    @actor_type = ActorType.new
    @actor_type.key = params[:actor_type][:name][:en].downcase.tr(' ', '_')

    @actor_type.name_translations = params[:actor_type][:name]

    unless params[:information].nil?
      params[:information].each do |key,value|
        info_type = InformationType.find_by_key(key.to_sym)
        if value.to_i == 1
          @actor_type.information_type.push(info_type)
        end
      end
    end

    @actor_type.save

    flash[:success] = t('actor_type.create.success')
    redirect_to actor_types_path
  end

  # Gets all actor_types
  # If there are none, return an empty array
  def list
    @actor_types = ActorType.all
    if @actor_types.nil?
      return Array.new
    end
  end

  # Find information_type with given id
  def show
    @actor_type = ActorType.find(params[:id])
  end

  # Passes all information types in a list, that the user will be able to choose from
  def new
    @information_types = InformationType.all
  end

  def edit
    @actor_type = ActorType.find(params[:id])
  end

  def update
    @actor_type = ActorType.find(params[:id])
    @actor_type.name_translations = params[:actor_type][:name]

    unless params[:information].nil?
      params[:information].each do |key,value|
        info_type = InformationType.find_by_key(key.to_sym)
        if value.to_i == 1
          @actor_type.information_type.push(info_type) unless @actor_type.information_type.include?(info_type)
        else
          @actor_type.information_type.delete(info_type) if @actor_type.information_type.include?(info_type)
        end
      end
    end


    @actor_type.save

    flash[:success] = t('actor_type.update.success')
    redirect_to actor_types_path
  end

end