def consolidate_cart(cart)
  hash = {}
  cart.each do |item_hash|
    item_hash.each do |name, price_hash|
      if hash[name].nil?
        hash[name] = price_hash.merge({:count => 1})
      else
        hash[name][:count] += 1
      end
    end
  end
  hash
end

def apply_coupons(cart, coupons)
  cart_cons = cart
  coupons.each do |coupon|
    item_name = coupon[:item]
    if cart_cons.keys.include?(item_name)
      cart_count = cart_cons[item_name][:count]
      if cart_count >= coupon[:num]
        item_coup = {"#{item_name} W/COUPON" => {price: coupon[:cost], clearance: cart_cons[item_name][:clearance], count: cart_count/coupon[:num]}}
        cart_cons[item_name][:count] %= coupon[:num]
        cart_cons = cart_cons.merge(item_coup)
      end
    end
  end
   cart_cons
end

def apply_clearance(cart)
  cart.each do |item, price_hash|
    if price_hash[:clearance] == true
      price_hash[:price] = (price_hash[:price] * 0.8).round(2)
    end
  end
  cart
end

def checkout(items, coupons)
  cart_cons = consolidate_cart(cart: cart)
  cart_coup = apply_coupons(cart:cart_cons, coupons:coupons)
  cart_check = apply_clearance(cart: cart_coup)
  total = 0
  cart_check.each do |item, attribute|
    total += attribute[:count] * attribute[:price]
  end
  return total = total > 100 ? (total*0.9).round(2) : total
end
