import 'package:byte_budget/domain/core/failure.dart';
import 'package:byte_budget/domain/entities.dart';
import 'package:rust_types/result.dart';

abstract class MerchantRepository {
  const MerchantRepository();

  Future<Result<List<Merchant>, Failure>> getMerchants();

  Future<Result<Merchant, Failure>> getMerchantById(int id);
}

class MockMerchantRepository extends MerchantRepository {
  final merchants = const [
    Merchant(
      id: 0,
      name: 'Apple',
      logo: 'merchant_apple_logo',
      description: '',
    ),
    Merchant(
      id: 1,
      name: 'Kupikod',
      logo: 'merchant_kupikod_logo',
      description: '',
    ),
    Merchant(
      id: 2,
      name: 'Яндекс Плюс',
      logo: 'merchant_yandex_plus_logo',
      description: '',
    ),
    Merchant(
      id: 3,
      name: 'VK',
      logo: 'merchant_vk_logo',
      description: '',
    ),
    Merchant(
      id: 4,
      name: 'BlancVPN',
      logo: 'merchant_blancVPN_logo',
      description: '',
    ),
    Merchant(
      id: 5,
      name: 'Тинькофф Про',
      logo: 'merchant_tinkoff_pro_logo',
      description: '',
    ),
    Merchant(
      id: 6,
      name: 'Яндекс Маркет',
      logo: 'merchant_yandex_market_logo',
      description: '',
    ),
    Merchant(
      id: 7,
      name: 'OTUS',
      logo: 'merchant_otus_logo',
      description: '',
    ),
    Merchant(
      id: 8,
      name: 'ChatGPT',
      logo: 'merchant_chatGPT_logo',
      description: '',
    ),
    Merchant(
      id: 9,
      name: 'CDEK Shopping',
      logo: 'merchant_cdek_shopping_logo',
      description: '',
    ),
    Merchant(
      id: 10,
      name: 'WineStyle',
      logo: 'merchant_winestyle_logo',
      description: '',
    ),
  ];

  @override
  Future<Result<Merchant, Failure>> getMerchantById(int id) async {
    return Future.delayed(const Duration(seconds: 1), () {
      final merchant = merchants.firstWhere(
        (element) => element.id == id,
        orElse: () => merchants.first.copyWith(id: -1),
      );
      if (merchant.id == -1) {
        return MerchantNotFoundFailure(id: id).toErr();
      }
      return Ok(merchant);
    });
  }

  @override
  Future<Result<List<Merchant>, Failure>> getMerchants() async {
    return Future.delayed(const Duration(seconds: 1), () {
      return Ok(merchants);
    });
  }
}
