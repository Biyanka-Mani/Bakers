module ApplicationHelper
  def badge_class_for_order_status(order_status)
    case order_status
    when 'confirmed'
      'bg-primary text-dark'
    when 'processing'
      'bg-info text-dark'
    when 'ready'
      'bg-warning text-dark'
    when 'picked_up'
      'bg-success text-dark'
    else
      'bg-secondary text-dark'
    end
  end
  def contact_info
    ContactInfo.first
  end
end
