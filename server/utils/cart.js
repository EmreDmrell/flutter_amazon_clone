const findProductInCart = (cart, productId) => {
    return cart.find(item => item.product._id.equals(productId));
};

module.exports = { findProductInCart };