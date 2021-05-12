class CreateSubscriptionStates < ActiveRecord::Migration[6.1]
  def change
    create_view :subscription_states
  end
end
