class Execution < ActiveType::Object

  attribute :actor_id, :integer
  attribute :action, :string
  attribute :parameters, :string

  belongs_to :actor

  def save
    actor.execute(action, parameters)
  end

end