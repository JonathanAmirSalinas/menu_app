// ignore: file_names
class ItemModel {
  final String product;
  final String description;
  final String category;
  final String menu;
  final double price;
  final String pid;
  final String productImage;

  const ItemModel(
      {required this.product,
      required this.description,
      required this.category,
      required this.menu,
      required this.price,
      required this.pid,
      required this.productImage});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'product': product,
      'description': description,
      'category': category,
      'menu': menu,
      'price': price,
      'pid': pid,
      'productImage': productImage
    };
  }

  Map<String, dynamic> toJson() => {
        'product': product,
        'description': description,
        'category': category,
        'menu': menu,
        'price': price,
        'pid': pid,
        'productImage': productImage,
      };

  /*static ItemModel dataFromDoc(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return ItemModel(
      product: snapshot['product'],
      description: snapshot['description'],
      category: snapshot['category'],
      menu: snapshot['menu'],
      price: snapshot['price'],
      pid: snapshot['pid'],
      productUrl: snapshot['productUrl'],
    );
  }*/
}
