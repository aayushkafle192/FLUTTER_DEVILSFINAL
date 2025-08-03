import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rolo/app/themes/themes_data.dart';
import 'package:rolo/core/widgets/product_card.dart'; 
import 'package:rolo/features/explore/presentation/view_model/explore_event.dart';
import 'package:rolo/features/explore/presentation/view_model/explore_state.dart';
import 'package:rolo/features/explore/presentation/view_model/explore_viewmodel.dart';

class ExploreView extends StatefulWidget {
  const ExploreView({super.key});

  @override
  State<ExploreView> createState() => _ExploreViewState();
}

class _ExploreViewState extends State<ExploreView> {
  @override
  void initState() {
    super.initState();
    context.read<ExploreViewModel>().add(LoadExploreData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 227, 227, 227),
      appBar: AppBar(
        title: const Text('Explore your fashion '),
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 8, 8, 8),
        foregroundColor: const Color.fromARGB(255, 0, 0, 0),
      ),
      body: Column(
        children: [
          _buildFilterControls(),
          Expanded(
            child: BlocBuilder<ExploreViewModel, ExploreState>(
              builder: (context, state) {
                if (state.status == ExploreStatus.loading || state.status == ExploreStatus.initial) {
                  return const Center(child: CircularProgressIndicator(color: Color.fromARGB(255, 250, 249, 248)));
                }
                if (state.status == ExploreStatus.failure) {
                  return Center(child: Text(state.errorMessage, style: AppTheme.bodyStyle));
                }
                if (state.filteredProducts.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text('No products match your criteria.', style: AppTheme.captionStyle, textAlign: TextAlign.center),
                    ),
                  );
                }
                return _buildProductGrid(state);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterControls() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Column(
        children: [
          _buildSearchBar(),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _buildCategoryChips()),
              const SizedBox(width: 8),
              _buildSortButton(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      onChanged: (query) {
        context.read<ExploreViewModel>().add(SearchQueryChanged(query));
      },
      decoration: InputDecoration(
        hintText: 'Search products...',
        prefixIcon: const Icon(Icons.search, color: Color.fromARGB(255, 211, 209, 209)),
        isDense: true,
        filled: true,
        fillColor: const Color.fromARGB(255, 110, 108, 108),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildCategoryChips() {
    return BlocBuilder<ExploreViewModel, ExploreState>(
      buildWhen: (previous, current) =>
          previous.categories != current.categories ||
          previous.selectedCategoryId != current.selectedCategoryId,
      builder: (context, state) {
        return SizedBox(
          height: 35,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: state.categories.length + 1, 
            itemBuilder: (context, index) {
              if (index == 0) {
                final isSelected = state.selectedCategoryId == null;
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: ChoiceChip(
                    label: const Text('All'),
                    selected: isSelected,
                    onSelected: (selected) {
                      context.read<ExploreViewModel>().add(const CategoryFilterChanged(null));
                    },
                    selectedColor: const Color.fromARGB(255, 17, 17, 17),
                    labelStyle: TextStyle(color: isSelected ? const Color.fromARGB(255, 171, 169, 169) : Colors.white),
                    backgroundColor: const Color.fromARGB(255, 215, 212, 212),
                  ),
                );
              }
              final category = state.categories[index - 1];
              final isSelected = state.selectedCategoryId == category.id;
              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: ChoiceChip(
                  label: Text(category.name),
                  selected: isSelected,
                  onSelected: (selected) {
                    final newCategoryId = isSelected ? null : category.id;
                    context.read<ExploreViewModel>().add(CategoryFilterChanged(newCategoryId));
                  },
                  selectedColor: const Color.fromARGB(255, 248, 248, 248),
                  labelStyle: TextStyle(color: isSelected ? Colors.black : Colors.white),
                  backgroundColor: const Color.fromARGB(255, 128, 126, 126),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildSortButton() {
    return BlocBuilder<ExploreViewModel, ExploreState>(
      builder: (context, state) {
        return PopupMenuButton<SortOption>(
          onSelected: (option) {
            context.read<ExploreViewModel>().add(SortOrderChanged(option));
          },
          itemBuilder: (context) => [
            const PopupMenuItem(value: SortOption.none, child: Text('Default')),
            const PopupMenuItem(value: SortOption.priceLowToHigh, child: Text('Price: Low to High')),
            const PopupMenuItem(value: SortOption.priceHighToLow, child: Text('Price: High to Low')),
            const PopupMenuItem(value: SortOption.byDiscount, child: Text('By Discount')),
          ],
          icon: const Icon(Icons.sort, color: Color.fromARGB(255, 246, 245, 243)),
          color: const Color.fromARGB(255, 196, 191, 191),
        );
      },
    );
  }

  Widget _buildProductGrid(ExploreState state) {
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      itemCount: state.filteredProducts.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.65, 
      ),
      itemBuilder: (context, index) {
        final product = state.filteredProducts[index];
        return ProductCard(product: product);
      },
    );
  }
}