def consolidate_cart(cart)
  # code here
  hash = {}
  cart.each do |item|
    item.each do |name, price|
      if hash[name]
        hash[name][:count] += 1
      else
        hash[name] = price
        hash[name][:count] = 1
      end
    end
  end
  hash
end

def apply_coupons(cart, coupons)
  # code here
  hash = cart
  coupons.each do |coupon_hash|
    # add coupon to cart
    item = coupon_hash[:item]

    if !hash[item].nil? && hash[item][:count] >= coupon_hash[:num]
      temp = {"#{item} W/COUPON" => {
        :price => coupon_hash[:cost],
        :clearance => hash[item][:clearance],
        :count => 1
        }
      }

      if hash["#{item} W/COUPON"].nil?
        hash.merge!(temp)
      else
        hash["#{item} W/COUPON"][:count] += 1
      end
      hash[item][:count] -= coupon_hash[:num]
    end
  end
  hash
end


def apply_clearance(cart)
  # code here
  cart.each do |item, price_hash|
    if price_hash[:clearance] == true
      price_hash[:price] = (price_hash[:price] * 0.8).round(2)
    end
  end
  cart
end


def checkout(cart, coupons)
  # code here
  cart = consolidate_cart(items)
  cart1 = apply_coupons(cart, coupons)
  cart2 = apply_clearance(cart1)

  total = 0

  cart2.each do |name, price_hash|
    total += price_hash[:price] * price_hash[:count]
  end
  total > 100 ? total * 0.9 : total
end
