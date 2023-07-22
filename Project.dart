import 'dart:io';

String space = "*****";
String reminder = "Remember, this software is Case-Sensitive";
void mainMenu() {
  print("What do you want to perform");
  print("Press 1 to perform actions on category");

  print("Press 2 to perform actions on products");

  print("Press 3 to check complaints");

  print("Press 4 to get daily sales report\n");
}

void categoryMenu() {
  print("\nPress 1 to add a category");
  print("Press 2 to remove a category");
  print("Press 3 to update a category");
  print("Press 4 to view categories");
  print("Press 5 to add subCategory");
  print("Press 6 to remove subCategory");
  print("Press 7 to update a subCategory");
  print("Press 8 to view subCategory of a category\n");
  print("Press 0 return to main menu");

  String userInp = stdin.readLineSync()!;
  if (userInp == "0") {
    main();
  }
  if (userInp == "1") {
    createCategory();
    categoryMenu();
  }
  if (userInp == "5") {
    addSubCategory();
    categoryMenu();
  }
  if (userInp == "2") {
    removeCategory();
    categoryMenu();
  }
  if (userInp == "3") {
    updateCategory();
    categoryMenu();
  }
  if (userInp == "4") {
    viewCategories();
    categoryMenu();
  }

  if (userInp == "6") {
    removeSubCategory();
    categoryMenu();
  }

  if (userInp == "7") {
    updateSubCategory();
    categoryMenu();
  }
  if (userInp == "8") {
    viewSubCategories();
    categoryMenu();
  }
}

List<Map<String, dynamic>> category = [];
List<Map<String, dynamic>> subCategories = [];
List<Map<String, dynamic>> products = [];

void createCategory() {
  String categoryId, categoryName;

  print("Enter the new category S.No");
  categoryId = stdin.readLineSync()!;
  bool serialNoExists = category.any((element) => element["id"] == categoryId);
  if (serialNoExists) {
    print("S.No is already in use by another category");
    createCategory();
  } else if (!serialNoExists) {
    print("\nEnter the new category name");
    categoryName = stdin.readLineSync()!;
    bool categoryNameExists =
        category.any((element) => element["name"] == categoryName);
    if (categoryNameExists) {
      print("Category Name is already in use by another category");
      createCategory();
    } else if (!categoryNameExists) {
      Map<String, dynamic> categories = {
        "id": categoryId,
        "name": categoryName,
        "subCategory": []
      };

      category.add(categories);
      print("Category successfully added \n");
      for (var check in category) {
        print(check["name"]);
      }
    }
  }
}

void removeCategory() {
  String categoryId, categoryName;

  print("How do you want to delete the category? By name or by ID");
  String userInp = stdin.readLineSync()!;

  bool categoryFound = false;
  if (userInp.toLowerCase() == "name") {
    print("Enter the name of category, $reminder");
    userInp = stdin.readLineSync()!;

    for (var element in category) {
      if (element["name"] == userInp) {
        categoryFound = true;
        category.remove(element);
        print("Category removed successfully!");
        print(category);
        break;
      }
    }
  }
  if (!categoryFound) {
    print("Category not found, try again");
    removeCategory();
  }
}

void updateCategory() {
  String categoryId, categoryName;

  print("How do you want to search for the category? By name or by ID");
  String userInp = stdin.readLineSync()!;

  bool categoryFound = false;
  if (userInp.toLowerCase() == "name") {
    print(
        "Enter the name of category you want to update, Remember, this program is case sensitive");
    userInp = stdin.readLineSync()!;

    for (var element in category) {
      if (element["name"] == userInp) {
        categoryFound = true;

        String categoryId, categoryName;

        print("What do you want to update, ID or Name?");
        userInp = stdin.readLineSync()!;

        if (userInp.toLowerCase() == "id") {
          print("Enter the new S.Number for updated category");
          categoryId = stdin.readLineSync()!;
          bool serialNoExists =
              category.any((element) => element["id"] == categoryId);
          if (serialNoExists) {
            print("S.No is already in use by another category");
            createCategory();
          }
          if (!serialNoExists) {
            element["id"] = categoryId;
            print("Category updated successfully!");
            print(category);
            break;
          }
        } else if (userInp.toLowerCase() == "name") {
          print("\nEnter the new Name for updated category (Mandatory)");
          categoryName = stdin.readLineSync()!;
          bool categoryNameExists =
              category.any((element) => element["name"] == categoryName);
          if (categoryNameExists) {
            print("Category Name is already in use by another category");
            createCategory();
          }
          if (!categoryNameExists) {
            element["name"] = categoryName;
            print("Category updated successfully!");
            print(category);
            break;
          }
        } else {
          print("wrong input, try again");
          updateCategory();
        }
      }
    }
  }
  if (!categoryFound) {
    print("Category not found, try again");
    updateCategory();
  }
}

