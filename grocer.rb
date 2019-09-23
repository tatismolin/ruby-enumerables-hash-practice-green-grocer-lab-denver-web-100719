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
end


def checkout(cart, coupons)
  # code here
end
