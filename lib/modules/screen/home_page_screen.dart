import 'package:fashion/authentication_screen/layout/layout_cubit/layout_cubit.dart';
import 'package:fashion/authentication_screen/layout/layout_cubit/layout_state.dart';
import 'package:fashion/constant/color.dart';
import 'package:fashion/models/product_model.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePages extends StatelessWidget {
  final pageController = PageController();

  HomePages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LayoutCubit>(context);
    return BlocConsumer<LayoutCubit, LayoutState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
                backgroundColor: navColor,
              title: Expanded(
                child: Row(
                  children:
                  [
                     const Text('Fashion',style: TextStyle(color: mainColor),),
                    SizedBox(width: 5,),
                    Expanded(
                      child: TextFormField(
                        onChanged: (input){
                          cubit.filterProduct(input: input);
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          hintText: 'Search',
                          suffixIcon: Icon(Icons.clear),
                          contentPadding: EdgeInsets.zero,
                          filled: true,
                          fillColor: mainnColor,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            body: Padding(
          padding: const EdgeInsets.all(13.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              cubit.bannerModel.isEmpty
                  ? const Center(
                      child: CupertinoActivityIndicator(),
                    )
                  : SizedBox(
                      height: 125,
                      width: double.infinity,
                      child: PageView.builder(
                          controller: pageController,
                          physics: BouncingScrollPhysics(),
                          itemCount: cubit.bannerModel.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.only(right: 15),
                              child: Image.network(
                                cubit.bannerModel[index].url!,
                                fit: BoxFit.fill,
                              ),
                            );
                          }),
                    ),
              const SizedBox(
                height: 15,
              ),
              Center(
                child: SmoothPageIndicator(
                  controller: pageController,
                  count: cubit.bannerModel.length,
                  axisDirection: Axis.horizontal,
                  effect: SlideEffect(
                    spacing: 8.0,
                    radius: 20,
                    dotWidth: 12,
                    dotHeight: 12.0,
                    paintStyle: PaintingStyle.stroke,
                    strokeWidth: 1.5,
                    dotColor: Colors.grey,
                    activeDotColor: secondColor,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Category',
                    style: TextStyle(
                        color: mainColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'View all',
                    style: TextStyle(
                        color: secondColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              cubit.categoryModel.isEmpty
                  ? const Center(
                      child: CupertinoActivityIndicator(),
                    )
                  : SizedBox(
                      height: 70,
                      width: double.infinity,
                      child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: cubit.categoryModel.length,
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              width: 10,
                            );
                          },
                          itemBuilder: (context, index) {
                            return CircleAvatar(
                              radius: 35,
                              backgroundImage:
                                  NetworkImage(cubit.categoryModel[index].url!),
                            );
                          }),
                    ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Products',
                    style: TextStyle(
                        color: mainColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'View all',
                    style: TextStyle(
                        color: secondColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              cubit.productModel.isEmpty
                  ? const Center(
                      child: CupertinoActivityIndicator(),
                    )
                  : GridView.builder(
                      itemCount: cubit.filteredProduct.isEmpty ?
                      cubit.productModel.length :
                      cubit.filteredProduct.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 12,
                              childAspectRatio: .8),
                      itemBuilder: (context, index) {
                        return _productItem(
                            model: cubit.filteredProduct.isEmpty ?
                                   cubit.productModel[index]:
                                   cubit.filteredProduct[index],
                                cubit: cubit
                        );
                      }),
            ],
          ),
        ));
      },
    );
  }
}

Widget _productItem({required ProductModel model,required LayoutCubit cubit}) {
  return Stack(
    children: [
      Container(
        decoration:  BoxDecoration(
          color: Colors.grey.withOpacity(.2),
          borderRadius: BorderRadius.circular(12),
        ),

        padding: EdgeInsets.symmetric(vertical: 25, horizontal: 12),
        child: Column(
          children: [
            Expanded(child: Image.network(model.image!,fit: BoxFit.fill,),),
            const SizedBox(
              height: 20,
            ),
            Text(
              model.name!,
              style: TextStyle(
                  fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis),
            ),
            const SizedBox(
              height: 7,
            ),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Text(
                        '${model.price!}\$',
                        style: TextStyle(fontSize: 13),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        '${model.oldPrice!}\$',
                        style: TextStyle(color: Colors.grey,
                            fontSize: 12.5, decoration: TextDecoration.lineThrough),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  child:  Icon(
                    Icons.favorite,
                    size: 20,
                    color: cubit.favoriteID.contains(model.id.toString()) ? Colors.red :  Colors.grey,
                  ),
                  onTap: ()
                  {
                    //add || remove item
                    cubit.addOrRemoveFavorites(productID: model.id.toString());
                  },
                ),
              ],
            )
          ],
        ),
      ),
      CircleAvatar(
        backgroundColor: navColor,

        child: GestureDetector(

          onTap:()
          {
            cubit.addOrRemoveCartItem(id: model.id.toString());
          },
          child: Icon(Icons.shopping_cart,size:15,color: cubit.cartID.contains(model.id.toString()) ? Colors.red : mainColor,
          ),
        ),
      )
    ],
  );
}
