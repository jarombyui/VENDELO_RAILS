require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
  # Test para verificar que se renderiza una lista de productos correctamente
  test 'render a list of products' do
    # Solicita la ruta para la lista de productos
    get products_path 
    # Verifica que la respuesta sea exitosa (HTTP 200)
    assert_response :success
    # Verifica que haya exactamente 2 elementos con la clase .product en el HTML renderizado
    assert_select '.product', 2
  end
  # Test para verificar que se renderiza correctamente la página de detalles de un producto
  test 'render a detailed product page' do
    # Solicita la ruta para el producto ps4, usando el fixture
    get product_path(products(:ps4))
    # Verifica que la respuesta sea exitosa (HTTP 200)
    assert_response :success
    # Verifica que el título del producto sea 'PS4 Fat'
    assert_select '.title', 'PS4 Fat'
    # Verifica que la descripción del producto sea 'Ps4 en buen estado'
    assert_select '.description', 'Ps4 en buen estado'
    # Verifica que el precio del producto sea '150$'
    assert_select '.price', '150$'
  end

  test 'render a new product form' do
    get new_product_path

    assert_response :success
    assert_select 'form'

  end

  test 'allow to create a new  product' do
    post products_path, params: {
        product: {
          title: 'Nintendo 64',
          description: 'Le faltan los cables',
          price: 45
        }
    }

    assert_redirected_to products_path
    assert_equal flash[:notice], 'Your product has been created succesfully!'
  end

  test 'does not allow to create a new  product with empty fields' do
    post products_path, params: {
        product: {
          title: '',
          description: 'Le faltan los cables',
          price: 45
        }
    }

    assert_response :unprocessable_entity
  end
  
end
