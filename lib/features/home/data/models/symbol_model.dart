class SymbolModel {
  SymbolModel({
    this.symbol = '',
    this.price = '',
  });

  factory SymbolModel.fromJson(Map<String, dynamic> json) {
    return SymbolModel(
      symbol: json['symbol'],
      price: json['price'],
    );
  }

  String? symbol;
  String? price;
}
