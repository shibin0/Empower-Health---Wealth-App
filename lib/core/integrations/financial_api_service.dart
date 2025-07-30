import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../storage/enhanced_storage_service.dart';
import '../../features/wealth/models/financial_data.dart';

part 'financial_api_service.g.dart';

/// Financial API integration service for banking and investment platforms
@riverpod
class FinancialApiService extends _$FinancialApiService {
  late final Dio _dio;
  Timer? _syncTimer;
  bool _isInitialized = false;

  @override
  Future<FinancialApiService> build() async {
    await _initializeFinancialService();
    return this;
  }

  /// Initialize financial service
  Future<void> _initializeFinancialService() async {
    try {
      _dio = Dio(BaseOptions(
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ));

      _dio.interceptors.add(_createLoggingInterceptor());
      _isInitialized = true;
      _startPeriodicSync();
      
      debugPrint('Financial API service initialized successfully');
    } catch (e) {
      debugPrint('Failed to initialize financial service: $e');
    }
  }

  /// Create logging interceptor
  Interceptor _createLoggingInterceptor() {
    return LogInterceptor(
      requestBody: kDebugMode,
      responseBody: kDebugMode,
      error: true,
      logPrint: (object) {
        if (kDebugMode) {
          debugPrint('[Financial API] $object');
        }
      },
    );
  }

  /// Start periodic financial data sync
  void _startPeriodicSync() {
    _syncTimer?.cancel();
    _syncTimer = Timer.periodic(const Duration(hours: 4), (timer) {
      _syncFinancialData();
    });
  }

  /// Sync financial data from various sources
  Future<void> _syncFinancialData() async {
    if (!_isInitialized) return;

    try {
      await Future.wait([
        _syncBankingData(),
        _syncInvestmentData(),
        _syncCryptocurrencyData(),
        _syncMarketData(),
      ]);

      debugPrint('Financial data sync completed');
    } catch (e) {
      debugPrint('Financial data sync failed: $e');
    }
  }

  /// Sync banking data (Open Banking APIs)
  Future<void> _syncBankingData() async {
    try {
      final storageService = ref.read(enhancedStorageServiceProvider.notifier);
      
      // Get stored banking credentials/tokens
      final bankingTokens = storageService.getCachedData('banking_tokens');
      if (bankingTokens == null) return;

      // Example: Sync with multiple banks
      final banks = ['sbi', 'hdfc', 'icici', 'axis'];
      
      for (final bank in banks) {
        final token = bankingTokens[bank];
        if (token != null) {
          await _syncBankData(bank, token);
        }
      }
    } catch (e) {
      debugPrint('Banking data sync failed: $e');
    }
  }

  /// Sync individual bank data
  Future<void> _syncBankData(String bankCode, String token) async {
    try {
      // Configure bank-specific API endpoints
      final bankConfig = _getBankApiConfig(bankCode);
      if (bankConfig == null) return;

      _dio.options.baseUrl = bankConfig['baseUrl']!;
      _dio.options.headers['Authorization'] = 'Bearer $token';

      // Fetch account balances
      final accountsResponse = await _dio.get('/accounts');
      final accounts = accountsResponse.data['accounts'] as List;

      // Fetch transactions
      final transactionsResponse = await _dio.get('/transactions');
      final transactions = transactionsResponse.data['transactions'] as List;

      final storageService = ref.read(enhancedStorageServiceProvider.notifier);

      // Process and store account data
      for (final account in accounts) {
        final accountData = {
          'id': account['account_id'],
          'bank_name': bankCode.toUpperCase(),
          'account_type': account['account_type'] ?? 'savings',
          'balance': (account['balance'] as num).toDouble(),
          'currency': account['currency'] ?? 'INR',
          'last_updated': DateTime.now().toIso8601String(),
          'metadata': {
            'account_number': account['account_number'],
            'ifsc': account['ifsc'],
            'branch': account['branch'],
          },
        };

        await _storeBankAccount(accountData);
      }

      // Process and store transaction data
      for (final transaction in transactions) {
        final transactionData = {
          'id': transaction['transaction_id'],
          'account_id': transaction['account_id'],
          'amount': (transaction['amount'] as num).toDouble(),
          'type': transaction['type'] == 'credit' ? 'credit' : 'debit',
          'description': transaction['description'] ?? '',
          'category': _categorizeTransaction(transaction['description'] ?? ''),
          'date': DateTime.parse(transaction['date']).toIso8601String(),
          'balance': (transaction['balance'] as num?)?.toDouble(),
          'metadata': {
            'reference_number': transaction['reference_number'],
            'merchant': transaction['merchant'],
            'location': transaction['location'],
          },
        };

        await _storeTransaction(transactionData);
      }

    } catch (e) {
      debugPrint('Bank data sync failed for $bankCode: $e');
    }
  }

