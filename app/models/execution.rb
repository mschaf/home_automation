class Execution < ActiveType::Object

  attribute :actor_id, :integer
  attribute :action, :string
  attribute :parameters, :string

  validates :actor_id, :action, presence: true

  belongs_to :actor

  def save
    actor.execute(action, parameters)
  end

end