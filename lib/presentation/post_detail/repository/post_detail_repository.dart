import 'package:yash_practical/core/constants/constants.dart';
import 'package:yash_practical/core/services/connectivity_config/connectivity_helper.dart';
import 'package:yash_practical/core/services/network/api_base_helper.dart';
import 'package:yash_practical/core/utility/utility.dart';
import 'package:yash_practical/models/api_response_model.dart';
import 'package:yash_practical/models/result_model.dart';
import 'package:yash_practical/presentation/dashboard/models/posts_model.dart';

class PostDetailRepository {
  Future<ResultModel> callPostsDetailApi({required int postId}) async {
    try {
      if (await ConnectivityHelper().checkConnectivity()) {
        final ApiResponseModel model = await ApiBaseHelper().get(
          api: ApiConstants.getPostDetail(postId: postId),
        );
        if (model.success) {
          if (model.apiResponse != null) {
            final PostsModel posts = PostsModel.fromJson(
              model.apiResponse! as Map<String, dynamic>,
            );
            return ResultModel(
              success: true,
              result: posts,
            );
          } else {
            throw StringConstants.msgNoDataFound;
          }
        } else {
          throw model.error;
        }
      } else {
        throw StringConstants.msgNoInternet;
      }
    } catch (e) {
      Utility.showLog('Error in Repository calling Api: ${e.toString()}');
      throw e;
    }
  }
}
