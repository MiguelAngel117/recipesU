import 'package:recipes/models/recipe_model.dart';

class Recipe {
  final String name;
  final String image;
  final String? userImage;
  final String? userName;
  final List<String> ingredients;
  final List<String> steps;

  const Recipe({
    this.userImage,
    this.userName,
    required this.name,
    required this.image,
    required this.ingredients,
    required this.steps,
  });

  factory Recipe.fromRecipeModel(RecipeModel model) {
    return Recipe(
        name: model.name,
        image: model.imagePath.isEmpty
            ? 'assets/images/food.jpeg'
            : model.imagePath,
        ingredients: [
          '500g de harina',
          '300ml de agua',
          '10g de sal',
          '20g de levadura fresca',
          '200g de salsa de tomate',
          '200g de mozzarella',
          'Aceite de oliva',
          'Ingredientes al gusto (jamón, champiñones, aceitunas, etc.)',
        ], // Rellenar con datos o dejar vacío según sea necesario
        steps: [
          'Mezclar la harina, la sal y la levadura en un bol grande.',
          'Añadir el agua y el aceite, y amasar hasta obtener una masa homogénea.',
          'Dejar reposar la masa durante 1 hora.',
          'Extender la masa y agregar la salsa de tomate.',
          'Añadir la mozzarella y los ingredientes al gusto.',
          'Hornear a 220°C durante 15-20 minutos.',
        ] // Rellenar con datos o dejar vacío según sea necesario
        );
  }
}

