abstract class LayoutState {}

class LayoutInitialState extends LayoutState {}


// state get user profile
class GetUserDataSuccessState extends LayoutState{}
class GetUserDataLoadingState extends LayoutState{}
class FailedToGetUserDataState extends LayoutState{
  String error;
  FailedToGetUserDataState({required this.error});
}

// state navigation bar
class ChangeBottomNavIndexState extends LayoutState{}

//state banner data
class GetBannerSuccessState extends LayoutState{}
class GetBannerLoadingState extends LayoutState{}
class FailedToGetBannerState extends LayoutState{}

//state category data
class GetCategorySuccessState extends LayoutState{}
class GetCategoryLoadingState extends LayoutState{}
class FailedToGetCategoryState extends LayoutState{}

// state product data
class GetProductSuccessState extends LayoutState{}
class GetProductLoadingState extends LayoutState{}
class FailedToGetProductState extends LayoutState{}

// state search
class FilterProductSuccessState extends LayoutState{}
class FilterCartSuccessState extends LayoutState{}
class FilterFavoriteSuccessState extends LayoutState{}
class FilterCategorySuccessState extends LayoutState{}

// state Favorites data
class GetFavoritesSuccessState extends LayoutState{}
class GetFavoritesLoadingState extends LayoutState{}
class FailedToGetFavoritesState extends LayoutState{}

// state add or remove Favorites data
class AddOrRemoveFavoritesSuccessState extends LayoutState{}
class AddOrRemoveFavoritesLoadingState extends LayoutState{}
class FailedToAddOrRemoveFavoritesState extends LayoutState{}


// state Carts data
class GetCartsSuccessState extends LayoutState{}
class GetCartsLoadingState extends LayoutState{}
class FailedToGetCartsState extends LayoutState{}

// state add or remove Carts data
class AddOrRemoveCartsSuccessState extends LayoutState{}
class AddOrRemoveCartsLoadingState extends LayoutState{}
class FailedToAddOrRemoveCartsState extends LayoutState{}