  /// Get bank API configuration
  Map<String, String>? _getBankApiConfig(String bankCode) {
    final configs = {
      'sbi': {
        'baseUrl': 'https://api.sbi.co.in/v1',
        'clientId': 'your_sbi_client_id',
      },
      'hdfc': {
        'baseUrl': 'https://api.hdfcbank.com/v1',
        'clientId': 'your_hdfc_client_id',
      },
      'icici': {
        'baseUrl': 'https://api.icicibank.com/v1',
        'clientId': 'your_icici_client_id',
      },
      'axis': {
        'baseUrl': 'https://api.axisbank.com/v1',
        'clientId': 'your_axis_client_id',
      },
    };

    return configs[bankCode];
  }

  /// Sync investment data (Mutual Funds, Stocks, etc.)
  Future<void> _syncInvestmentData() async {
    try {
      await Future.wait([
        _syncMutualFundsData(),
        _syncStocksData(),
        _syncBondsData(),
      ]);
    } catch (e) {
      debugPrint('Investment data sync failed: $e');
    }
  }

  /// Sync mutual funds data
  Future<void> _syncMutualFundsData() async {
    try {
      // Example: Sync with AMFI (Association of Mutual Funds in India)
      _dio.options.baseUrl = 'https://api.mfapi.in';
      
      final response = await _dio.get('/mf');
      final mutualFunds = response.data as List;

      final storageService = ref.read(enhancedStorageServiceProvider.notifier);
      
      // Get user's mutual fund holdings
      final userHoldings = storageService.getCachedData('mf_holdings') ?? {};

      for (final fund in mutualFunds) {
        final schemeCode = fund['schemeCode'].toString();
        
        if (userHoldings.containsKey(schemeCode)) {
          // Fetch current NAV
          final navResponse = await _dio.get('/mf/$schemeCode');
          final navData = navResponse.data['data'][0];

          final investment = Investment(
            id: 'mf_$schemeCode',
            symbol: schemeCode,
            name: fund['schemeName'],
            shares: (userHoldings[schemeCode]['units'] as num).toDouble(),
            currentPrice: (navData['nav'] as num).toDouble(),
            purchasePrice: (userHoldings[schemeCode]['invested'] as num).toDouble() / (userHoldings[schemeCode]['units'] as num).toDouble(),
            purchaseDate: DateTime.now().subtract(const Duration(days: 30)), // Default to 30 days ago
            type: InvestmentType.mutualFund,
            metadata: {
              'fund_house': fund['fundHouse'],
              'scheme_type': fund['schemeType'],
              'scheme_category': fund['schemeCategory'],
            },
          );

          await _storeInvestment(investment.toJson());
        }
      }
    } catch (e) {
      debugPrint('Mutual funds sync failed: $e');
    }
  }

  /// Sync stocks data
  Future<void> _syncStocksData() async {
    try {
      // Example: Sync with NSE/BSE APIs
      _dio.options.baseUrl = 'https://api.nseindia.com';
      
      final storageService = ref.read(enhancedStorageServiceProvider.notifier);
      final userStocks = storageService.getCachedData('stock_holdings') ?? {};

      for (final symbol in userStocks.keys) {
        try {
          final response = await _dio.get('/api/quote-equity?symbol=$symbol');
          final stockData = response.data;

          final investment = Investment(
            id: 'stock_$symbol',
            symbol: symbol,
            name: stockData['companyName'] ?? symbol,
            shares: (userStocks[symbol]['quantity'] as num).toDouble(),
            currentPrice: (stockData['priceInfo']['lastPrice'] as num).toDouble(),
            purchasePrice: (userStocks[symbol]['invested'] as num).toDouble() / (userStocks[symbol]['quantity'] as num).toDouble(),
            purchaseDate: DateTime.now().subtract(const Duration(days: 30)), // Default to 30 days ago
            type: InvestmentType.stock,
            metadata: {
              'exchange': 'NSE',
              'sector': stockData['industryInfo']['sector'],
              'market_cap': stockData['marketCap'],
              'pe_ratio': stockData['priceInfo']['pChange'],
            },
          );

          await _storeInvestment(investment.toJson());
        } catch (e) {
          debugPrint('Stock sync failed for $symbol: $e');
        }
      }
    } catch (e) {
      debugPrint('Stocks sync failed: $e');
    }
  }

