import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cubit/cubit/app_cubit_states.dart';
import 'package:flutter_cubit/cubit/app_cubits.dart';
import 'package:flutter_cubit/misc/colors.dart';
import 'package:flutter_cubit/widgets/app_buttons.dart';
import 'package:flutter_cubit/widgets/app_large_text.dart';
import 'package:flutter_cubit/widgets/app_text.dart';
import 'package:flutter_cubit/widgets/responsive_button.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubits, CubitStates>(
      builder: (context, state){
        DetailState detail = state as DetailState;

        return SafeArea(
          child: Scaffold(
            body: Container(
              width: double.maxFinite,
              height: double.maxFinite,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    right: 0,
                    child: Container(
                      width: double.maxFinite,
                      height: 250,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            "http://mark.bslmeiyu.com/uploads/${detail.place.img}"
                          ),
                          fit: BoxFit.cover
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 20,
                    left: 20,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            BlocProvider.of<AppCubits>(context).goHome();
                          },
                          icon: const Icon(Icons.menu, color: Colors.white,),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 220,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      width: MediaQuery.of(context).size.width,
                      height: 800,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))
                      ),
                      child: ListView(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppLargeText(text: detail.place.name, color: Colors.black.withOpacity(0.8),),
                              AppLargeText(text: "\$${detail.place.price}", color: AppColors.mainColor,)
                            ],
                          ),
                          
                          const SizedBox(height: 5,),
                      
                          Row(
                            children: [
                              const Icon(Icons.location_on, color: AppColors.mainColor),
                              const SizedBox(width: 5,),
                              AppText(text: detail.place.location, color: AppColors.textColor1,)
                            ],
                          ),
                      
                          const SizedBox(height: 10,),
                      
                          Row(
                            children: [
                              Wrap(
                                children: List.generate(5, (index){
                                  return index <= detail.place.stars - 1 ? Icon(Icons.star, color: Colors.amber,) : Icon(Icons.star_border, color: Colors.grey,);
                                }),
                              ),
                              const SizedBox(width: 10,),
                              AppText(text: "(${detail.place.stars}.0)", color: AppColors.textColor2,)
                            ],
                          ),
                      
                          const SizedBox(height: 10,),
                      
                          AppLargeText(text: "People", color: Colors.black.withOpacity(0.8), size: 16,),
                          AppText(text: "Number of people in your group", color: AppColors.mainTextColor,),
                      
                          const SizedBox(height: 10,),
                      
                          Wrap(
                            children: List.generate(5, (index){
                              return InkWell(
                                onTap: (){
                                  setState(() {
                                    selectedIndex = index;                              
                                  });
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(right: 5),
                                  child: AppButton(
                                    color: selectedIndex == index ? Colors.white : Colors.black, 
                                    backgroundColor: selectedIndex == index ? Colors.black : AppColors.buttonBackground, 
                                    size: 50, 
                                    borderColor: selectedIndex == index ? Colors.black : AppColors.buttonBackground, 
                                    text: (index+1).toString(),
                                  )
                                ),
                              );
                            })
                          ),
                      
                          const SizedBox(height: 10,),
                      
                          AppLargeText(text: "Description", color: Colors.black.withOpacity(0.8),),
                          AppText(
                            text: detail.place.description, 
                            color: AppColors.mainTextColor,
                            size: 14,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 20,
                    right: 20,
                    child: Row(
                      children: [
                        AppButton(
                          color: AppColors.textColor2, 
                          backgroundColor: Colors.white, 
                          size: 60, 
                          borderColor: AppColors.textColor2,
                          isIcon: true,
                          icon: Icons.favorite_border,
                        ),
                        const SizedBox(width: 20,),
                        ResponsiveButton(
                          isResponsive: true
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}