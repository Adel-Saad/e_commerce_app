class OrderModel {
  // props ...
  int totalPrice;
  String docId;
  String address;
  String name;
  String location;
  int quantity;
  // constr ...
  OrderModel(
      {this.docId,
      this.address,
      this.totalPrice,
      this.location,
      this.name,
      this.quantity});
}
