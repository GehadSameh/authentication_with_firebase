class ItemModel {
  final String imgPath;
  final double price;
  final int rate;
  final String description;
  final String state;

  ItemModel(this.rate, this.description, this.state, {required this.imgPath, required this.price});
}
List<ItemModel>items=[
ItemModel(5, 
"Size: 37*27"
, 'New', price: 220, imgPath: "assets/images/img1.jpg",),
ItemModel(5, "Size: 35*27"
, 'New', price: 260, imgPath: "assets/images/img2.jpg",),
ItemModel(3, "Size:43*28"
, 'New', price: 200, imgPath: "assets/images/img3.jpg",),
ItemModel(4, "Size:16*28"
, 'New', price: 220, imgPath: "assets/images/img4.jpg",),
ItemModel(1, "Size:43*28"
, 'New', price: 230, imgPath: "assets/images/img5.jpg",),
ItemModel(2, "Size: 45*28"
, 'New', price: 180, imgPath: "assets/images/img6.jpg",),
ItemModel(5, "Size: 20*17"
, 'New', price:100, imgPath: "assets/images/img7.jpg",),
ItemModel(5, " Size: 38*26"
, 'New', price: 200, imgPath: "assets/images/img8.jpg",),
ItemModel(5, "Size: 36*31"
, 'New', price: 250, imgPath: "assets/images/img9.jpg",),
ItemModel(5, "Size: 43*28"
, 'New', price: 220, imgPath: "assets/images/img10.jpg",)];