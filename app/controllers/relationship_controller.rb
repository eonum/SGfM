# Controller for objects of class Relationship.
# Mediates inputs and converts them to commands for the model-class and the view.
class RelationshipController < ApplicationController

  before_filter :owns_actor_or_is_admin!, :only => [:new, :create]
  before_filter :owns_relationship_or_is_admin!, :only => [:edit, :update, :destroy]

  def new
    @locals = { :all_actors => Actor.all,
                :actor => Actor.find(params[:actor]) }
  end

  def create
    @actor = Actor.find(params[:actor])
    relationship = Relationship.new
    relationship.actor = @actor
    relationship.reference = Actor.find(params[:relationship][:reference])
    relationship.comment = params[:relationship][:comment]
    relationship.relationship_type = RelationshipType.find_by_key(params[:relationship][:relationship_type])
		relationship.scope =  Scope.find_by(key: params[:relationship][:scope].to_sym)
    if relationship.save
      flash[:success] = t('relationship.create.success')
      redirect_to(show_actor_path(@actor))
    else
      flash[:error] = t 'relationship.create.failure'
      redirect_to create_relationship_path
    end
  end

  def edit
    @locals = { :relationship => Relationship.find(params[:id]),
                :all_actors => Actor.all }
  end

  def update
    relationship = Relationship.find(params[:id])
    @actor = relationship.actor
    relationship.relationship_type = RelationshipType.find_by_key(params[:relationship][:relationship_type])
		relationship.scope =  Scope.find_by(key: params[:relationship][:scope].to_sym)
		relationship.comment = params[:relationship][:comment]
    if relationship.save
      flash[:success] = t('relationship.update.success')
      redirect_to(show_actor_path(@actor))
    else
      flash[:error] = t 'relationship.update.failure'
      redirect_to show_actor_path(@actor)
    end
  end

  def destroy
    @relationship = Relationship.find(params[:id])
    @actor = @relationship.actor
    @relationship.destroy

    flash[:success] = t('relationship.destroy.success')
    redirect_to(show_actor_path(@actor))
  end

end