void viewCategories() {
  print("Do you want to see full category 'details' or just 'names'");
  String userInp = stdin.readLineSync()!;

  if (userInp.toLowerCase() == "names") {
    for (var element in category) {
      String names = element["name"];
      print("Categories are: $names");
    }
  } else if (userInp.toLowerCase() == "details") {
    print(category);
  } else {
    print("Wrong input, try again");
    viewCategories();
  }
}

void addSubCategory() {
  String subCategoryId, subCategoryName, parentCategoryName;

  print("Enter the new sub category S.No");
  subCategoryId = stdin.readLineSync()!;
  for (var element in category) {
    bool serialNoExists =
        element["subCategory"].any((element) => element["id"] == subCategoryId);
    if (serialNoExists) {
      print("S.No is already in use by another Sub category");
      addSubCategory();
    } else if (!serialNoExists) {
      print("\nEnter the new subcategory name");
      subCategoryName = stdin.readLineSync()!;
      for (var element in category) {
        bool categoryNameExists = element["subCategory"]
            .any((element) => element["name"] == subCategoryName);
        if (categoryNameExists) {
          print(
              "Sub Category Name is already in use by another category or Sub category");
          addSubCategory();
        } else if (!categoryNameExists) {
          Map<String, dynamic> subCategories = {
            "id": subCategoryId,
            "name": subCategoryName,
            "products": [],
          };
          bool parentCategoryExists = false;
          print("\nEnter the parent category name");
          parentCategoryName = stdin.readLineSync()!;
          for (var element in category) {
            if (element["name"] == parentCategoryName) {
              element["subCategory"].add(subCategories);
              parentCategoryExists = true;
              print(category);
            }
          }
          if (!parentCategoryExists) {
            print(
                "$space$space \nCategory not found, try again. Remember this program is case sensitive");
            addSubCategory();
          }
        }
      }
    }
  }
}

void removeSubCategory() {
  String subCategoryId, subCategoryName, parentCategoryName;
  print("How do you want to remove sub category? By name or by ID");
  String userInp = stdin.readLineSync()!;
  if (userInp.toLowerCase() == "name") {
    print("Enter sub category name you want to remove. $reminder");
    subCategoryName = stdin.readLineSync()!;
    print("Enter the parent category name of sub category. $reminder");
    parentCategoryName = stdin.readLineSync()!;

    for (var element in category) {
      for (var element2 in element["subCategory"]) {
        if (element2["name"] == subCategoryName) {
          element["subCategory"].remove(element2);
          print("Category $subCategoryName removed successfully");
          print(category);
          break;
        }
      }
    }
  }
}

void updateSubCategory() {
  String subCategoryId, subCategoryName, parentCategoryName;
  print("How do you want to update sub category? By name or by ID");
  String userInp = stdin.readLineSync()!;

  if (userInp.toLowerCase() == "name") {
    print("Enter sub category name you want to update. $reminder");
    subCategoryName = stdin.readLineSync()!;

    print("Enter the parent category name of sub category. $reminder");
    parentCategoryName = stdin.readLineSync()!;

    for (var element in category) {
    bool parentCategoryExists = element["name"] == parentCategoryName;

    if (parentCategoryExists) {
        for (var element2 in element["subCategory"]) {

    bool subCategoryExists = element["subCategory"]
        .any((element) => element["name"] == subCategoryName);

          if (subCategoryExists) {

            print("What do you want to update, ID or Name?");
            userInp = stdin.readLineSync()!;

            if (userInp.toLowerCase() == "id") {
              print("Enter the new S.Number for updated category");
              subCategoryId = stdin.readLineSync()!;

              bool serialNoExists = element["subCategory"]
                  .any((element) => element["id"] == subCategoryId);

              if (serialNoExists) {
                print("S.No is already in use by another category");
                updateSubCategory();
              } else {
                element2["id"] = subCategoryId;
              }
            } else if (userInp.toLowerCase() == "name") {
              print("\nEnter the new Name for updated Sub category ");
              subCategoryName = stdin.readLineSync()!;

              bool categoryNameExists = element["subCategory"]
                  .any((element) => element["name"] == subCategoryName);

              if (categoryNameExists) {
                print("Category Name is already in use by another category");
                updateSubCategory();
              } else {
                element2["name"] = subCategoryName;
                print("Category updated successfully!");
                print(category);
                break;
              }
            } else {
              print("wrong input, try again.");
              updateSubCategory();
            }
          }else if(!subCategoryExists){
            print("Sub category dosen't exists, try again. $reminder");
            updateSubCategory();
          }
          print(category);
            break;
            
        }
                  
          // break;
      }else if(!parentCategoryExists){
            print("Parent category dosen't exists, try again $reminder");
            categoryMenu();
          }
  }
}
}

