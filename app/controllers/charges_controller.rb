class ChargesController < ApplicationController

  def create
   # Creates a Stripe Customer object, for associating
   # with the charge
    @amount = 15_00 #in pennies == $15.00
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )

    # Where the real magic happens
    charge = Stripe::Charge.create(
      customer: customer.id, # Note -- this is NOT the user_id in your app
      amount: @amount, #removed Amount.default and set value above
      description: "gWiki Membership - #{current_user.email}",
      currency: 'usd'
    )
#  if SUCCESS
    current_user.role = :premium
    current_user.save
    flash[:notice] = "Thanks for upgrading your gWiki account, #{current_user.email}! I hope you enjoy."
    redirect_to edit_user_registration_path(current_user)

   # Stripe will send back CardErrors, with friendly messages
   # when something goes wrong.
   # This `rescue block` catches and displays those errors.
   rescue Stripe::CardError => e
     flash[:alert] = e.message
     redirect_to new_charge_path
  end

  def new
    @amount = 15_00 #in pennies == $15.00

    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "gWiki Membership - #{current_user.email}",
      amount: @amount #Amount.default
    }
  end

end
