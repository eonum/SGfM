class ActorTypeController < ApplicationController

	before_filter :authenticate_login!, :authenticate_admin!

	# Creates an ActorType with chosen name and InformationTypes
  def create
    @actor_type = ActorType.new
    @actor_type.key = params[:actor_type][:key]
    @actor_type.name = params[:actor_type][:name]

    for info_type in InformationType.each do
      if params[info_type.key].to_i == 1
        @actor_type.information_type.push(info_type)
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

  #todo update

end