void viewSubCategories() {
  print(
      "Do you want to see Sub category 'details' or just sub Category 'names'");
  stdout.write("I want to see ");
  String userInp = stdin.readLineSync()!;

  if (userInp.toLowerCase() == "names") {
    for (var element in category) {
      for (var element2 in element["subCategory"]) {
        String names = element2["name"];
        print("Sub Categories of ${element["name"]} are : $names");
      }
    }
  } else if (userInp.toLowerCase() == "details") {
    for (var element in category) {
      for (var element2 in element["subCategory"]) {
        print("Sub Categories of ${element["name"]} are : $element2");
      }
    }
    // print(category["subCategory"]);
  } else {
    print("Wrong input, try again");
    viewCategories();
  }
}


void productMenu(){
    print("\nPress 1 to add a product");
  print("Press 2 to remove a product");
  print("Press 3 to update a product");
  print("Press 4 to view products");
  int userInp = int.parse(stdin.readLineSync()!);
  switch (userInp) {
    case 1:
      addProduct();
      break;
    case 4:
      viewProducts();
    default:
  }
}

void viewProducts() {
  print("Enter the category name: ");
  String categoryName = stdin.readLineSync()!;

  bool categoryFound = false;
  bool subCategoryFound = false;

  for (var categoryItem in category) {
    if (categoryItem["name"] == categoryName) {
      categoryFound = true;

      print("Enter the subcategory name: ");
      String subCategoryName = stdin.readLineSync()!;

      for (var subCategory in categoryItem["subCategory"]) {
        if (subCategory["name"] == subCategoryName) {
          subCategoryFound = true;

          if (subCategory["products"].isEmpty) {
            print("No products found in this subcategory.");
          } else {
            print("Products in $categoryName - $subCategoryName subcategory:");
            for (var product in subCategory["products"]) {
              print("Product Name: ${product["name"]}, Price: ${product["price"]}, Quantity: ${product["quantity"]}");
            }
          }
          break;
        }
      }
      break;
    }
  }

  if (!categoryFound) {
    print("Category not found.");
    productMenu();
  } else if (!subCategoryFound) {
    print("Subcategory not found.");
    productMenu();
  }
}

void addProduct() {
  String categoryName, subCategoryName, productName, productId;
  double productPrice;
  int productQuantity;

  print("Enter the category name: ");
  categoryName = stdin.readLineSync()!;
  print("Enter the subcategory name: ");
  subCategoryName = stdin.readLineSync()!;

  bool categoryFound = false;
  bool subCategoryFound = false;

  for (var categoryItem in category) {
    if (categoryItem["name"] == categoryName) {
      categoryFound = true;

      for (var subCategory in categoryItem["subCategory"]) {
        if (subCategory["name"] == subCategoryName) {
          subCategoryFound = true;

          print("Enter the product name: ");
          productName = stdin.readLineSync()!;
          print("Enter the product ID: ");
          productId = stdin.readLineSync()!;

          bool productIdExists = subCategory["products"]
              .any((product) => product["id"] == productId);
          if (productIdExists) {
            print("Product ID already exists. Please enter a unique ID.");
            productMenu();
          }

          bool productNameExists = subCategory["products"]
              .any((product) => product["name"] == productName);
          if (productNameExists) {
            print("Product name already exists. Please enter a unique name.");
           productMenu();
          }

          print("Enter the product price: ");
          productPrice = double.parse(stdin.readLineSync()!);
          print("Enter the product quantity: ");
          productQuantity = int.parse(stdin.readLineSync()!);

          Map<String, dynamic> newProduct = {
            "id": productId,
            "name": productName,
            "price": productPrice,
            "quantity": productQuantity,
          };

          subCategory["products"].add(newProduct);

          print("Product added successfully!");
          print(subCategory["products"]);
          main();
        }
      }
      break;
    }
  }

  if (!categoryFound) {
    print("Category not found.");
    productMenu();
  } else if (!subCategoryFound) {
    print("Subcategory not found.");
    productMenu();
  }
}


void main() {
  print("$space Welcome to ADMIN PANEL of Musfir Ecommerce Store $space");

  mainMenu();
  String userInp = stdin.readLineSync()!;
  if (userInp == "1") {
    categoryMenu();
  }
  if (userInp == "2") {
    productMenu();
  }  
}
