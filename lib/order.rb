class Order < ActiveRecord::Base
    belongs_to :event
    belongs_to :user

    def self.delete_order
        #search order.find_by
        puts "Please type in the name of the order you would like to delete."
        $this_user.events.map do |event|
            puts event.name
        end
        order_selection = gets.chomp
        event_to_delete = Event.find_by(name: order_selection)
        order_to_delete = Order.find_by(user_id: $this_user.id, event_id: event_to_delete.id)
        
        order_to_delete.delete
        
        puts "You have deleted your order."
        
    end

    def remove_tickets_from_order
        puts "Enter amount of tickets to be removed from your order. If more tickets are selected than in the order, your order will be deleted."
        
        user_input = gets.chomp
        # binding.pry
        input = user_input.to_i.clamp(1,10)
        
        if self.quantity >= input
            self.quantity -= input
            self.save
        else
            self.delete
        end
        self.save
      end

    # def add_tickets_to_order
    #     puts "Enter amount of tickets to be added to your order. You may add up to 10 tickets."
    #     user_input = gets.chomp
    #     # binding.pry
    #     input = user_input.to_i.clamp(1,10)
    #         self.quantity += input
    #         self.save
    #   end

    # def self.add_tickets_to_order
    #     puts "Please type in the name of the order you would like to add tickets to."
    #     $this_user.events.map do |event|
    #         puts event.name
    #     end
    #     order_selection = gets.chomp
    #     event_to_update = Event.find_by(name: order_selection)
    #     order_to_update = Order.find_by(user_id: $this_user.id, event_id: event_to_update.id)
    #     order_to_update
    #     binding.pry
    #     puts "Enter amount of tickets to be added to your order. You may add up to 10 tickets."
    #     user_input = gets.chomp
        
    #     input = user_input.to_i.clamp(1,10)
    #     # if $this_order.quantity < 10
        
    #         order_to_update.quantity += input
    #         if order_to_update.quantity > 10
    #             puts "You have attempted to add too many tickets to your order. Your order has been updated to ten tickets."
    #             order_to_update.quantity.clamp(1,10)
    #             order_to_update.save
    #             puts "You now have #{order_to_update.quantity} tickets in your cart."
    #             $total = order_to_update.quantity * event_to_update.ticket_price
    #             puts "Your updated total is $#{$total}."
    #         else 
    #             order_to_update.save
    #             puts "You now have #{order_to_update.quantity} tickets in your cart."
    #             total = order_to_update.quantity * event_to_update.ticket_price
    #             puts "Your updated total is $#{total}."
    #             end
    # end


    def self.place_an_order
        puts "Place your order."
        $this_order = Order.create(user_id: $this_user.id, event_id: $this_event.id)
        puts "How many tickets would you like to purchase? Select a number between 1 and 10."
        user_input = gets.chomp
        input = user_input.to_i.clamp(1,10)
        $this_order.quantity = input
        $this_order.save
        $this_order
        puts "-------------------------------------------"
        puts "-------------------------------------------"
    end

    def self.calculate_total
        $total = $this_order.quantity * $this_event.ticket_price
        puts "You have selected #{$this_order.quantity} tickets to #{$this_event.name} for the price of $#{$total}. To place your order, enter four digit credit card number."
        puts "-------------------------------------------"
        puts "-------------------------------------------"
    end

    def self.complete_purchase
        puts "Enter four digit credit card number: "
        payment = gets.chomp
        card_num = payment.to_i
        if card_num > 9999
            puts "Your card has been declined. Please enter a four digit number."
            complete_purchase
        else
        $this_user.payment_info = card_num
        $this_user.save
        puts "-------------------------------------------"
        puts "-------------------------------------------"
        puts "Congratulations, #{$this_user.name}! Your order has been confirmed for #{$this_event.name} on #{$this_event.date}. You have #{$this_order.quantity} tickets for a total cost of $#{$total}."
        end
    end
end