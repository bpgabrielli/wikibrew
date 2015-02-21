class ChargesController < ApplicationController

 def new
   @stripe_btn_data = {
     key: ENV['stripe_publishable_key'],
     description: "Premium Membership - #{current_user.email}",
     amount: Amount.default
   }
 end

 def create
 
   # Creates a Stripe Customer object, for associating
   # with the charge
   customer = Stripe::Customer.create(
     email: current_user.email,
     card: params[:stripeToken]
   )
 
   # Where the real magic happens
   charge = Stripe::Charge.create(
     customer: customer.id, # Note -- this is NOT the user_id in your app
     amount: Amount.default,
     description: "Premium Membership - #{current_user.email}",
     currency: 'usd'
   )
 
   flash[:success] = "Thanks for upgrading your account, #{current_user.name || current_user.email}!"
   current_user.role = "premium"
   current_user.save
   redirect_to root_path # or wherever
 
 # Stripe will send back CardErrors, with friendly messages
 # when something goes wrong.
 # This `rescue block` catches and displays those errors.
 rescue Stripe::CardError => e
   flash[:error] = e.message
   redirect_to new_charge_path
 end

end