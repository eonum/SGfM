# Controller for Ajax usages.
# Used to render partials that are needed when filling in forms that change depending on selections made in views.
class AjaxController < ApplicationController

  def add_relationship_form
    render_partial('actor/add_relationship_form', {  :all_actors => Actor.all  })
  end

  def add_information_type_form
    render_partial('actor_type/add_information_type_form', {:information_types => InformationType.all})
  end

  def information_type_data_form
    information_field_type = InformationFieldType.find_by key: params[:information_field_type]
    information_type = nil
    information_type = InformationType.find_by id: params[:information_type_id] if params[:information_type_id]
    render :partial => InformationTypeHelper.get_partial(information_field_type), :locals => {:information_type => information_type}
  end

  def information_type_option_form
    render_partial 'information_type/data/option', {:remove_button => true}
  end

  def predefined_questions
    actor_type = ActorType.find_by :key => params[:actor_type]
    render :partial => 'actor/predefined_questions', :locals => {:relationship_types => actor_type.predefined_questions}
  end

  def referenced_actor
    render_partial 'actor/referenced_actor', :key => params[:key], :remove => true, :scopes => Scope.all
  end

  private
  def render_partial(file, locals = {})
    locals[:field_number] = Random.new.rand(100...1000000)
    render(:partial => file, :locals => locals)
  end
end