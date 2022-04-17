WORKSPACE = 'ecommerce'
ENV = 'develop'
DATABASE  = 'ecommerce-api'
TABLES = ['order', 'product']
COLUMNS = {
  order: [
    {identifier: "order_number", name: "Order Number", data_type: "VAR CHAR"}
  ]
}
