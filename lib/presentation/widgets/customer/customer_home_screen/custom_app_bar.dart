import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../bussines_logic/cubits/customer/Offers_Screen/cubit/customer_offers_screen_cubit.dart';
import '../../../../data/model/offer_model.dart';
import '../customer_offers_screen/custom_offer_status_badge.dart';
import '../../admin/Offers_Screen/offer_card/helper_functions.dart';
import 'custom_filter_row_item.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required this.onSearchChanged,
    required this.onFilterAllTapped,
    required this.onFilterSandwichesTapped,
    required this.onFilterPizzasTapped,
    required this.onFilterCrepesTapped,
    required this.onFilterMealsTapped,
    required this.onFilterDrinksTapped,
    required this.onFilterDesertsTapped,
    required this.selectedFilter,
  });

  final Function(String) onSearchChanged;
  final Function() onFilterAllTapped;
  final Function() onFilterSandwichesTapped;
  final Function() onFilterPizzasTapped;
  final Function() onFilterCrepesTapped;
  final Function() onFilterMealsTapped;
  final Function() onFilterDrinksTapped;
  final Function() onFilterDesertsTapped;
  final String selectedFilter;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<CustomerOffersScreenCubit, CustomerOffersScreenState>(
          builder: (context, state) {
            if (state is CustomerOffersScreenLoading) {
              return SizedBox(
                width: double.infinity,
                height: 200,
                child: const Center(
                  child: CircularProgressIndicator(color: Colors.brown),
                ),
              );
            } else if (state is CustomerOffersScreenSuccess) {
              final List<Offer> offers = state.offers;
              if (offers.isNotEmpty) {
                return CarouselSlider.builder(
                  options: CarouselOptions(
                    height: 200,
                    aspectRatio: 16 / 9,
                    viewportFraction: 0.95,
                    initialPage: 0,
                    enableInfiniteScroll: state.offers.length > 1,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration: const Duration(
                      milliseconds: 800,
                    ),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal,
                  ),
                  itemCount: offers.length,
                  itemBuilder: (context, index, realIndex) {
                    final OfferStatus status = HelperFunctions.status(
                      offers[index],
                    );
                    return Stack(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage(offers[index].imageUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 20,
                          right: 20,
                          child: OfferStatusBadge(offer: offers[index]),
                        ),
                        Positioned(
                          bottom: 20,
                          left: 20,
                          child: Text(
                            offers[index].title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 20,
                          left: 20,
                          child: Container(
                            decoration: BoxDecoration(
                              color: status.name != 'Expired'
                                  ? const Color(0xFFC58B3E)
                                  : const Color(0xFFC58B3E).withAlpha(100),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: MaterialButton(
                              minWidth: 100,
                              height: 40,
                              onPressed: status.name != 'Expired'
                                  ? () => Navigator.pushNamed(
                                      context,
                                      '/customerOfferDetailsScreen',
                                      arguments: offers[index],
                                    )
                                  : null,
                              child: const Text(
                                'Order Now',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              } else {
                return ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  child: Image.asset(
                    'assets/images/pngtree-food-delivery-fast-food-unhealthy-obesity-concept-image_15654211.jpg',
                    fit: BoxFit.cover,
                  ),
                );
              }
            } else if (state is CustomerOffersScreenError) {
              return Center(child: Text(state.message));
            } else {
              return Container();
            }
          },
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: TextField(
              style: const TextStyle(fontSize: 16),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                border: InputBorder.none,
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                hintText: 'Search for food, drinks, or more...',
                hintStyle: TextStyle(color: Colors.grey.shade600),
              ),
              onChanged: onSearchChanged,
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              CustomFilterRowItem(
                filterName: 'All',
                filterIcon: Icons.fastfood,
                filterId: 0,
                isSelected: selectedFilter == 'All',
                onTap: onFilterAllTapped,
              ),
              CustomFilterRowItem(
                filterName: 'Sandwiches',
                filterIcon: Icons.local_drink,
                filterId: 1,
                isSelected: selectedFilter == 'Sandwiches',
                onTap: onFilterSandwichesTapped,
              ),
              CustomFilterRowItem(
                filterName: 'Pizzas',
                filterIcon: Icons.local_pizza,
                filterId: 2,
                isSelected: selectedFilter == 'Pizzas',
                onTap: onFilterPizzasTapped,
              ),
              CustomFilterRowItem(
                filterName: 'Crepes',
                filterIcon: Icons.cake,
                filterId: 3,
                isSelected: selectedFilter == 'Crepes',
                onTap: onFilterCrepesTapped,
              ),
              CustomFilterRowItem(
                filterName: 'Meals',
                filterIcon: Icons.fastfood,
                filterId: 4,
                isSelected: selectedFilter == 'Meals',
                onTap: onFilterMealsTapped,
              ),
              CustomFilterRowItem(
                filterName: 'Desserts',
                filterIcon: Icons.cake,
                filterId: 5,
                isSelected: selectedFilter == 'Desserts',
                onTap: onFilterDesertsTapped,
              ),
              CustomFilterRowItem(
                filterName: 'Drinks',
                filterIcon: Icons.local_drink,
                filterId: 6,
                isSelected: selectedFilter == 'Drinks',
                onTap: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}