  /// Sync bonds data
  Future<void> _syncBondsData() async {
    try {
      // Example: Sync government and corporate bonds
      final storageService = ref.read(enhancedStorageServiceProvider.notifier);
      final userBonds = storageService.getCachedData('bond_holdings') ?? {};

      for (final bondId in userBonds.keys) {
        final bondInfo = userBonds[bondId];
        
        final investment = Investment(
          id: 'bond_$bondId',
          symbol: bondId,
          name: bondInfo['name'],
          shares: (bondInfo['units'] as num).toDouble(),
          currentPrice: (bondInfo['face_value'] as num).toDouble(),
          purchasePrice: (bondInfo['invested'] as num).toDouble() / (bondInfo['units'] as num).toDouble(),
          purchaseDate: DateTime.now().subtract(const Duration(days: 30)), // Default to 30 days ago
          type: InvestmentType.bond,
          metadata: {
            'issuer': bondInfo['issuer'],
            'maturity_date': bondInfo['maturity_date'],
            'coupon_rate': bondInfo['coupon_rate'],
            'credit_rating': bondInfo['credit_rating'],
          },
        );

        await _storeInvestment(investment.toJson());
      }
    } catch (e) {
      debugPrint('Bonds sync failed: $e');
    }
  }

  /// Sync cryptocurrency data
  Future<void> _syncCryptocurrencyData() async {
    try {
      // Example: Sync with CoinGecko API
      _dio.options.baseUrl = 'https://api.coingecko.com/api/v3';
      
      final storageService = ref.read(enhancedStorageServiceProvider.notifier);
      final userCrypto = storageService.getCachedData('crypto_holdings') ?? {};

      if (userCrypto.isNotEmpty) {
        final cryptoIds = userCrypto.keys.join(',');
        final response = await _dio.get('/simple/price?ids=$cryptoIds&vs_currencies=inr');
        final prices = response.data;

        for (final cryptoId in userCrypto.keys) {
          final currentPrice = prices[cryptoId]?['inr'];
          if (currentPrice != null) {
            final investment = Investment(
              id: 'crypto_$cryptoId',
              symbol: cryptoId,
              name: cryptoId.toUpperCase(),
              shares: (userCrypto[cryptoId]['quantity'] as num).toDouble(),
              currentPrice: (currentPrice as num).toDouble(),
              purchasePrice: (userCrypto[cryptoId]['invested'] as num).toDouble() / (userCrypto[cryptoId]['quantity'] as num).toDouble(),
              purchaseDate: DateTime.now().subtract(const Duration(days: 30)), // Default to 30 days ago
              type: InvestmentType.crypto,
              metadata: {
                'exchange': userCrypto[cryptoId]['exchange'],
                'wallet_address': userCrypto[cryptoId]['wallet_address'],
              },
            );

            await _storeInvestment(investment.toJson());
          }
        }
      }
    } catch (e) {
      debugPrint('Cryptocurrency sync failed: $e');
    }
  }

  /// Sync market data and indices
  Future<void> _syncMarketData() async {
    try {
      _dio.options.baseUrl = 'https://api.nseindia.com';
      
      // Fetch major indices
      final indices = ['NIFTY 50', 'NIFTY BANK', 'SENSEX'];
      
      for (final index in indices) {
        try {
          final response = await _dio.get('/api/allIndices');
          final indexData = response.data['data']
              .firstWhere((item) => item['index'] == index, orElse: () => null);

          if (indexData != null) {
            final marketData = {
              'name': index,
              'value': (indexData['last'] as num).toDouble(),
              'change': (indexData['change'] as num).toDouble(),
              'change_percent': (indexData['percentChange'] as num).toDouble(),
              'last_updated': DateTime.now().toIso8601String(),
            };

            await _storeMarketIndex(marketData);
          }
        } catch (e) {
          debugPrint('Index sync failed for $index: $e');
        }
      }
    } catch (e) {
      debugPrint('Market data sync failed: $e');
    }
  }

