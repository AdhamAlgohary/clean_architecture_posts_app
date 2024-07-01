import 'package:clean_architecture_posts_app/core/network/network_info.dart';
import 'package:clean_architecture_posts_app/features/posts/data/datasources/post_local_data_source.dart';
import 'package:clean_architecture_posts_app/features/posts/data/datasources/post_remote_data_source.dart';
import 'package:clean_architecture_posts_app/features/posts/data/repositories/post_repositories_impl.dart';
import 'package:clean_architecture_posts_app/features/posts/domain/repositories/post_repositories.dart';
import 'package:clean_architecture_posts_app/features/posts/domain/usecases/add_post_use_case.dart';
import 'package:clean_architecture_posts_app/features/posts/domain/usecases/delete_post_use_case.dart';
import 'package:clean_architecture_posts_app/features/posts/domain/usecases/get_all_posts_use_case.dart';
import 'package:clean_architecture_posts_app/features/posts/domain/usecases/update_post_use_case.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

final gi = GetIt.instance;

  init() async {
  // features : posts

  //Bloc
  gi.registerFactory(() => PostsBloc(getAllPosts: gi()));
  gi.registerFactory(() => AddDeleteUpdatePostBloc(
      addPost: gi(), deletePost: gi(), updatePost: gi()));

  //Usecases
  gi.registerLazySingleton(() => AddPostUseCase(gi()));
  gi.registerLazySingleton(() => UpdatePostUseCase(gi()));
  gi.registerLazySingleton(() => DeletePostUseCase(gi()));
  gi.registerLazySingleton(() => GetAllPostsUseCase(gi()));

  //Repositories
  gi.registerLazySingleton<PostRepositories>(() => PostRepositoriesImpl(gi(),
      postRemoteDataSource: gi(), postLocalDataSource: gi()));
  //Datasources
  gi.registerLazySingleton<PostRemoteDataSource>(
      () => PostRemoteDataSourceImplWithHttp(client: gi()));
  gi.registerLazySingleton<PostLocalDataSource>(() =>
      PostLocalDataSourceImplWithSharedPerfernces(sharedPreferences: gi()));
  //Core
  gi.registerLazySingleton<NetworkInfo>(() =>
      NetworkInfoImplWithConnectionChecker(internetConnectionChecker: gi()));
  //External
  final sharedPreferences = await SharedPreferences.getInstance();
  gi.registerLazySingleton(() => sharedPreferences);
  gi.registerLazySingleton(() => http.Client());
  gi.registerLazySingleton(() => InternetConnectionChecker());
}
