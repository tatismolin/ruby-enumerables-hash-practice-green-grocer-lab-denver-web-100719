def consolidate_cart(cart)
  # code here
  hash = {}
  cart.each do |item|
    item.each do |name, price|
      if hash[name]
        hash[name][:count] += 1
      else
        hash[name] = price #why
        hash[name][:count] = 1
      end
    end
  end
  hash
end

def apply_coupons(cart, coupons)
  # code here
end


def apply_clearance(cart)
  # code here
end


def checkout(cart, coupons)
  # code here
end
