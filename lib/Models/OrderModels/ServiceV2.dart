class Service {
  final String service;
  bool isSelected;
  final String price;
  int count;

  Service({
    required this.service,
    this.isSelected = false,
    required this.price,
    this.count = 0,
  });
}
