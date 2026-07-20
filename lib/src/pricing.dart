/// List price = [price]. Sale price = [discountPrice] when > 0 and below list.
bool isOnSale(double price, double discountPrice) {
  return discountPrice > 0 && discountPrice < price;
}

double getEffectivePrice(double price, double discountPrice) {
  return isOnSale(price, discountPrice) ? discountPrice : price;
}

int getDiscountPercent(double price, double discountPrice) {
  if (!isOnSale(price, discountPrice)) return 0;
  return ((price - discountPrice) / price * 100).round();
}
