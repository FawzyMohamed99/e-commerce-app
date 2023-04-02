import 'package:fashion/authentication_screen/layout/layout_cubit/layout_cubit.dart';
import 'package:fashion/authentication_screen/layout/layout_cubit/layout_state.dart';
import 'package:fashion/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LayoutCubit>(context);
    return BlocConsumer<LayoutCubit, LayoutState>(
      listener: (context, state) {
        // TODO: implement listener
      },
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
                        cubit.filterCart(input: input);
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
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            child: Column(
              children: [
                Expanded(
                  child: cubit.cartModel.isNotEmpty
                      ? ListView.separated(
                          shrinkWrap: true,
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              height: 0,
                            );
                          },
                          itemCount: cubit.filteredCart.isEmpty?
                          cubit.cartModel.length
                          : cubit.filteredCart.length,

                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                decoration:  BoxDecoration(
                                  color: Colors.grey.withOpacity(.4),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.network(
                                        cubit.cartModel[index].image!,
                                        fit: BoxFit.fill,
                                        width: 120,
                                        height: 135,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            cubit.cartModel[index].name!,
                                            style: TextStyle(
                                                color: mainColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                                overflow:
                                                    TextOverflow.ellipsis),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                  '${cubit.cartModel[index].price!} \$'),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              if (cubit
                                                      .cartModel[index].price !=
                                                  cubit.cartModel[index]
                                                      .oldPrice)
                                                Text(
                                                  '${cubit.cartModel[index].oldPrice!} \$',
                                                  style: TextStyle(
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                    color: Colors.grey,
                                                  ),
                                                )
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                OutlinedButton(
                                                  onPressed: ()
                                                  {
                                                    cubit.addOrRemoveFavorites(productID: cubit.cartModel[index].id.toString());
                                                  },
                                                  child: Icon(
                                                    Icons.favorite,
                                                    color: cubit.favoriteID
                                                            .contains(cubit
                                                                .cartModel[index]
                                                                .id
                                                                .toString())
                                                        ? Colors.red
                                                        : Colors.grey,
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: ()
                                                  {
                                                    cubit.addOrRemoveCartItem(id: cubit.cartModel[index].id!.toString());
                                                  },
                                                  child:const Icon(
                                                    Icons.delete,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          })
                      : Center(
                          child: Text('Loading....',style: TextStyle(color: mainColor,fontSize: 16,fontWeight: FontWeight.bold),),
                        ),
                ),
                Container(
                    margin: EdgeInsets.all(5),
                     decoration: BoxDecoration(
                       color: navColor,
                       borderRadius: BorderRadius.circular(12),
                     ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Total Price is : ${cubit.totalPrice} \$',
                            style: TextStyle(
                                color: mainColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),



              ],
            ),
          ),
        );
      },
    );
  }
}
