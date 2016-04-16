class ChargesController < ApplicationController
  def create
    # Creates a Stripe Customer object, for associating with the charge
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      customer: customer.id, # Note -- this is NOT the user_id in your app
      amount: Amount.default,
      description: "gWiki Upgrade - #{current_user.email}",
      currency: 'usd'
    )

    flash[:notice] = "Account Upgraded, #{current_user.email}! Welcome to Premium."
    redirect_to wikis_path

      # Stripe will send back CardErrors, when something goes wrong.
      # This `rescue block` catches and displays those errors.
  rescue Stripe::CardError => e
    flash[:alert] = e.message
    redirect_to new_charge_path
  end

  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "BigMoney Membership - #{current_user.name}",
      amount: Amount.default
    }
  end
end
