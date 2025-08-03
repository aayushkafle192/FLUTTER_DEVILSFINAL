import 'package:hive/hive.dart';
import 'package:rolo/features/product/domain/entity/product_entity.dart';
import 'package:rolo/app/constant/hive_table_constant.dart';

part 'product_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.productTableId)
class ProductHiveModel extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String name;

  @HiveField(2)
  late String description;

  @HiveField(3)
  late double price;

  @HiveField(4)
  late int quantity;

  @HiveField(5)
  late String imageUrl;
  
  @HiveField(6)
  late double originalPrice;

  @HiveField(7)
  late List<String> extraImages;

  @HiveField(8)
  late List<String> features;

  @HiveField(9)
  late String material;

  @HiveField(10)
  late String origin;

  @HiveField(11)
  late String care;

  @HiveField(12)
  late String warranty;

  @HiveField(13)
  late bool featured;

  @HiveField(14)
  late String categoryId;
  
  ProductHiveModel(); 

  ProductHiveModel.fromEntity(ProductEntity entity) {
    id = entity.id;
    name = entity.name;
    description = entity.description;
    price = entity.price;
    quantity = entity.quantity;
    imageUrl = entity.imageUrl;
    originalPrice = entity.originalPrice;
    extraImages = entity.extraImages;
    features = entity.features;
    material = entity.material;
    origin = entity.origin;
    care = entity.care;
    warranty = entity.warranty;
    featured = entity.featured;
    categoryId = entity.categoryId;
  }
  
  ProductEntity toEntity() {
    return ProductEntity(
      id: id,
      name: name,
      description: description,
      price: price,
      quantity: quantity,
      imageUrl: imageUrl,
      originalPrice: originalPrice,
      extraImages: extraImages,
      features: features,
      material: material,
      origin: origin,
      care: care,
      warranty: warranty,
      featured: featured,
      categoryId: categoryId,
    );
  }
}