class RecipeList {
  final listFood = const [
    Recipe(
      name: 'Pizza',
      image: 'assets/images/pizza-created-with-generative-ai-png.png',
      userImage: 'assets/user.webp',
      userName: 'John Doe',
      ingredients: [
        '500g de harina',
        '300ml de agua',
        '10g de sal',
        '20g de levadura fresca',
        '200g de salsa de tomate',
        '200g de mozzarella',
        'Aceite de oliva',
        'Ingredientes al gusto (jamón, champiñones, aceitunas, etc.)',
      ],
      steps: [
        'Mezclar la harina, la sal y la levadura en un bol grande.',
        'Añadir el agua y el aceite, y amasar hasta obtener una masa homogénea.',
        'Dejar reposar la masa durante 1 hora.',
        'Extender la masa y agregar la salsa de tomate.',
        'Añadir la mozzarella y los ingredientes al gusto.',
        'Hornear a 220°C durante 15-20 minutos.',
      ],
    ),
    Recipe(
      name: 'Hamburguesa',
      image: 'assets/images/cute-cartoon-burger-icon-free-png.png',
      userImage: 'assets/user.webp',
      userName: 'John Doe',
      ingredients: [
        '400g de carne molida',
        '4 panes para hamburguesa',
        'Sal y pimienta al gusto',
        'Queso cheddar',
        'Lechuga',
        'Tomate',
        'Cebolla',
        'Ketchup y mostaza',
      ],
      steps: [
        'Formar las hamburguesas con la carne molida y sazonar con sal y pimienta.',
        'Cocinar las hamburguesas en una sartén o parrilla hasta que estén doradas.',
        'Tostar ligeramente los panes.',
        'Colocar la carne en el pan y añadir el queso cheddar.',
        'Agregar lechuga, tomate y cebolla.',
        'Servir con ketchup y mostaza al gusto.',
      ],
    ),
    Recipe(
      name: 'Sushi',
      image: 'assets/images/sushi-with-ai-generated-free-png.png',
      userImage: 'assets/user.webp',
      userName: 'John Doe',
      ingredients: [
        '300g de arroz para sushi',
        'Nori (algas secas)',
        '100g de salmón fresco',
        'Aguacate',
        'Pepino',
        'Vinagre de arroz',
        'Salsa de soja',
      ],
      steps: [
        'Cocinar el arroz para sushi y mezclar con vinagre de arroz.',
        'Colocar una hoja de nori sobre una esterilla de bambú.',
        'Extender el arroz sobre el nori.',
        'Añadir tiras de salmón, aguacate y pepino.',
        'Enrollar firmemente y cortar en piezas.',
        'Servir con salsa de soja.',
      ],
    ),
    Recipe(
      name: 'Tacos',
      image: 'assets/images/tacos-with-ai-generated-free-png.png',
      userImage: 'assets/user.webp',
      userName: 'John Doe',
      ingredients: [
        '300g de carne de res',
        'Tortillas de maíz',
        'Cebolla',
        'Cilantro',
        'Limón',
        'Salsa picante',
      ],
      steps: [
        'Cocinar la carne de res en una sartén hasta que esté dorada.',
        'Calentar las tortillas de maíz.',
        'Rellenar las tortillas con la carne.',
        'Añadir cebolla, cilantro y un poco de jugo de limón.',
        'Servir con salsa picante al gusto.',
      ],
    ),
    Recipe(
      name: 'Pasta Carbonara',
      image:
          'assets/images/spaghetti-carbonara-isolated-on-transparent-background-file-cut-out-ai-generated-png.png',
      userImage: 'assets/user.webp',
      userName: 'John Doe',
      ingredients: [
        '200g de espaguetis',
        '100g de panceta',
        '2 yemas de huevo',
        '50g de queso parmesano',
        'Sal y pimienta',
        'Aceite de oliva',
      ],
      steps: [
        'Cocinar los espaguetis en agua con sal hasta que estén al dente.',
        'Freír la panceta en una sartén con un poco de aceite de oliva.',
        'Mezclar las yemas de huevo con el queso parmesano en un bol.',
        'Añadir los espaguetis y la panceta a la mezcla de huevo y queso.',
        'Mezclar bien y sazonar con sal y pimienta.',
      ],
    ),
    Recipe(
      name: 'Paella',
      image: 'assets/images/spanish-paella-isolated-ai-generated-png.png',
      userImage: 'assets/user.webp',
      userName: 'John Doe',
      ingredients: [
        '400g de arroz',
        '200g de pollo',
        '200g de mariscos mixtos',
        '1 pimiento rojo',
        '1 tomate',
        'Azafrán',
        'Caldo de pollo',
        'Aceite de oliva',
      ],
      steps: [
        'Calentar el aceite en una paellera y dorar el pollo.',
        'Añadir el pimiento y el tomate picados.',
        'Incorporar el arroz y mezclar con los ingredientes.',
        'Añadir el caldo de pollo caliente y el azafrán.',
        'Cocinar a fuego lento hasta que el arroz esté en su punto.',
        'Añadir los mariscos en los últimos minutos de cocción.',
      ],
    ),
    Recipe(
      name: 'Ensalada César',
      image:
          'assets/images/caesar-salad-with-chicken-on-a-white-plate-illustration-generative-ai-png.png',
      userImage: 'assets/user.webp',
      userName: 'John Doe',
      ingredients: [
        'Lechuga romana',
        '100g de pechuga de pollo',
        'Pan tostado (crutones)',
        'Queso parmesano',
        'Salsa César',
        'Aceite de oliva',
        'Sal y pimienta',
      ],
      steps: [
        'Cortar la lechuga y colocarla en un bol grande.',
        'Cocinar la pechuga de pollo a la parrilla y cortarla en tiras.',
        'Añadir el pollo, los crutones y el queso parmesano a la lechuga.',
        'Aliñar con salsa César y un poco de aceite de oliva.',
        'Mezclar bien y sazonar con sal y pimienta.',
      ],
    ),
    Recipe(
      name: 'Ramen',
      image:
          'assets/images/asian-noodle-soup-ramen-with-chicken-vegetables-and-egg-in-black-bowl-isolated-on-white-transparent-background-ai-generate-png.png',
      userImage: 'assets/user.webp',
      userName: 'John Doe',
      ingredients: [
        '200g de fideos de ramen',
        '500ml de caldo de pollo',
        '100g de cerdo chashu',
        'Huevo cocido',
        'Cebollino picado',
        'Salsa de soja',
        'Aceite de sésamo',
      ],
      steps: [
        'Cocinar los fideos de ramen según las instrucciones del paquete.',
        'Calentar el caldo de pollo en una olla grande.',
        'Añadir el cerdo chashu y un poco de salsa de soja al caldo.',
        'Servir los fideos en un bol y verter el caldo caliente por encima.',
        'Añadir el huevo cocido y el cebollino picado.',
        'Rociar con un poco de aceite de sésamo antes de servir.',
      ],
    ),
    Recipe(
      name: 'Empanadas',
      image: 'assets/images/empanada-pastry-stuffed-food-png.png',
      userImage: 'assets/user.webp',
      userName: 'John Doe',
      ingredients: [
        '500g de masa para empanadas',
        '300g de carne picada',
        '1 cebolla',
        'Huevo duro',
        'Aceitunas',
        'Aceite',
        'Sal y pimienta',
      ],
      steps: [
        'Sofreír la cebolla picada en una sartén con aceite.',
        'Añadir la carne picada y cocinar hasta que esté dorada.',
        'Agregar las aceitunas y el huevo duro picado.',
        'Rellenar la masa para empanadas con la mezcla de carne.',
        'Cerrar las empanadas y sellarlas con un tenedor.',
        'Hornear a 180°C durante 20-25 minutos o hasta que estén doradas.',
      ],
    ),
    Recipe(
      name: 'Brownie',
      image: 'assets/images/brownie-with-ai-generated-free-png.png',
      userImage: 'assets/user.webp',
      userName: 'John Doe',
      ingredients: [
        '200g de chocolate negro',
        '150g de mantequilla',
        '200g de azúcar',
        '3 huevos',
        '100g de harina',
        'Nueces (opcional)',
      ],
      steps: [
        'Derretir el chocolate y la mantequilla a baño maría.',
        'Añadir el azúcar y mezclar bien.',
        'Incorporar los huevos uno a uno, batiendo después de cada adición.',
        'Agregar la harina tamizada y mezclar hasta obtener una masa homogénea.',
        'Añadir las nueces si se desea.',
        'Verter la mezcla en un molde engrasado y hornear a 180°C durante 25-30 minutos.',
      ],
    ),
    Recipe(
      name: 'Panqueques',
      image: 'assets/images/pancake-dessert-bakery-ai-generate-png.png',
      userImage: 'assets/user.webp',
      userName: 'John Doe',
      ingredients: [
        '200g de harina',
        '2 huevos',
        '300ml de leche',
        '50g de mantequilla',
        '1 cucharada de azúcar',
        'Una pizca de sal',
        'Miel o sirope (para servir)',
      ],
      steps: [
        'Mezclar la harina, el azúcar y la sal en un bol grande.',
        'Añadir los huevos y la leche, y batir hasta obtener una mezcla suave.',
        'Incorporar la mantequilla derretida y mezclar bien.',
        'Calentar una sartén antiadherente y verter un poco de la mezcla.',
        'Cocinar hasta que aparezcan burbujas en la superficie, luego voltear y cocinar hasta que estén dorados.',
        'Servir con miel o sirope al gusto.',
      ],
    ),
  ];
}
