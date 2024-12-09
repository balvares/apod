// import 'package:apod/app/domain/entities/apod_entity.dart';
// import 'package:apod/app/domain/repositories/apod_repository.dart';
// import 'package:apod/app/domain/usecases/get_apod_usecase_impl.dart';
// import 'package:apod/app/domain/usecases/interfaces/get_apod_usecase.dart';
// import 'package:apod/app/presentation/providers/apod_provider.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';

// import 'widget_test.mocks.dart';

// @GenerateMocks([GetAPODUsecase, APODRepository])
// void main() {
//   group('APODProvider', () {
//     late APODProvider provider;
//     late MockGetAPODUsecase mockUseCase;
//     late MockGetAPODListUsecase mockListUseCase;
//     late GetAPODUsecase getApodUseCase;
//     late GetAPODUsecase getApodListUseCase;
//     late MockAPODRepository mockRepository;

//     setUp(() {
//       mockUseCase = MockGetAPODUsecase();
//       provider = APODProvider(getAPODUseCase: mockUseCase, getAPODListUseCase: getApodListUseCase);
//       mockRepository = MockAPODRepository();
//       getApodUseCase = GetAPODUseCaseImpl(repository: mockRepository);
//     });

//     test('initial state is correct', () {
//       expect(provider.isLoading, false);
//       expect(provider.apod, null);
//       expect(provider.error, null);
//     });

//     test('fetchAPOD updates state on success', () async {
//       final apod = APODEntity(
//         title: 'Test Title',
//         url: 'https://example.com/image.jpg',
//         explanation: 'Test Explanation',
//       );

//       when(mockUseCase.call(date: anyNamed('date')))
//           .thenAnswer((_) async => apod);

//       await provider.fetchAPOD();

//       expect(provider.isLoading, false);
//       expect(provider.error, null);
//       expect(provider.apod, apod);
//     });

//     // todo check
//     test('fetchAPOD updates state on failure', () async {
//       when(mockUseCase.call(date: anyNamed('date')))
//           .thenThrow(Exception('Network Error'));

//       await provider.fetchAPOD();

//       expect(provider.isLoading, false);
//       expect(provider.apod, null);
//       expect(provider.error, 'Failed to load APOD: Exception: Network Error');
//     });

//     // test('returns APODEntity on success', () async {
//     //   final apod = APODEntity(
//     //     title: 'Test Title',
//     //     url: 'https://example.com/image.jpg',
//     //     explanation: 'Test Explanation',
//     //   );

//     //   when(mockRepository.getAPOD(any, date: DateTime.now()))
//     //       .thenAnswer((_) async => apod);

//     //   final result = await getApodUseCase.call(date: DateTime.now());

//     //   expect(result, apod);
//     //   verify(mockRepository.getAPOD(any, date: DateTime.now())).called(1);
//     // });
//   });
// }
