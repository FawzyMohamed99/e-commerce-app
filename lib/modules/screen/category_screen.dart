import 'package:fashion/authentication_screen/layout/layout_cubit/layout_cubit.dart';
import 'package:fashion/authentication_screen/layout/layout_cubit/layout_state.dart';
import 'package:fashion/constant/color.dart';
import 'package:fashion/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<CategoryModel> categoryData = BlocProvider
        .of<LayoutCubit>(context)
        .categoryModel;
    final cubit=BlocProvider.of<LayoutCubit>(context);
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
                        cubit.filterCategory(input: input);
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
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child: GridView.builder(
                itemCount: cubit.filteredCategory.isEmpty?
                categoryData.length
                : cubit.filteredCategory.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 18,
                  crossAxisSpacing: 15,
                ),
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(.4),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children:
                      [
                        Expanded(child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.network(
                            categoryData[index].url!, fit: BoxFit.fill,),
                        )),
                        const SizedBox(height: 10,),
                        Text(categoryData[index].title!,)
                      ],
                    ),
                  );
                }),
          ),
        );
      },
    );
  }
}
