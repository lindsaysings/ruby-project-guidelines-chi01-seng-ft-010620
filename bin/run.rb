require_relative '../config/environment'
require 'pry'
puts "Welcome to Chicago Music Concerts Ticket Interface, do you have an account with us?"
# user_input = gets.chomp

def display_my_orders
  self.order
end

# order_six = Order.all[6]

# user = User.all[5]



# user.add_payment_method




# order_six.remove_tickets_from_order

# def remove_tickets_from_order
#   puts "Enter amount of tickets to be removed from your oder. If more tickets are selected than in the order, your order will be deleted."
  
#   user_input = gets.chomp
#   binding.pry
#   input = user_input.to_i.clamp(1,10)
  
#   if self.quantity <= input
#       self.quantity -= input
#       self.update(quantity: input)
#   else
#       self.quantity
#   end
#   self.save
# end


    puts "Do you have an existing account?"
    puts "Enter 1 for yes, or 2 for no."
    input = gets.chomp
    if  input == "1"   
        $this_user = User.find_user_by_name
        
    else
        $this_user = User.create_new_user 

    end

    






# Order.new(user_id: this_user.id, event_id: concert.id)

# binding.pry

# def new_user
#     puts "Enter name: "
#     user = User.new
#     user.name = gets.chomp
#     puts "Enter email: "
#     user.email = gets.chomp
#     user.save
#   end

  #new_user

Event.all.each_with_index do |event, index|
      Event.order(date: :asc)
    puts "#{index + 1}. #{event.name}"
    puts "WHEN: #{event.date} at #{event.time}"
    puts "GENERAL ADMISSION: $#{event.ticket_price}"
    puts "-------------------------------------------"
end

$this_event = Event.find_event_by_number 


Order.place_an_order 

Order.calculate_total

Order.complete_purchase





# User.name = user_input




