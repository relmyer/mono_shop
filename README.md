# Mono Shop 🛍️

A professional Flutter e-commerce app with clean architecture, built as a portfolio/graduation project.

## Features

- **Home Screen** – Animated banner slider, 8-category grid, recommended products
- **Catalog Screen** – Sort tabs (Popular/Latest/Best Sellers/Price), category chips, product grid, filter bottom sheet
- **Product Detail Screen** – Image gallery with thumbnails, size selector, quantity stepper, add to cart & buy now

## Tech Stack

| Package | Purpose |
|---------|---------|
| Flutter 3.29.1 | Framework |
| go_router | Navigation |
| provider | State management (Cart) |
| google_fonts | Poppins typography |
| cached_network_image | Image caching |
| flutter_rating_bar | Star ratings |
| flutter_svg | SVG support |

## Architecture

```
lib/
├── core/
│   ├── theme/         # Colors, TextStyles, Spacing, Theme
│   ├── routing/       # GoRouter configuration
│   └── utils/         # Formatters
├── data/
│   ├── mock/          # 12 mock products with Unsplash images
│   └── repositories/  # ProductRepository (search, sort, filter)
├── models/            # Product, Category models with fromJson/toJson
├── features/
│   └── catalog/
│       ├── screens/   # HomeScreen, CatalogScreen, ProductDetailScreen
│       ├── widgets/   # AppSearchBar, HomeBanner, CategoryGrid, ProductCard...
│       └── state/     # CartState (ChangeNotifier)
└── shared/
    ├── widgets/       # PrimaryButton, AppOutlineButton, SectionHeader
    └── constants/     # Asset paths
```

## Design System

| Token | Value |
|-------|-------|
| Primary | `#E84D4D` |
| Background | `#FAFAFA` |
| Surface | `#FFFFFF` |
| Text | `#111111` |
| Muted Text | `#7A7A7A` |
| Border | `#EDEDED` |
| Card Radius | `16px` |
| Spacing Scale | `4 / 8 / 12 / 16 / 24 / 32px` |

## Getting Started

```bash
git clone https://github.com/relmyer/mono-shop.git
cd mono-shop
flutter pub get
flutter run
```
