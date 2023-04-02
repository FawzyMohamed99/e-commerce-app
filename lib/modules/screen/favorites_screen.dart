import 'package:fashion/authentication_screen/layout/layout_cubit/layout_cubit.dart';
import 'package:fashion/authentication_screen/layout/layout_cubit/layout_state.dart';
import 'package:fashion/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

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
                        cubit.filterFavorite(input: input);
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
            padding:const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            child: Column(
              children: [
                Expanded(
                  child:
                    ListView.builder(
                        itemCount: cubit.filteredFavorite.isEmpty
                        ?cubit.favorites.length:
                cubit.filteredFavorite.length,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 12),
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            decoration:  BoxDecoration(
                              color: Colors.grey.withOpacity(.4),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                 Image.network(
                                    cubit.favorites[index].image!,
                                    fit: BoxFit.fill,
                                    width: 130,
                                    height: 120,
                                  ),
                                const     SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        cubit.favorites[index].name!,
                                        maxLines: 1,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: mainColor,
                                          overflow: TextOverflow.ellipsis,),
                                      ),
                                      const  SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children:
                                        [
                                          Text("${cubit.favorites[index].price!} \$"),
                                          const    SizedBox(width: 5,),
                                          Text("${cubit.favorites[index].oldPrice!} \$",style: TextStyle(color: Colors.grey,decoration: TextDecoration.lineThrough),),
                                        ],
                                      ),
                                      const      SizedBox(
                                        height: 10,
                                      ),
                                      MaterialButton(
                                        onPressed: ()
                                        {
                                          // add || remove
                                          cubit.addOrRemoveFavorites(productID: cubit.favorites[index].id!.toString());
                                        },
                                        child: Text('Remove'),
                                        textColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(25),
                                        ),
                                        color: Colors.red,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),

                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
