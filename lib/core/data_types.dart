import 'package:clean_architecture_posts_app/features/posts/data/models/post_model.dart';
import 'package:clean_architecture_posts_app/features/posts/domain/entities/post.dart';

typedef ReturnedDataFromApi = Map<String, dynamic>;
typedef ListOfPostModel=List<PostModel>;
typedef ListOfPost=List<Post>;
PostModel Function(dynamic) convertFromJsonToPostModel= (jsonPostModel) => PostModel.fromJson(jsonPostModel);