  /// Categorize transaction based on description
  String _categorizeTransaction(String description) {
    final desc = description.toLowerCase();
    
    if (desc.contains('atm') || desc.contains('cash')) return 'Cash Withdrawal';
    if (desc.contains('grocery') || desc.contains('supermarket')) return 'Groceries';
    if (desc.contains('fuel') || desc.contains('petrol')) return 'Fuel';
    if (desc.contains('restaurant') || desc.contains('food')) return 'Food & Dining';
    if (desc.contains('medical') || desc.contains('pharmacy')) return 'Healthcare';
    if (desc.contains('electricity') || desc.contains('water')) return 'Utilities';
    if (desc.contains('salary') || desc.contains('income')) return 'Income';
    if (desc.contains('transfer')) return 'Transfer';
    if (desc.contains('investment')) return 'Investment';
    if (desc.contains('insurance')) return 'Insurance';
    if (desc.contains('loan') || desc.contains('emi')) return 'Loan/EMI';
    
    return 'Others';
  }

  /// Store bank account data
  Future<void> _storeBankAccount(Map<String, dynamic> accountData) async {
    try {
      final storageService = ref.read(enhancedStorageServiceProvider.notifier);
      await storageService.cacheData(
        'bank_account_${accountData['id']}',
        accountData,
        ttl: const Duration(hours: 6),
      );
    } catch (e) {
      debugPrint('Failed to store bank account: $e');
    }
  }

  /// Store transaction data
  Future<void> _storeTransaction(Map<String, dynamic> transactionData) async {
    try {
      final storageService = ref.read(enhancedStorageServiceProvider.notifier);
      await storageService.cacheData(
        'transaction_${transactionData['id']}',
        transactionData,
        ttl: const Duration(days: 30),
      );
    } catch (e) {
      debugPrint('Failed to store transaction: $e');
    }
  }

  /// Store investment data
  Future<void> _storeInvestment(Map<String, dynamic> investmentData) async {
    try {
      final storageService = ref.read(enhancedStorageServiceProvider.notifier);
      await storageService.cacheData(
        'investment_${investmentData['id']}',
        investmentData,
        ttl: const Duration(hours: 1),
      );
    } catch (e) {
      debugPrint('Failed to store investment: $e');
    }
  }

  /// Store market index data
  Future<void> _storeMarketIndex(Map<String, dynamic> marketData) async {
    try {
      final storageService = ref.read(enhancedStorageServiceProvider.notifier);
      await storageService.cacheData(
        'market_index_${marketData['name']}',
        marketData,
        ttl: const Duration(minutes: 15),
      );
    } catch (e) {
      debugPrint('Failed to store market index: $e');
    }
  }

  /// Manual sync trigger
  Future<void> forceSyncFinancialData() async {
    await _syncFinancialData();
  }

  /// Get financial summary
  Future<Map<String, dynamic>> getFinancialSummary() async {
    try {
      final storageService = ref.read(enhancedStorageServiceProvider.notifier);
      
      // Get cached financial data
      final portfolio = storageService.loadPortfolio();
      final goals = storageService.loadFinancialGoals();
      
      double totalInvestments = 0;
      double totalReturns = 0;
      
      // Calculate portfolio value (simplified)
      if (portfolio != null) {
        totalInvestments = portfolio.totalValue;
      }

      return {
        'total_investments': totalInvestments,
        'total_returns': totalReturns,
        'goals_count': goals.length,
        'last_updated': DateTime.now().toIso8601String(),
      };
    } catch (e) {
      debugPrint('Failed to get financial summary: $e');
      return {};
    }
  }

  /// Check if financial APIs are connected
  Future<bool> areFinancialApisConnected() async {
    try {
      final storageService = ref.read(enhancedStorageServiceProvider.notifier);
      final bankingTokens = storageService.getCachedData('banking_tokens');
      final investmentTokens = storageService.getCachedData('investment_tokens');
      
      return bankingTokens != null || investmentTokens != null;
    } catch (e) {
      return false;
    }
  }

  /// Dispose resources
  void dispose() {
    _syncTimer?.cancel();
  }
}