import 'package:ecommerce_app/models/models.dart';
import 'package:ecommerce_app/blocs/blocs.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'wishlist_event.dart';

part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistLoading()) {
    on<StartWishlistEvent>(_onStartWishlist);
    on<AddProductToWishlist>(_onAddProductToWishlist);
    on<RemoveProductFromWishlist>(_onRemoveProductFromWishlist);
  }

  void _onStartWishlist(
    StartWishlistEvent event,
    Emitter<WishlistState> emit,
  ) async {
    emit(WishlistLoading());
    try {
      // Box box = await _localStorageRepository.openBox();
      // List<Product> products = _localStorageRepository.getWishlist(box);
      emit(
        const WishlistLoaded(
          wishlist: Wishlist(
            products: [
              Product(
                id: '0',
                name: 'name',
                category: 'category',
                imageUrl: 'https://plus.unsplash.com/premium_photo-1683910767532-3a25b821f7ae?q=80&w=2008&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                price: 10,
                isRecommended: true,
                isPopular: true,
                description: 'default description',
              ),
            ],
          ),
        ),
      );
    } catch (_) {
      emit(WishlistError());
    }
  }

  void _onAddProductToWishlist(
      AddProductToWishlist event,
      Emitter<WishlistState> emit,
      ) async {
    if (state is WishlistLoaded) {
      try {
        // Box box = await _localStorageRepository.openBox();
        // _localStorageRepository.addProductToWishlist(box, event.product);

        emit(
          WishlistLoaded(
            wishlist: Wishlist(
              products:
              List.from((state as WishlistLoaded).wishlist.products)
                ..add(event.product),
            ),
          ),
        );
      } on Exception {
        emit(WishlistError());
      }
    }
  }

  void _onRemoveProductFromWishlist(
      RemoveProductFromWishlist event,
      Emitter<WishlistState> emit,
      ) async {
    if (state is WishlistLoaded) {
      try {
        // Box box = await _localStorageRepository.openBox();
        // _localStorageRepository.removeProductFromWishlist(box, event.product);

        emit(
          WishlistLoaded(
            wishlist: Wishlist(
              products:
              List.from((state as WishlistLoaded).wishlist.products)
                ..remove(event.product),
            ),
          ),
        );
      } on Exception {
        emit(WishlistError());
      }
    }
  }
}
