#meta programming

1.dynamically defining methods and classes 
2. 

meta programming methods

send
define_method 
method_missing

send

def update_order_shipment_status(order_shipment, action)
    if action == "initiated"
      order_shipment.initiated
    elsif action == "dispatched"
      order_shipment.dispatched
    elsif action == "in_transit"
      order_shipment.in_transit
    elsif action == "out_for_delivery"
      order_shipment.out_for_delivery
    elsif action == "delivered"
      order_shipment.delivered
    elsif action == "cancelled"
      order_shipment.cancelled
    end
end

can be reduced to 

def update_order_shipment_status(order_shipment,action)
    order_shipment.send(action)
end

define method allows to create method dynamically during runtime

def update_order_shipment_status(order_shipment, action)
    if action == "initiated"
      order_shipment.initiated
    elsif action == "dispatched"
      order_shipment.dispatched
    elsif action == "in_transit"
      order_shipment.in_transit
    elsif action == "out_for_delivery"
      order_shipment.out_for_delivery
    elsif action == "delivered"
      order_shipment.delivered
    elsif action == "cancelled"
      order_shipment.cancelled
    end
end


def update_order_shipment_status(order_shipment,action)

    Statues = ["initiated", "dispatched", "in_transit","out_for_delivery","delivered","cancelled"].freeze

    Statues.each do |status|
        define_method("#is_#{status}") do 
            self.status == status 
        end
    end
end



