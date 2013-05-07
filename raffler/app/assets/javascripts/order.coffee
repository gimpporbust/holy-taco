app = angular.module("Orders", ["ngResource"])

app.factory "Order", ["$resource", ($resource) ->
  $resource("/orders/:id", {id: "@id"}, {update: {method: "PUT"}})
]

app.factory "Item", ["$resource", ($resource) ->
  $resource("/items/:id", {id: "@id"})
]

app.service "currentOrder", ->
  items = []
  price = 0.00
  
  addItem: (item) ->
    @addItemToOrder item
    @addToOrderTotal item.price
  
  getItems: ->
    items
  
  getTotal: ->
    price
  
  addItemToOrder: (item) ->
    # console.log 'adding item', item
    items.push item
  
  addToOrderTotal: (itemCost) ->
    # console.log 'adding to price', itemCost
    # console.log 'current price', price
    price = price + +itemCost





@ItemsCtrl = ["$scope", "Item", "currentOrder", ($scope, Item, currentOrder) ->
  $scope.items = Item.query()
  
  $scope.addItem = (item) ->
    currentOrder.addItem item
]

@OrdersCtrl = ["$scope", "Order", "currentOrder", ($scope, Order, currentOrder) ->
  $scope.orders = Order.query()
  $scope.orderItems = currentOrder.getItems()
  $scope.orderTotal = currentOrder.getTotal()
  
  $scope.addOrder = ->
    $scope.newOrder['total'] = currentOrder.getTotal()
    $scope.newOrder['items'] = currentOrder.getItems()
    console.log "saving", $scope.newOrder
    order = Order.save($scope.newOrder)
    $scope.orders.push(order)
    $scope.newOrder = {}
]